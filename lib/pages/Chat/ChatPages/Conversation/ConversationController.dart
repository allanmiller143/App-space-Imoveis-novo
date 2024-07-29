import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:space_imoveis/config/controllers/Chat_Socket_Controller.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/Chat/ChatService/ChatApi.dart';
import 'package:space_imoveis/pages/Chat/Components/TextSender/AudioSender.dart';
import 'package:space_imoveis/pages/Chat/Components/TextSender/SoundPlayer.dart';
import 'package:space_imoveis/services/notifications/firebase_notification.dart';

class ConversationController extends GetxController {
  MyGlobalController myGlobalController = Get.find();
  Chat_Socket_Controller chat_socket_controller = Get.find();
  var user = Get.arguments[0];
  var imageFiles = <XFile>[].obs;
  final ImagePicker picker = ImagePicker();
  final recorder  = SoundRecorder();
  final player = SoundPlayer();

  var newMessage = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
    recorder.init();
    player.init();
    init();
  }


  @override
  void dispose() {
    super.dispose();
    recorder.dispose();
    player.dispose();
  }



  init() async {
    final ChatService chatService = Get.find();

    final email = user['email'];
    final fetchedMessages = await chatService.openNewChat(email);
    chat_socket_controller.messages.assignAll(fetchedMessages); // Atualiza a lista de mensagens
    chat_socket_controller.messages.value = chat_socket_controller.messages.reversed.toList();
    return chat_socket_controller.messages;
  }

  void sendMessage(String message) async {
      final ChatService chatService = Get.find();
      chatService.sendMessage(message);
      String token =  user['idPhone'] ?? '';
      print('phonetoken: $token');
      if(token != '') {
        FirebaseNotification firebaseNotification = FirebaseNotification();
        await firebaseNotification.initMessaging();

        String userName = myGlobalController.userInfo['type'] != 'realstate' ? myGlobalController.userInfo['name'] : myGlobalController.userInfo['company_name'];
        await firebaseNotification.send(token, '$userName', message);
      }                             
    }

    Future<void> pickImages() async {
      final List<XFile>? selectedImages = await picker.pickMultiImage();
      imageFiles.clear();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        imageFiles.addAll(selectedImages);
      }
    }

    void removeImage(int index) {
      imageFiles.removeAt(index);
    }

    void sendImg() async {
      final ChatService chatService = Get.find();
      chatService.sendImg(imageFiles);
      String token =  user['idPhone'] ?? '';
      print('phonetoken: $token');
      if(token != '') {
        FirebaseNotification firebaseNotification = FirebaseNotification();
        await firebaseNotification.initMessaging();

        String userName = myGlobalController.userInfo['type'] != 'realstate' ? myGlobalController.userInfo['name'] : myGlobalController.userInfo['company_name'];
        await firebaseNotification.send(token, '$userName', 'Imagem');
      }                             
    }

    sendAudio() async {
      final ChatService chatService = Get.find();
      chatService.sendAudio();
      String token =  user['idPhone'] ?? '';
      if(token != '') {
        FirebaseNotification firebaseNotification = FirebaseNotification();
        await firebaseNotification.initMessaging();

        String userName = myGlobalController.userInfo['type'] != 'realstate' ? myGlobalController.userInfo['name'] : myGlobalController.userInfo['company_name'];
        await firebaseNotification.send(token, '$userName', 'mensagem de áudio');
      }                             
    }

}

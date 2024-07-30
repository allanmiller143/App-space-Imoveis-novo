import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:space_imoveis/config/controllers/Chat_Socket_Controller.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/Chat/ChatService/ChatApi.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/AudioMessage/AudioSender.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/FileMessage/FileBottomSheet.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/AudioMessage/SoundPlayer.dart';
import 'package:space_imoveis/services/notifications/firebase_notification.dart';
import 'package:file_picker/file_picker.dart';

class ConversationController extends GetxController {
  MyGlobalController myGlobalController = Get.find();
  RxBool showAudioButtom = false.obs;
  Chat_Socket_Controller chat_socket_controller = Get.find();
  var user = Get.arguments[0];
  var imageFiles = <XFile>[].obs;
  final ImagePicker picker = ImagePicker();
  RxList<PlatformFile> selectedFiles = <PlatformFile>[].obs;
  String? audioFilePath;

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

Future<void> pickFiles() async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx', 'txt'], // Adicione as extensões de arquivo desejadas
  );

  if (result != null) {
    selectedFiles.clear();
    selectedFiles.addAll(result.files);

    // Chama a função para abrir o BottomSheet
    showFilePreview();
  } else {
    // Handle file picker cancellation
    selectedFiles.clear();
  }
}

void showFilePreview() {
  Get.bottomSheet(
    FilePreviewBottomSheet(),
    isScrollControlled: true,
  );
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

    void sendFile() async {
      final ChatService chatService = Get.find();
      chatService.sendFile(selectedFiles);
      String token =  user['idPhone'] ?? '';
      if(token != '') {
        FirebaseNotification firebaseNotification = FirebaseNotification();
        await firebaseNotification.initMessaging();

        String userName = myGlobalController.userInfo['type'] != 'realstate' ? myGlobalController.userInfo['name'] : myGlobalController.userInfo['company_name'];
        await firebaseNotification.send(token, '$userName', 'mensagem de Arquivo');
      }                             
    }

}

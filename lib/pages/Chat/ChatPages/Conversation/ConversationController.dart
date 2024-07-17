import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/Chat_Socket_Controller.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/Chat/ChatService/ChatApi.dart';
import 'package:space_imoveis/services/notifications/firebase_notification.dart';

class ConversationController extends GetxController {
  MyGlobalController myGlobalController = Get.find();
  Chat_Socket_Controller chat_socket_controller = Get.find();
  var user = Get.arguments[0];
  
  var newMessage = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
    init();
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
      FirebaseNotification firebaseNotification = FirebaseNotification();
      await firebaseNotification.initMessaging();
      String token = 'dUimmvC6SruSM4glr7ZY8O:APA91bFUxNtqTi83l9O-DIxfEjArcwS0PELPjKh2_S0NpcgCupsnPL4tOXOKE7IG2Rpm6IqkIl6-MbXsSbJy5rBFLC-0NJ77fEZ0V6Dky4mJ7eVJH-BMNveTo5_Og4IiEB1yoCT8B4xP'; // Substitua pelo token do dispositivo do usuário
      String userName = myGlobalController.userInfo['type'] != 'realstate' ? myGlobalController.userInfo['name'] : myGlobalController.userInfo['company_name'];
      await firebaseNotification.send(token, '$userName', message);
                                   
    }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/Chat_Socket_Controller.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/Chat/ChatService/ChatApi.dart';

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

  void sendMessage(String message) {
      final ChatService chatService = Get.find();
      chatService.sendMessage(message);

    }

}

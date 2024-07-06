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

      // Captura o tamanho inicial das mensagens

      // Obtém uma referência para o socket
      //final socket = chat_socket_controller.socket;

      // Define um listener para o evento 'message'
      // void handleMessage(data) {
      //   // Adiciona a mensagem no início da lista
      //   messages.insert(0, data);
      //   messagesSize.value = messages.length;
      //   print(messages.length);

      //   // Remove o listener após adicionar a mensagem
      //   if (messages.length > initialMessagesLength) {
      //     socket.off('message', handleMessage);
      //   }
      // }

      // Adiciona o listener ao evento 'message'
      //socket.on('message', handleMessage);
    }

}

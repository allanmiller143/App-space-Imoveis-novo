import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/ConversationController.dart';
import 'package:space_imoveis/pages/Chat/Components/Message.dart';

class ConversationPage extends StatelessWidget {
  ConversationPage({Key? key}) : super(key: key);
  final controller = Get.put(ConversationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.myGlobalController.color,
      body: FutureBuilder(
        future: controller.init(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.init();
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 14),
                          ),
                          Text(
                            controller.user['type'] != 'realstate' ?  controller.user['name'] : controller.user['companyName'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Obx(
                          () => controller.chat_socket_controller.messagesSize.value != -1
                              ? ListView.builder(
                                  reverse: true, 
                                  itemCount: controller.chat_socket_controller.messages.length,
                                  itemBuilder: (context, index) {
                                    final message = controller.chat_socket_controller.messages[index];
                                    final picture = (message['senderProfile']['url'] != null && message['senderProfile']['url'] != '')
                                        ? message['senderProfile']['url']
                                        : '';
                                    final sender = message['sender'] == controller.myGlobalController.userInfo['email'];
                                    if (sender) {
                                      return ChatMessageSenderWidget(message: message['text'], horaMinuto: '', url: picture);
                                    } else {
                                      return ChatMessageReceiverWidget(message: message['text'], horaMinuto: '', url: picture);
                                    }
                                  },
                                )
                              : Container(),
                        ),
                      ),
                    ),
                    Container(
                      color: controller.myGlobalController.color,
                      padding: const EdgeInsets.all(10),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 35,
                          margin: const EdgeInsets.fromLTRB(10,0,0,0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(137, 255, 255, 255),
                          ),
                          child: 
                            Expanded(
                              child: TextFormField(
                                controller: controller.newMessage,
                                cursorColor: controller.myGlobalController.color3,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0,18),
                                  hintText: 'Escreva uma mensagem',
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: controller.myGlobalController.color3,
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: Container(
                                    decoration: BoxDecoration(
                                      color: controller.myGlobalController.color3,
                                      borderRadius: BorderRadius.only(
                                        topRight:   Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      )
                                    ),
                                    child: IconButton(
                                      iconSize: 15,
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      onPressed: () {
                                        final message = controller.newMessage.text.trim();
                                        if (message.isNotEmpty) {
                                          controller.sendMessage(message);
                                          controller.newMessage.clear();
                                        }
                                      },
                                      icon: const Icon(Icons.send),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            
                          
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Ocorreu um erro inesperado'));
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 253, 72, 0),
              ),
            );
          }
        },
      ),
    );
  }
}

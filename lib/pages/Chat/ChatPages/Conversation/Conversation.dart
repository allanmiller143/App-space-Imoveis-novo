import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/ConversationController.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/TextMessage/Message.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/AudioMessage/AudioMessageReceiver.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/AudioMessage/AudioMessageSender.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/FileMessage/FileMessage.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/ImgMessage/ImgMessage.dart';
import 'package:space_imoveis/pages/Chat/Components/TextSender/TextSender.dart';

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
                            controller.user['type'] != 'realstate' ?  controller.user['name'] : controller.user['company_name'],
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
                                    final picture = (message['senderProfile'] != null && message['senderProfile']['url'] != null && message['senderProfile']['url'] != '')
                                        ? message['senderProfile']['url']
                                        : '';
                                    final sender = message['sender'] == controller.myGlobalController.userInfo['email'];
                                    final messageType = message['type'];
                                    final messageUrl = message['url'] ?? '';
                                    var time = message['createdAt'];

                                    // Convertendo a variável 'time' para hora e minuto no fuso horário do Brasil
                                    String formattedTime = formatDateToBrazilTime(time);

                                    if (sender) {
                                      if(messageType == 'text'){
                                        return ChatMessageSenderWidget(message: message['text'], horaMinuto: formattedTime, url: picture);
                                      }else if(messageType == 'image'){
                                        return ChatImgMessageSenderWidget(message: message['text'], horaMinuto: formattedTime, url: picture, imgUrl: messageUrl  );
                                      }
                                      else if(messageType == 'audio'){
                                        return ChatAudioMessageSenderWidget(audioUrl: messageUrl,horaMinuto: formattedTime,url: picture,);                                  
                                      }else if(messageType == 'file'){
                                        return ChatFileMessageSenderWidget(fileUrl: messageUrl,horaMinuto: formattedTime,url: picture,fileName: message['fileName']);  
                                      }
                                    } else {
                                      if(messageType == 'text'){
                                        return ChatMessageReceiverWidget(message: message['text'], horaMinuto: formattedTime, url: picture);
                                      }else if(messageType == 'image'){
                                        return ChatImgMessageReceiverWidget(message: message['text'], horaMinuto: formattedTime, url: picture, imgUrl: messageUrl  );
                                      }
                                      else if(messageType == 'audio'){
                                        return ChatAudioMessageReceiverWidget(audioUrl: messageUrl,horaMinuto: formattedTime,url: picture,);  
                                      }else if(messageType == 'file'){
                                        return ChatFileMessageReceiverWidget(fileUrl: messageUrl,horaMinuto: formattedTime,url: picture,fileName: message['fileName']);  
                                      }
                                    }
                                    return null;
                                  },
                                )
                              : Container(),
                        ),
                      ),
                    ),
                    ChatTextSender(),
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

  // Function to convert time to Brazil time zone and format it
  String formatDateToBrazilTime(String time) {
    DateTime dateTime = DateTime.parse(time).toLocal(); // Parse and convert to local time
    var brTime = dateTime.toUtc().add(Duration(hours: -3)); // Adjust for Brazil time zone (UTC-3)
    return DateFormat('HH:mm').format(brTime); // Format to hour and minute
  }
}

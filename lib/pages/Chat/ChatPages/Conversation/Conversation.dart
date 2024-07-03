import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/inser_property_components/mandatory.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/ConversationController.dart';
import 'package:space_imoveis/pages/Chat/Components/ChatItem.dart';

class ConversationPage extends StatelessWidget {
  ConversationPage({Key? key}) : super(key: key);
  final controller = Get.put(ConversationController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 9, 47, 70),
      body: FutureBuilder(
        future: controller.init(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  controller.init(context);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: Column(
                          children: [
                            MandatoryOptional(
                              text: controller.user['email'],
                              subtext: controller.chats.length.toString(),
                              subtext2: '',
                            ),
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: controller.chats.length,
                                itemBuilder: (context, index) {
                                  final chat = controller.chats[index];
                                  return ConversationItem(data: chat);
                                },
                              ),
                            ),
                              
                     
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: const Text('Ocorreu um erro inesperado'));
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




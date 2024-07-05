import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Chats/ChatsController.dart';
import 'package:space_imoveis/pages/Chat/Components/ChatItem.dart';
import 'package:space_imoveis/pages/Chat/Components/Search.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({Key? key}) : super(key: key);
  final controller = Get.put(ChatsPageController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 9, 47, 70),
      body: Obx(() {
        if (controller.chats.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 253, 72, 0),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.init();
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.searchBar.value == false
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  'Chats',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Search(),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(30)),
                          child: IconButton(
                              onPressed: () {
                                controller.searchBar.value = !controller.searchBar.value;
                                if (!controller.searchBar.value) {
                                  controller.tempChats.assignAll(controller.chats);
                                }
                              },
                              icon: Icon(
                                Icons.search,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Obx(
                      () => ListView.builder(
                        controller: scrollController,
                        itemCount: controller.tempChats.length,
                        itemBuilder: (context, index) {
                          final chat = controller.tempChats[index];
                          return ConversationItem(data: chat);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

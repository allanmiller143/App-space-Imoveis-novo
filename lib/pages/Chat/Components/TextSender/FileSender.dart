import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/ConversationController.dart';

Widget FileSender() {
  ConversationController controller = Get.find();

  return GestureDetector(
    onTap: () async {
      await controller.pickFiles();
    },
    child: Container(
      margin: EdgeInsets.only(left: 10),
      child: Icon(Icons.file_copy, color: Colors.white),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Chats/ChatsController.dart';

class Search extends StatelessWidget {
  final MyGlobalController myGlobalController = Get.find();
  ChatsPageController cpc = Get.find();

  Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(25),
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2), // Adjust padding here
        child: TextFormField(
          cursorColor: const Color.fromARGB(255, 71, 71, 71),
          onChanged: (value) {
            cpc.search(value);
          },
          style: TextStyle(
            fontSize: 14, // Adjust font size here if needed
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Procurar um contato',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 72, 68, 68),
              fontSize: 12, // Adjust font size here
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10), // Reduce content padding
          ),
        ),
      ),
    );
  }
}

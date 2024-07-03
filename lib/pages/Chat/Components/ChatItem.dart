import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';


class ConversationItem extends StatelessWidget {
  final Map<String, dynamic> data;

  final MyGlobalController myGlobalController = Get.find();

  ConversationItem({required this.data});

  @override
  Widget build(BuildContext context) {
        var user = data['user1']['email'] == myGlobalController.userInfo['email'] ? data['user2'] : data['user1'];
        return GestureDetector(
          onTap: () {
            Get.toNamed('/chat_conversation', arguments: [user]);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundImage: user['profile'] != null &&
                      user['profile']['url'] != ''
                  ? NetworkImage(
                      user['profile']['url'],
                    ) as ImageProvider<Object>
                  : AssetImage(
                      'assets/imgs/logo.png',
                    ),
                radius: 25,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      user['type'] != 'realstate'? user['name'] : user['company_name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
  }
}

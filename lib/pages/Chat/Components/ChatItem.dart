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
        return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,20),
      child: GestureDetector(
        onTap: () async{
          Get.toNamed('/chat_conversation', arguments: [user]);
          print(user);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              CircleAvatar(
                backgroundImage: user['profile'] != null &&
                      user['profile']['url'] != ''
                  ? NetworkImage(
                      user['profile']['url'],
                    ) as ImageProvider<Object>
                  : AssetImage(
                      'assets/imgs/logo.png',
                    ),
                radius: 30,
              ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    Text(
                      user['type'] != 'realstate'? user['name'] : user['company_name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14
                      ),
                    ),

                    user['type'] != ''?
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        'Digite uma mensagem',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // Adicione essa linha
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                    ):
                    Text(
                      'Digite uma mensagem',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 12
                      ),
                    ),
                  ],
                ),
              ],
            ),
            user['type'] != ''?
            Text(
              '00:00AM',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12
              ),
            ):
            SizedBox()
          ],
        ),
      ),
    );
  }
}

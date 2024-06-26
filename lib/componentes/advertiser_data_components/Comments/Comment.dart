import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/Comments/CommentsController.dart';
import 'package:space_imoveis/componentes/global_components/rating.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class Comment extends StatelessWidget {
  Map<String, dynamic> commnentData;
  Comment({
    Key? key,
    required this.commnentData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyGlobalController mgc = Get.find();
    CommentsController cc = Get.find();
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 8,
                     backgroundImage: commnentData['sender']['profile'] != null &&
                            commnentData['sender']['profile']['url'] != ''
                      ? NetworkImage(
                          commnentData['sender']['profile']['url'],
                        ) as ImageProvider<Object>
                      : AssetImage(
                          'assets/imgs/logo.png',
                        ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    commnentData['sender']['name'],
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(width: 4),
                  Rating(
                    rating: commnentData['rating'] is int? commnentData['rating'].toDouble() : double.parse(commnentData['rating'].toString()),             
                    size: 13,
                  ),
                ],
              ),
              Spacer(),

              mgc.userInfo['email'] == commnentData['sender']['email'] ?
              GestureDetector(
                onTap: () {
                  cc.deleteComment(commnentData['id']);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 0.5,
                      color:Color.fromARGB(112, 244, 67, 54),

                    )
                  ),
                  child: Text(
                    'Apagar',
                    style: TextStyle(
                      color:Color.fromARGB(255, 0, 0, 0),
                      fontSize: 8,
                    ),
                  ),
                ),
              ):Container()
            ],
          ),
          ExpandableText(
            commnentData['comment'],
            expandText: 'ver mais',
            collapseText: 'ver menos',
            maxLines: 3,
            linkColor: Colors.blue, // Use a cor definida no seu controlador global
            style: TextStyle( 
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),       
          ),
        ],
      ),
    );
  }
}

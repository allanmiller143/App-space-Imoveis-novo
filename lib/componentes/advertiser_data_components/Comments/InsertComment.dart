import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/Comments/CommentsController.dart';
import 'package:space_imoveis/componentes/global_components/rating.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class InsertComment extends StatelessWidget {
  const InsertComment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyGlobalController mgc = Get.find();
    CommentsController cc = Get.find();
    RxInt limit = 0.obs;

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 8,
                backgroundImage: cc.myGlobalController.userInfo != null && cc.myGlobalController.userInfo['profile'] != null &&
                      cc.myGlobalController.userInfo['profile']['url'] != ''
                  ? NetworkImage(
                      cc.myGlobalController.userInfo['profile']['url'],
                    ) as ImageProvider<Object>
                  : AssetImage(
                      'assets/imgs/logo.png',
                    ),
              ),
              SizedBox(width: 4),
              Text(
                cc.myGlobalController.userInfo == null ? '' :  cc.myGlobalController.userInfo['type'] == 'realstate' ? cc.myGlobalController.userInfo['company_name'] : cc.myGlobalController.userInfo['name'],
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: cc.newComment,
                style: TextStyle(fontSize: 10),
                maxLength: 500, // Limite de caracteres
                maxLines: null, // Permite quebrar a linha
                onChanged: (value) {
                  limit.value = cc.newComment.text.length;
                },
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),     
                  label: Text(
                    'Escreva um comentário',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 0.5),
                  ),
                  counterText: '', // Remove o contador padrão
                  
                ),
              ),
              Obx(()=>Text( limit.value.toString() + '/500',style: TextStyle(fontSize: 10),)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Rating(rating: cc.newRate, write: true,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          cc.newComment.text = '';
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        ),
                        child: const Text('Cancelar', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 10)),
                      ),
                      GestureDetector(
                        onTap: () {
                          if(cc.myGlobalController.userInfo == null){
                            mySnackBar('Realize o login para comentar', true);
                          }else{
                            cc.postComment();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: mgc.color,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'Comentar',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

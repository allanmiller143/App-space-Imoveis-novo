// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';

class CommentsController extends GetxController {
  final String email;

  // Construtor para aceitar parâmetros
  CommentsController(this.email);
  late MyGlobalController myGlobalController;
  TextEditingController newComment = TextEditingController();
  double newRate = 0;
  List commets = [];
  RxInt totalComments = 0.obs;
  RxBool loading = true.obs;
  RxBool loadingcomments = false.obs;
  RxInt currentPage = 0.obs;

  @override
  void onInit()async {   
    myGlobalController = Get.find();
    await getCommnets(true);
    super.onInit();
  }

  getCommnets(bool init) async{
    try{
      if(init){
        loading.value = true; 
      } else{
        loadingcomments.value = true;
      }
    
     var response = await get('rating/${email}?page=${currentPage.value + 1}');
      if(response['status'] == 200 || response['status'] == 201){  
        commets = response['data']['result'];
        totalComments.value = response['data']['pagination']['total'];
        print('coments: ${totalComments.value}');
      }
    } catch(error){
      print('cai no catch');
    }finally{
      if(init){
        loading.value = false; 
      } else{
        loadingcomments.value = false;
      }
    }
  }

  postComment() async {
    if(newComment.text.isEmpty ){
      mySnackBar('Para comentar escreva algo!!!', false);
    }else if(newRate == 0){
      mySnackBar('Para comentar escolha uma nota!!!', false);
    }else{
      loadingcomments.value = true;
      try {
        var data = {
          'senderEmail': myGlobalController.userInfo['email'],
          'receiverEmail' : 'allan.miller@upe.br',
          'rate' : newRate,
          'comment': newComment.text
        };
        var response = await post('rating', data , token : myGlobalController.token);
        if(response['status'] == 200 || response['status'] == 201){
          await getCommnets(false);
          newComment.clear();
          newRate = 0;
        }
        else{
          print('deu algun erro enviar o comentário');

        }
      }catch(e){
        print(e);
      }
      finally{
        loadingcomments.value = false;
      }
    }
  }

  deleteComment(String id) async{
    try{
      var response = await delete('rating/$id', myGlobalController.token);
      if(response['status'] == 200 || response['status'] == 204){
        print('Deletei o comentario com o id $id');
        await getCommnets(false);
      }else{
        print('deu algum erro');
      }
    }catch(e){
      print(e);
    }
  }
}


// ignore_for_file: unnecessary_overrides, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class WhoAreYouPageController extends GetxController {
  RxString selectedUserType = ''.obs;
  late MyGlobalController myGlobalController;


  nextStep(){
    if(selectedUserType.value == ''){
      Get.snackbar(
        "Aviso",
        'Antes de prosseguir selecione um tipo de usuário',
        backgroundColor:const Color.fromARGB(255, 235, 166, 17),
        colorText: Colors.white,
      );
    }else{
      Get.toNamed('/sign_up');
    }
  }
  
  init() async {
    myGlobalController = Get.find();
    return true;
  }

}
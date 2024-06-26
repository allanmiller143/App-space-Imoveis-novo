

// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/componentes/global_components/load_widget.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';

class CompleteSignUpPageBioController extends GetxController {
  var bio = TextEditingController();
  late MyGlobalController myGlobalController;

  init() async {
    myGlobalController = Get.find();
    return true;
  }

  jumpStep(){
    Get.toNamed('/home');
  }


  Future<void> insertBio(BuildContext context) async {
    String route;
    if (myGlobalController.userInfo["type"] == 'realtor') {
      route = 'realtors';
    } else if (myGlobalController.userInfo["type"] == 'realstate') {
      route = 'realstate';
    } else {
      route = 'owners';
    }

    if(bio.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, escreva sua bio'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
    }else{
      try {
        var formJson = {
          'bio': bio.text,
          'email': myGlobalController.userInfo['email'],
        };
        showLoad(context);
        var response = await putFormDataA('$route/${myGlobalController.userInfo['email']}', formJson, myGlobalController.token);
        if (response['status'] == 200) {
          var userData = await get('$route/${myGlobalController.userInfo['email']}');
          if (userData['status'] == 200 || userData['status'] == 201) {
            myGlobalController.userInfo = userData['data'];
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('user', jsonEncode(userData['data']));
            Get.back();
            Get.toNamed('/home');

          } else {
            Get.back();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocorreu um erro inesperado 1'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
          }
        } else {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocorreu um erro inesperado 2'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
        }
      } catch (error) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocorreu um erro inesperado 3'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
      }
    }
  }
}




















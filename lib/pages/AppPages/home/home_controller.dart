// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class HomeController extends GetxController {
  var email = TextEditingController();
  var password = TextEditingController();
  late MyGlobalController myGlobalController;
  late var properties = {};

  @override
  void onInit()async {
    super.onInit();
      
    myGlobalController = Get.find();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    final String? token = prefs.getString('token');
    final String? userFavorites = prefs.getString('userFavorites');
    
    print(user);

    if(user != null){
      myGlobalController.userInfo = jsonDecode(user);
      myGlobalController.token = token!;
    }

    
    
    if (userFavorites != null) {
      // Converte a string JSON de volta para uma lista de strings
      List<dynamic> favoritesList = jsonDecode(userFavorites);
      myGlobalController.userFavorites.value = favoritesList.cast<String>();
      print(myGlobalController.userFavorites);
    } else {
      // Retorna uma lista vazia se não houver dados armazenados
      myGlobalController.userFavorites.value = [];
    }   

  }

  init() async {
    return true;
  }


}

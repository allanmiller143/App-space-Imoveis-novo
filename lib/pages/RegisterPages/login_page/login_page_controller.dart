// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/load_widget.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageController extends GetxController {
  var email = TextEditingController();
  var password = TextEditingController();
  late MyGlobalController myGlobalController;

  @override
  void onInit() {
    myGlobalController = Get.find();

    super.onInit();
    init();
  }

  init() async {
    myGlobalController = Get.find();
    return true;
  }

login(BuildContext context) async {
  if (email.text.isNotEmpty && password.text.isNotEmpty) {
    try {
      showLoad(context);
      Map<String, String> data = {
        "email": email.text,
        "password": password.text
      };


      var formJson = {
        'idPhone': myGlobalController.phoneToken,
        'email': email.text,
      };

      
      var response = await post('login', data);
      if (response['status'] == 200 || response['status'] == 201) {
        var favoritesResponse = await get('favorites/${email.text}',token: response['body']['token']);
        if(favoritesResponse['status'] == 200 || favoritesResponse['status'] == 201){
          myGlobalController.userInfo = response['body']['user'];
          myGlobalController.token = response['body']['token'];
          myGlobalController.userFavorites.value = favoritesResponse['data'];
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          
          // Salva os dados do usuário e o token no SharedPreferences
          await prefs.setString('user', jsonEncode(response['body']['user']));
          await prefs.setString('token', response['body']['token']);
          await prefs.setString('userFavorites', jsonEncode(favoritesResponse['data']));
          String route;

          if (myGlobalController.userInfo["type"] == 'realtor') {
            route = 'realtors';
          } else if (myGlobalController.userInfo["type"] == 'realstate') {
            route = 'realstate';
          } else {
            route = 'owners';
          }
          
          var insertPhoneToken = await putFormDataA('$route/${myGlobalController.userInfo['email']}', formJson, myGlobalController.token);
          if (insertPhoneToken['status'] == 200) {
            var userData = await get('$route/${myGlobalController.userInfo['email']}');
            if (userData['status'] == 200 || userData['status'] == 201) {
              myGlobalController.userInfo = userData['data'];
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('user', jsonEncode(userData['data']));
              Get.back();
              Get.offAllNamed('/home');
            } else {
              Get.back();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocorreu um erro inesperado'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
            }
          } else {
            Get.back();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocorreu um erro inesperado'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
          }

        }else{
          Get.back(); // Fecha o loading
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('E-mail ou senha incorreta'),
              backgroundColor: Color.fromARGB(155, 250, 0, 0),
            ),
          );

        }
      } else {
        Get.back(); // Fecha o loading
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail ou senha incorreta'),
            backgroundColor: Color.fromARGB(155, 250, 0, 0),
          ),
        );
      }
    } on Exception catch (e) {
      Get.back(); // Fecha o loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-mail ou senha incorreta'),
          backgroundColor: Color.fromARGB(155, 250, 0, 0),
        ),
      );
    }
  } else {
    Get.back(); // Fecha o loading
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E-mail ou senha incorreta'),
        backgroundColor: Color.fromARGB(155, 250, 0, 0),
      ),
    );
    
  }
}



}

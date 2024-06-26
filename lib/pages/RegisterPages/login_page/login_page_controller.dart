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
      var response = await post('login', data);
      if (response['status'] == 200 || response['status'] == 201) {

        var favoritesResponse = await get('favorites/${email.text}',token: response['body']['token']);
        if(favoritesResponse['status'] == 200 || favoritesResponse['status'] == 201){
          print(favoritesResponse['data']);
          myGlobalController.userInfo = response['body']['user'];
          myGlobalController.token = response['body']['token'];
          myGlobalController.userFavorites.value = favoritesResponse['data'];
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          // Salva os dados do usuário e o token no SharedPreferences
          await prefs.setString('user', jsonEncode(response['body']['user']));
          await prefs.setString('token', response['body']['token']);
          await prefs.setString('userFavorites', jsonEncode(favoritesResponse['data']));

          Get.back(); // Fecha o loading
          Get.toNamed('/home');
        }else{
          Get.back(); // Fecha o loading
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('E-mail ou senha incorreta 0'),
              backgroundColor: Color.fromARGB(155, 250, 0, 0),
            ),
          );

        }
      } else {
        Get.back(); // Fecha o loading
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('E-mail ou senha incorreta 1'),
            backgroundColor: Color.fromARGB(155, 250, 0, 0),
          ),
        );
      }
    } on Exception catch (e) {
      Get.back(); // Fecha o loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-mail ou senha incorreta 2'),
          backgroundColor: Color.fromARGB(155, 250, 0, 0),
        ),
      );
    }
  } else {
    Get.back(); // Fecha o loading
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E-mail ou senha incorreta 3'),
        backgroundColor: Color.fromARGB(155, 250, 0, 0),
      ),
    );
    
  }
}



}

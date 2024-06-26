import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/AppPages/home/home.dart';
import 'package:space_imoveis/pages/RegisterPages/login_page/login_page.dart';
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Future<bool> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    late MyGlobalController myGlobalController;

    var logged = false;
    final String? user = prefs.getString('user');
    if(user != null){
      logged = true;
      myGlobalController = Get.find();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user = prefs.getString('user');
      final String? token = prefs.getString('token');
      final String? userFavorites = prefs.getString('userFavorites');

      myGlobalController.userInfo = jsonDecode(user!);
      myGlobalController.token = token!;
      
      if (userFavorites != null) {
        // Converte a string JSON de volta para uma lista de strings
        List<dynamic> favoritesList = jsonDecode(userFavorites);
        myGlobalController.userFavorites.value = favoritesList.cast<String>();
      } else {
        // Retorna uma lista vazia se não houver dados armazenados
        myGlobalController.userFavorites.value = [];
      }

    }else{
      logged = false;
    }
    return logged;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == true) {
              return Home();
            } else {
              return LoginPage();
            }
          }
        },
      ),
    );
  }
}

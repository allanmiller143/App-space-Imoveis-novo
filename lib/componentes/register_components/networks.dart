import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';
import 'package:space_imoveis/services/firebase_login.dart';

class Networks extends StatelessWidget {
  const Networks({super.key});



  googleSignIn(BuildContext context) async {
    try {
      var result = await signInWithGoogle();
      print(result);
      var userData = {
          'name': result['auth'].user!.displayName,
          'email': result['auth'].user!.email,
          'phone': result['auth'].user!.phoneNumber,
      };

      print(userData);

      var response = await get('find/${userData['email']}');
      if(response['status'] == 200 || response['status'] == 201){ // dar um find para ver se a conta ja existe, se sim, ent faz login
        if(response['data']['type'] == 'client'){
          var tokenData = {
            'googleToken': result['idToken'],
          };
          var loginWithGoogle = await post('google', tokenData);
          if(loginWithGoogle['status'] == 200 || loginWithGoogle['status'] == 201){
            var favoritesResponse = await get('favorites/${loginWithGoogle['body']['user']['email']}',token: loginWithGoogle['body']['token']);
            if(favoritesResponse['status'] == 200 || favoritesResponse['status'] == 201){
              MyGlobalController myGlobalController = Get.find();
              myGlobalController.userInfo = loginWithGoogle['body']['user'];
              myGlobalController.token = loginWithGoogle['body']['token'];
              myGlobalController.userFavorites = favoritesResponse['data'];
              print(favoritesResponse['data']);
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('user', jsonEncode(loginWithGoogle['body']['user']));
              await prefs.setString('token', loginWithGoogle['body']['token']);
              await prefs.setString('userFavorites', jsonEncode(favoritesResponse['data']));
              Get.toNamed('/home');
            }else{
              mySnackBar('Ocorreu um erro inesperado', false);
            }
          }else{
            print('deu ruim no login com o google, sendo um client');
          }
        }else{
          mySnackBar('Usuario ja existente, faça login com seu email e senha', false);
          signOut();
        }
        print(response['data']);

      }else{
        var response = await post('clients', userData);
        if(response['status'] == 200 || response['status'] == 201){
          var tokenData = {
            'googleToken': result['idToken'],
          };
          var loginResponse = await post('google',tokenData);
          if(loginResponse['status'] == 200 || loginResponse['status'] == 201){
             MyGlobalController myGlobalController = Get.find();
              myGlobalController.userInfo = loginResponse['body']['user'];
              myGlobalController.token = loginResponse['body']['token'];
              myGlobalController.userFavorites.value = [];
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('user', jsonEncode(loginResponse['body']['user']));
              await prefs.setString('token', loginResponse['body']['token']);
              await prefs.setString('userFavorites', jsonEncode([]));
              Get.toNamed('/home');
              mySnackBar('Conta criada e login feito com sucesso', true);
          }else{
            mySnackBar('Ocorreu um erro inesperado', false);
          }
        }
      }
    } catch (e) {
      mySnackBar('Ocorreu um erro inesperado jnfgiofgoif', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 0.5,
                color: const Color.fromARGB(255, 0, 0, 0),
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const Text(
              'Ou continue com',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w300,
                fontSize: 14
              ),
            ),
            Expanded(
              child: Container(
                height: 0.5,
                color: const Color.fromARGB(255, 0, 0, 0),
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NetworkCard(image: 'assets/imgs/google.png',onPressed: (){googleSignIn(context);},),
            // const SizedBox(width: 15,),
            // NetworkCard(image: 'assets/imgs/apple.png',onPressed: () async{
            //   await signOut();
            // },),
            // const SizedBox(width: 15,),
            // NetworkCard(image: 'assets/imgs/facebook.png',onPressed: (){},)
          ],
        )

      ],
    );
  }
}



class NetworkCard extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  const NetworkCard(
    {
      super.key,
      required this.image,
      required this.onPressed

    }
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.125,
          height: MediaQuery.of(context).size.width * 0.125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(image,fit: BoxFit.cover,width: double.infinity, height: double.infinity,),
          ),
        ),
      ),
    );
  }
}
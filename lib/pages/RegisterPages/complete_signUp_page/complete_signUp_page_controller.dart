

// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/componentes/global_components/load_widget.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';

class CompleteSignUpPageController extends GetxController {
  File? imageFile; // imagem para ser coletada e inserida no banco para o perfil 
  late MyGlobalController myGlobalController;

  init() async {
    myGlobalController = Get.find();
    return true;
  }

  pick(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
    }
  }
  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          // Conteúdo do BottomSheet
          height: 200,
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Escolha sua foto de perfil ',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'OpenSans-VariableFont_wdth,wght'),
                ),
              ),
              ListTile(
                title: const Text(
                  'Abrir galeria',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'AsapCondensed-Medium'),
                ),
                leading: const Icon(
                  Icons.photo,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                onTap: () {
                  pick(ImageSource.gallery);
                },
              ),
              ListTile(
                title: const Text(
                  'Abrir camera',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'AsapCondensed-Medium'),
                ),
                leading: const Icon(
                  Icons.camera_alt,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                onTap: () {
                  pick(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  jumpStep(){
    Get.toNamed('/complete_sign_up_bio');
  }


  Future<void> insertProfilePic(BuildContext context) async {
    String route;
    if (myGlobalController.userInfo["type"] == 'realtor') {
      route = 'realtors';
    } else if (myGlobalController.userInfo["type"] == 'realstate') {
      route = 'realstate';
    } else {
      route = 'owners';
    }

    if(imageFile == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, selecione uma imagem'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
    }else{
      try {
        showLoad(context);
        var response = await putFormData('$route/${myGlobalController.userInfo['email']}', imageFile!, myGlobalController.token);
        if (response['status'] == 200) {
          var userData = await get('$route/${myGlobalController.userInfo['email']}');
          if (userData['status'] == 200 || userData['status'] == 201) {
            myGlobalController.userInfo = userData['data'];
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('user', jsonEncode(userData['data']));
            Get.toNamed('/complete_sign_up_bio');
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




















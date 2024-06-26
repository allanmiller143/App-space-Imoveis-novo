// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class SignUpPhoto extends StatelessWidget {
  final VoidCallback onPressed;
  final File? image; // imagem que pega quando insere no app

  SignUpPhoto({required this.onPressed, required this.image });

  // Recupera a imagem do bd
  ImageProvider<Object> getImageProvider() {
    if (image != null) {
      return FileImage(image!);
    } else {
      return const AssetImage('assets/imgs/logo.png'); // um imagem padrao 
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = getImageProvider();
    MyGlobalController mgc = Get.find();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(120)),
          border: Border.all(color:const Color.fromARGB(255, 0, 0, 0), width: 0.5),
        ),
        child: 
        Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 5,
              child: GestureDetector(
                onTap: onPressed,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: mgc.color,
                  ),
                  child: const Icon(Icons.add, size: 16, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

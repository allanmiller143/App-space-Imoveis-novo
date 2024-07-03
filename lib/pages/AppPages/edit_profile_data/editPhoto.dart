// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class EditPhoto extends StatelessWidget {
  final VoidCallback onPressed;
  final File? image; // imagem que pega quando insere no app
  final String? imageUrl; // url da imagem

  EditPhoto({required this.onPressed, this.image, this.imageUrl});

  // Recupera a imagem do bd
  ImageProvider<Object> getImageProvider() {
    if (image != null) {
      return FileImage(image!);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      return NetworkImage(imageUrl!);
    } else {
      return const AssetImage('assets/imgs/logo.png'); // uma imagem padrão
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = getImageProvider();
    MyGlobalController mgc = Get.find();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Color.fromARGB(99, 0, 0, 0), width: 0.5),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onPressed,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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

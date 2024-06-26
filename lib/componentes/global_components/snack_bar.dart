import 'package:get/get.dart';
import 'package:flutter/material.dart';

void mySnackBar(text,positivo) {
  if(positivo){
    Get.snackbar(
      duration: const Duration(milliseconds: 1200),
      "Alerta",
      text,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Color.fromARGB(244, 20, 104, 46),
      colorText: Color.fromARGB(255, 255, 255, 255),
      maxWidth: 350 
    ); 
  }else{
    Get.snackbar(
      "Alerta",
      duration: const Duration(milliseconds: 1200),
      text,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Color.fromARGB(231, 236, 71, 6),
      colorText: Colors.white,
      maxWidth: 350 
    ); 
  }
                                                                                    
}
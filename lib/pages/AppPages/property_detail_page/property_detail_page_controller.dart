// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';

class PropertyDetailController extends GetxController {
  late MyGlobalController myGlobalController;
  final String propertyId = Get.parameters['id']!;
  late var property = {};
  TextEditingController newComment = TextEditingController();
  double newRate = 0;


  @override
  void onInit()async {   
    myGlobalController = Get.find();
    super.onInit();
  }

  String formatNumber(dynamic number) {
    if (number == null) return 'N/A'; // Verifica se o número é nulo
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(number);
  }

init() async {
  try {
    var response = await get('properties/$propertyId');
    print('Response: $response');
    
    if (response['status'] == 200 || response['status'] == 201) {
      Map<String, dynamic> json = {}; // Garantir que é um mapa vazio
      var clickResponse = await postClick('properties/times-seen/$propertyId', json);
      print('Click Response: $clickResponse');
      
      property = response['data'];

    } else {
      print('Ocorreu um erro inesperado');
    }
  } catch (e) {
    print('Ocorreu um erro inesperado, tente novamente mais tarde');
  }
  return true;
}




}

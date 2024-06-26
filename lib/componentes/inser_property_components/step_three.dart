
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/componentes/inser_property_components/imageSelect.dart';
import 'package:space_imoveis/componentes/inser_property_components/insert_dialog.dart';
import 'package:space_imoveis/componentes/inser_property_components/step_one.dart';
import 'package:space_imoveis/componentes/inser_property_components/step_two.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:intl/intl.dart';
import 'package:space_imoveis/pages/AppPages/insert_property/insert_property_controller.dart';

class StepThree extends StatelessWidget {
  MyGlobalController  myGlobalController = Get.find();
  var controller;

  StepThree({ Key? key, required this.controller}) : super(key: key);
  String formatNumber(dynamic number) {
    if (number == null) return 'N/A'; // Verifica se o número é nulo
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(number);
  }  
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Revise os dados inseridos, e publique seu anúncio!',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
              ),
            ),
          ),
          SizedBox(height: 20,),
          StepOne(withButton: false, controller : controller),
          MultiImagePicker(),
          StepTwo(withButton: false , controller : controller),
          MyButtom(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InsertDialog(
                    controller: controller,
                  );
                },
              );
            },
            label: 'Próximo passo',
            buttomColor: controller.myGlobalController.color,
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
         
  }
}









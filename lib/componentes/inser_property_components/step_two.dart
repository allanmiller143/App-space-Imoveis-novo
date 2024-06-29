
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/biggerTextField.dart';
import 'package:space_imoveis/componentes/global_components/drop_down.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/componentes/global_components/TextFields/simple_text_form_field.dart';
import 'package:space_imoveis/componentes/inser_property_components/mandatory.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:intl/intl.dart';

class StepTwo extends StatelessWidget {
  MyGlobalController  myGlobalController = Get.find();
  var controller;
  final bool withButton;

  StepTwo({ Key? key,this.withButton = true, required this.controller}) : super(key: key);
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
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
              child: Column(
                children: [
                  MandatoryOptional(text: 'Descreva seu imóvel', subtext: 'Obrigatório',subtext2: 'Insira aqui, as caracteristicas do imóvel, como a vizinhança, os locais proximos, e detalhes mais importantes',),
                  SizedBox(height: 5),
                  MyBiggerTextFormField(controller: controller.description,hint: 'Descrição',),
                ],
              ),
            ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
              child: Column(
                children: [
                  MandatoryOptional(text: 'Tamanho do imóvel', subtext: 'Obrigatório',subtext2: 'Insira aqui, o tamanho do imóvel, escolha a opção de hectare ou metro quadrado',),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: MySimpleTextFormField(hint: 'Área', controller: controller.size),
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                        width: Get.width * 0.25,
                        child: CustomDropdownButton(labelText: 'Medida',items: controller.unitList, controller: controller.unit,),
                      ),
                    ],
                  ),                
                ],
              ),
            ),   
          SizedBox(height: 10),
          Obx(()=> controller.advertsType.value == 'Aluguel' ? Container():
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
                child: Column(
                  children: [
                    MandatoryOptional(text: 'Aceita financiamento', subtext: 'Obrigatório',subtext2: 'Escolha se o imóvel aceita financiamento',),
                    SizedBox(height: 5),
                    CustomDropdownButton(labelText: '',items: controller.financeList, controller: controller.finance,),      
                  ],
                ),
              ),
          ),  
           withButton ?
          Column(
            children: [
              SizedBox(height: 20,),
              MyButtom(
                onPressed: () {
                  controller.toStep3();
                },
                label: 'Próximo passo',
                buttomColor: controller.myGlobalController.color,
              ),
            ],
          ):SizedBox(),
            SizedBox(height: 20,),          
        ],
      ),
    );     
  }
}









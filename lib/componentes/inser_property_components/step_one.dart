
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/check_box_group.dart';
import 'package:space_imoveis/componentes/global_components/drop_down.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/componentes/global_components/simple_text_form_field.dart';
import 'package:space_imoveis/componentes/inser_property_components/mandatory.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:intl/intl.dart';

class StepOne extends StatelessWidget {
  MyGlobalController  myGlobalController = Get.find();
  var controller;
    
  final bool withButton;
  StepOne({ Key? key,this.withButton = true, required this.controller}) : super(key: key);
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              children: [
                MandatoryOptional(text: 'Tipo de anúncio', subtext: 'Obrigatório',subtext2: 'Escolha entre Venda, Aluguel ou Ambas',),
                CustomDropdownButton(labelText: '',items: ['Venda', 'Aluguel','Ambas'],controller: controller.advertsType,),
                SizedBox(height: 5),
              ],
            ),  
          ),

          SizedBox(height: 10),

          Obx(()=> controller.advertsType.value == '' ? Container():
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                children: [
                  Obx(()=> controller.advertsType.value == '' ?
                    Container() :
                    MandatoryOptional(text: 'Preços', subtext: 'Obrigatório',subtext2: 'Insira apenas valores numéricos',),
                  ),
                  Obx(()=> controller.advertsType.value == '' ?
                    Container() :
                    controller.advertsType.value == 'Ambas'?
                    Row(
                      children: [
                        Expanded(
                          child: MySimpleTextFormField(
                            hint: 'Preço de venda',
                            controller: controller.sellPrice,
                            formatText: true,
                          ),
                        ),
                        SizedBox(width: 5,),
                        SizedBox(
                          width: Get.width * 0.45,
                          child: MySimpleTextFormField(
                            hint: 'Preço de aluguel/Mês',
                            controller: controller.rentPrice,
                            formatText: true,
                          ),
                        ),
                      ],
                    ):
                    controller.advertsType.value == 'Venda'?
                    MySimpleTextFormField(hint: 'Preço de venda', controller: controller.sellPrice,formatText: true,):
                    MySimpleTextFormField(hint: 'Preço de aluguel/Mês', controller: controller.rentPrice,formatText: true,),
                  ),
                  Obx(()=> controller.advertsType.value == '' ?
                    Container() :
                    Column(
                      children: [
                      Row(
                        children: [                   
                          Checkbox( 
                            visualDensity: VisualDensity(horizontal:  -4.0, vertical: 0),
                            activeColor: Color(Colors.green.value),
                            value: controller.negociable.value,
                            onChanged:  (value) => controller.negociable.value = !controller.negociable.value,
                          ),
                          Text('Aceito negociar o preço?',style: TextStyle(fontSize: 12),)
                        ],
                      ),  
                      SizedBox(height: 5),
                      MandatoryOptional(text: 'Outros valores', subtext: 'Opcional',subtext2: 'Outras taxas que podem vir a ser inseridas',),
                        Row(
                          children: [
                            Expanded(
                              child: MySimpleTextFormField(
                                hint: 'IPTU',
                                controller: controller.iptuPrice,
                                formatText: true
                              ),
                            ),
                            SizedBox(width: 5,),
                            SizedBox(
                              width: Get.width * 0.45,
                              child: MySimpleTextFormField(
                                hint: 'Taxas extras',
                                controller: controller.otherPrices,
                                formatText: true
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ),
                ],
              ),
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
                SizedBox(height: 5),
                MandatoryOptional(text: 'Tipo de imóvel', subtext: 'Obrigatório',subtext2: 'Defina o tipo de imóvel',),
                CustomDropdownButton(labelText: '',items: ['Casa', 'Apartamento','Fazenda','Terreno'],controller: controller.announceType,),
                SizedBox(height: 15),
                Obx(()=>(controller.announceType.value == '' || controller.announceType.value != 'Apartamento') ? SizedBox() :  CustomDropdownButton(labelText: 'Andar',items: controller.numberList,controller: controller.floors,)),

              ],
            ),  
          ),  
          SizedBox(height: 10),
          Obx(()=> (controller.announceType.value == 'Terreno' ||controller.announceType.value == '') ? Container():
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
               child: Column(
                children: [
                  MandatoryOptional(text: 'Meu imóvel possui', subtext: 'Obrigatório',subtext2: 'Insira aqui, as caracteriisticas do imóvel',),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdownButton(labelText: 'Quartos',items: controller.numberList,controller: controller.bedrooms,),
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                        width: Get.width * 0.45,
                        child: CustomDropdownButton(labelText: 'Banheiros',items: controller.numberList, controller: controller.bathrooms,),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdownButton(labelText: 'Vagas',items: controller.numberList ,controller: controller.parkingSpaces,),
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                        width: Get.width * 0.45,
                        child: CustomDropdownButton(labelText: 'Suítes',items: controller.numberList ,controller: controller.suits,),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.6,
                        child: CustomDropdownButton(labelText: 'Mobiliado',items: ['Mobiliado', 'Semi mobiliado','Não mobiliado'],controller: controller.furnished,),
                      ),
                    ],
                  ),
                ],
               ),
             ),
          ),
          SizedBox(height: 10),
          Obx(()=> controller.announceType.value == '' ? Container():
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
               child: Column(
                children: [
                  MandatoryOptional(text: 'Endereço', subtext: 'Obrigatório',subtext2: 'Insira aqui, o endereço do imóvel',),
                  MySimpleTextFormField(
                    controller: controller.cep,
                    hint: 'CEP',
                    enable: true,
                    onChange: (value) async {
                      if (value.length == 8) {
                        await controller.completarEndereco(controller.cep.text);
                      }
                    },
                  ),              
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(()=> MySimpleTextFormField(hint: 'Rua', controller: controller.street,enable: controller.activateStreet.value,)),
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                        width: Get.width * 0.20,
                        child: MySimpleTextFormField(hint: 'Número', controller: controller.houseNumber),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: MySimpleTextFormField(hint: 'Cidade', controller: controller.city,enable: false,),
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                        width: Get.width * 0.20,
                        child: MySimpleTextFormField(hint: 'Estado', controller: controller.state,enable:false,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(()=> MySimpleTextFormField(hint: 'Bairro', controller: controller.neighborwood,enable: controller.activateNeighborhood.value)),
                ],
               ),
             ),
          ),

          SizedBox(height: 10),
          Obx(()=> (controller.announceType.value == 'Terreno' ||controller.announceType.value == '')?Container():
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),            
              child: Column(
                children: [
                  MandatoryOptional(text: 'Opções rapidas', subtext: 'Opcional'),
                  CheckBoxGroup(
                    options: controller.options,
                  ),
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
                  controller.toStep2();
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









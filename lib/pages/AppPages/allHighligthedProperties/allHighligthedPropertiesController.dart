// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class Allhighligthedpropertiescontroller extends GetxController {

  var myProperties = [].obs;
  var totalItens = 0.obs;
  var currentPage = 0.obs;
  RxBool loading = false.obs;
  RxString state = ''.obs;
  RxString bedrooms = ''.obs;
  RxString bathrooms = ''.obs;
  RxString parkingSpaces = ''.obs;
  RxString advertsType = ''.obs;
  RxString propertyType = ''.obs;
  TextEditingController city = TextEditingController();
  var isExpanded = false.obs;
  var StateList = ['AM', 'AC', 'AL', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO'];
  var CityList = ['Recife','Araguaia','Aveiro','Beja','Braga','Braganca','Castelo Branco','Coimbra','Estarreja','Faro','Guarda','Leiria','Lisboa','Portalegre','Porto','Santarem','Setubal','Sines','Viseu'];
  var numberList  = ['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20']; 
  var biggerNumberList = ['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50']; 


  RxList<Map<String, Object>> options = [
    {'value':'Piscina',"dbValue": 'pool','checked': false},
    {'value':'Churrasqueira',"dbValue": 'grill','checked': false},
    {'value':'Ar condicionado',"dbValue": 'airConditioning','checked': false},
    {'value':'Sala de eventos',"dbValue": 'eventArea','checked': false},
    {'value':'Academia',"dbValue": 'gym','checked': false},
    {'value':'Energia Solar',"dbValue": 'solarEnergy','checked': false},
    {'value':'Jardin',"dbValue": 'garden','checked': false},
    {'value':'Área gourmet',"dbValue": 'gourmetArea','checked': false},
    {'value':'Sacada',"dbValue": 'porch','checked': false},
    {'value':'Condominio fechado',"dbValue": 'gatedCommunity','checked': false},
    {'value':'Portaria 24h',"dbValue": 'concierge','checked': false},
    {'value':'Quintal',"dbValue": 'yard','checked': false},
    {'value':'Laje',"dbValue": 'slab','checked': false},
    {'value':'Playground',"dbValue": 'playground','checked': false}, 
    {'value':'Varanda',"dbValue": 'concierge','checked': false},
  ].obs;
  
  TextEditingController minValue = TextEditingController();
  TextEditingController maxValue = TextEditingController();


  TextEditingController minSize = TextEditingController();
  TextEditingController maxSize = TextEditingController();




  late MyGlobalController myGlobalController;

  @override
  void onInit()async {
    super.onInit();
    propertyType.value = Get.arguments[0];  
    print(advertsType.value);

    myGlobalController = Get.find();

  }

  init() async {
    return true;
  }

  filter(){
    print("${state.value} ${city.text} ${minSize.text} ${maxSize.text}");
      
    
  }

}

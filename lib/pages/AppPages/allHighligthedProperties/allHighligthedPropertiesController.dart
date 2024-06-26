// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause

import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class Allhighligthedpropertiescontroller extends GetxController {
  var myProperties = [].obs;
  var totalItens = 0.obs;
  var currentPage = 0.obs;
  RxBool loading = false.obs;
  RxString state = ''.obs;
  RxString advertsType = ''.obs;
  RxString status = ''.obs;
  RxString city = ''.obs;
  RxString shared = ''.obs;
  var isExpanded = false.obs;
  var StateList = ['AM', 'AC', 'AL', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO'];
  var AdvertsTypeList =  ['Venda','Aluguel','Ambas'];
  var StatusList = ['Arquivado','Populares','Destaques'];
  var CityList = ['Recife','Araguaia','Aveiro','Beja','Braga','Braganca','Castelo Branco','Coimbra','Estarreja','Faro','Guarda','Leiria','Lisboa','Portalegre','Porto','Santarem','Setubal','Sines','Viseu'];

  Map<String, String> genderMap = {
    'male': 'Male',
    'female': 'Female',
    'other': 'Other',
  };

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
  late MyGlobalController myGlobalController;

  @override
  void onInit()async {
    super.onInit();   
    myGlobalController = Get.find();

  }

  init() async {
    return true;
  }

}

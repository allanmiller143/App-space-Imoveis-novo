

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/componentes/inser_property_components/imageSelect.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/Complete_cep.dart';

class InsertPropertyController extends GetxController {
  late MyGlobalController myGlobalController;
  
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


  var numberList = ['1','2','3','4','5'];
  var unitList = ['m²','Hectate'];
  var financeList = ['Sim','Não'];
  
  var currentStep = 0.obs;
  var sellPrice = TextEditingController();
  var rentPrice = TextEditingController();
  var iptuPrice= TextEditingController();
  var otherPrices= TextEditingController();
  RxBool negociable = false.obs;

  RxString advertsType = 'Venda'.obs;
  RxString bedrooms = ''.obs;
  RxString bathrooms = ''.obs;
  RxString parkingSpaces = ''.obs;
  RxString suits = ''.obs;

  RxString announceType = ''.obs;
  RxString floors = ''.obs;


  var cep = TextEditingController();
  var street = TextEditingController();
  var houseNumber = TextEditingController();
  var city= TextEditingController();
  var state= TextEditingController();
  var neighborwood= TextEditingController();
  var activateStreet  = false.obs;
  var  activateNeighborhood = false.obs;

  RxString furnished = ''.obs;

  var description= TextEditingController();
  var size= TextEditingController();
  RxString unit = 'm²'.obs;
  RxString finance = ''.obs;



  void changeStep(int step) {
    currentStep.value = step;
  }
  
  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
  }

    Future<void> completarEndereco(cep) async {
    Map<String, dynamic> dados = await searchCep(cep);
    if(dados['bairro'] == ''){
      activateNeighborhood.value = true;
    }else{
      activateNeighborhood.value = false;
    }
    if(dados['logradouro'] == ''){
      activateStreet.value = true;
    }else{
      activateStreet.value = false;
    }
    
    city.text = dados["localidade"];
    state.text = dados["uf"];
    neighborwood.text = dados['bairro'];
    street.text = dados['logradouro'];
  }



  void toStep2() {
    if(announceType.isEmpty){
      mySnackBar('Selecione o tipo de imóvel', false);
    }else if(advertsType.value == 'Venda' && sellPrice.text.isEmpty){
      mySnackBar('Selecione o valor de venda ', false);
    }else if(advertsType.value == 'Aluguel' && rentPrice.text.isEmpty){
      mySnackBar('Selecione o valor de Aluguel', false);
    }else if(advertsType.value == 'Ambas' && sellPrice.text.isEmpty && rentPrice.text.isEmpty){
      mySnackBar('Selecione o valor de Aluguel e venda', false);
    }else if(announceType.isEmpty){
      mySnackBar('Selecione o tipo de imóvel', false);
    }else if(floors.isEmpty && announceType.value == 'Apartamento' ){
      mySnackBar('Selecione o andar do apartamento', false);
    }else if(bathrooms.isEmpty && announceType.value != 'Terreno' ){
      mySnackBar('Selecione a quantidade de banheiros', false);
    }else if(bedrooms.isEmpty && announceType.value != 'Terreno' ){
      mySnackBar('Selecione a quantidade de quartos', false);
    }else if(furnished.isEmpty && announceType.value != 'Terreno' ){
      mySnackBar('Selecione a mobília do imóvel', false);
    }else if(parkingSpaces.isEmpty && announceType.value != 'Terreno' ){
      mySnackBar('Selecione a quantidade de vagas', false);
    }else if(suits.isEmpty && announceType.value != 'Terreno' ){
      mySnackBar('Selecione a quantidade de suites', false);
    }else if((cep.text.isEmpty || street.text.isEmpty || city.text.isEmpty || state.text.isEmpty || neighborwood.text.isEmpty) && announceType.value != 'Terreno'  ){
      mySnackBar('Defina o enderço', false);
    }else if(houseNumber.text.isEmpty && announceType.value != 'Terreno'  ){
      mySnackBar('Defina o numero do Imóvel', false);
    }else{
      currentStep.value = 1;
    }
  }

  void toStep3() {
    ImagePickerController ipc = Get.find();

    if((advertsType.value == 'Venda' || advertsType.value == 'Ambas' ) && finance.isEmpty){
      mySnackBar('Selecione a opcão de financiamento', false);
    }else if(size.text.isEmpty ){
      mySnackBar('Selecione o tamanho', false);
    }else if(description.text.isEmpty ){
      mySnackBar('Defina uma descricão', false);
    }else if(ipc.imageFiles.length < 5){
      mySnackBar('Selecione pelo menos 5 imagens', false);
    }else{
      currentStep.value = 2;
    }
  }

  init() async {
    return true;
  }
}

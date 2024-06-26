
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:space_imoveis/componentes/DashBoardComponents/Myproperties/edit.dart';
import 'package:space_imoveis/componentes/global_components/load_widget.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/componentes/inser_property_components/imageSelect.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/Complete_cep.dart';
import 'package:space_imoveis/services/api.dart';

class EditPropertyController extends GetxController {
  late MyGlobalController myGlobalController;
  var property = Get.arguments[0];
  
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
  
  get newImageFiles => null;



  void changeStep(int step) {
    currentStep.value = step;
  }
  
  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
    init();
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

    description.text = property['description'];
    size.text = property['size'].toString();
    sellPrice.text = property['sell_price'] == null ? '' : property['sell_price'].toString();
    rentPrice.text = property['rentPrice'] == null ? '' : property['rentPrice'].toString();
    iptuPrice.text = property['iptu'] == null ? '' : property['iptu'].toString();
    otherPrices.text = property['otherPrices'] == null  ? '' : property['otherPrices'].toString();
    negociable.value = property['negotiable'] ?? false;
    advertsType.value = property['announcement_type'];
    announceType.value = property['property_type'];
    floors.value = property['floor'] == null ? '' : property['floor'].toString();
    city.text = property['city'];
    state.text = property['state'];
    street.text = property['address'];
    houseNumber.text = property['house_number'] ?? '';
    cep.text = property['cep'];
    neighborwood.text = property['district'];
    bathrooms.value = property['bathrooms'].toString();
    bedrooms.value = property['bedrooms'].toString();
    parkingSpaces.value = property['parking_spaces'].toString();
    suits.value = property['suites'].toString();

    options = [
    {'value':'Piscina',"dbValue": 'pool','checked': property['pool'] as bool},
    {'value':'Churrasqueira',"dbValue": 'grill','checked': property['grill'] as bool},
    {'value':'Ar condicionado',"dbValue": 'airConditioning','checked': property['air_conditioning'] as bool},
    {'value':'Sala de eventos',"dbValue": 'eventArea','checked': property['event_area'] as bool},
    {'value':'Academia',"dbValue": 'gym','checked': property['gym'] as bool},
    {'value':'Energia Solar',"dbValue": 'solarEnergy','checked': property['solar_energy'] as bool},
    {'value':'Jardin',"dbValue": 'garden','checked': property['garden'] as bool},
    {'value':'Área gourmet',"dbValue": 'gourmetArea','checked': property['gourmet_area'] as bool},
    {'value':'Sacada',"dbValue": 'porch','checked': property['porch'] as bool},
    {'value':'Condominio fechado',"dbValue": 'gatedCommunity','checked': property['gated_community'] as bool},
    {'value':'Portaria 24h',"dbValue": 'concierge','checked': property['concierge'] as bool},
    {'value':'Quintal',"dbValue": 'yard','checked': property['yard'] as bool},
    {'value':'Laje',"dbValue": 'slab','checked': property['slab'] as bool},
    {'value':'Playground',"dbValue": 'playground','checked': property['playground'] as bool}, 
    {'value':'Varanda',"dbValue": 'concierge','checked': property['concierge'] as bool},
  ].obs;


    ImageEditPickerController ipc = Get.put( ImageEditPickerController() );
    ipc.imageUrls.assignAll(property['pictures'].map<String>((e) => e['url'] as String).toList());
    ipc.coverImageIndex.value = 0;


    if(property['furnished'] == 'furnished'){
      furnished.value = 'Mobiliado';
    }else if(property['semi-furnished'] == 'semi-furnished'){
      furnished.value = 'Semi Mobiliado';
    }else{
      furnished.value = 'Não Mobiliado';
    }

    if(property['financiable'] != null && property['financiable'] == true){
      finance.value = 'Sim';
    }else if(property['financiable'] != null && property['financiable'] == false){
      finance.value = 'Não';
    }else{
      finance.value = 'Não';
    }
    return true;
  }

Future<void> updateProperty(BuildContext context) async { 
  ImageEditPickerController ipc = Get.find();
  var formJson = {
    'announcementType': advertsType,
    'propertyType': announceType,
    'address': street.text,
    'city': city.text,
    'district': neighborwood.text,
    'state': state.text,
    'cep': cep.text,
    'size': size.text,
    'description': description.text,
    'contact': myGlobalController.userInfo['phone'],
    'sellerEmail': myGlobalController.userInfo['email'],
    'sellerType': myGlobalController.userInfo['type'],
    'aditionalFees': otherPrices.text,
    'isHighlighted': property['isHighlighted'] ?? false,
    'isPublished': property['isPublished'] ?? false,
    'negotiable': negociable.value,
    'oldPhotos' :  ipc.imageUrls
  };

  print('Tamanho da loista de fotos antigas: ${ipc.imageUrls.length}');

  if (announceType == 'Apartamento') {
    formJson['rooms'] = floors;
  }

  formJson['financiable'] = (finance == 'Sim');

  if (advertsType == 'Aluguel') {
    formJson['rentPrice'] = rentPrice.text;
  } else if (advertsType == 'Venda') {
    formJson['sellPrice'] = sellPrice.text;
  } else {
    formJson['rentPrice'] = rentPrice.text;
    formJson['sellPrice'] = sellPrice.text;
  }

  if (announceType != 'Terreno') {
    for (var option in options) {
      formJson[option['dbValue'] as String] = option['checked'];
    }

    formJson.addAll({
      'bathrooms': bathrooms,
      'bedrooms': bedrooms,
      'parkingSpaces': parkingSpaces,
      'suites': suits,
      'houseNumber': houseNumber.text
    });
  }

  formJson['furnished'] = (furnished == 'Mobiliado')
      ? 'furnished'
      : (furnished == 'Semi mobiliado') ? 'semi-furnished' : 'not-furnished';



  if (ipc.imageUrls.length + ipc.newImageFiles.length < 5) {
    mySnackBar('Selecione pelo menos 5 imagens', false);
    return;
  }

  if (advertsType == 'Ambas' && (rentPrice.text.isEmpty || sellPrice.text.isEmpty)) {
    mySnackBar('Insira o valor de aluguel e de venda', false);
    return;
  }

  try {
    showLoad(context);
    String? coverImageUrl;
    XFile? coverImageFile;

    // Determine if the cover image is in the URLs or new images
    if (ipc.coverImageIndex.value < ipc.imageUrls.length) {
      coverImageUrl = ipc.imageUrls[ipc.coverImageIndex.value];
      formJson['newCover'] = coverImageUrl;
    } else {
      coverImageFile = ipc.newImageFiles[ipc.coverImageIndex.value - ipc.imageUrls.length];
    }

    // Ensure all Rx variables are converted to their actual values
    Map<String, dynamic> nonReactiveFormJson = {};
    formJson.forEach((key, value) {
      nonReactiveFormJson[key] = value is Rx ? value.value : value;
    });

    var response;
      if( ipc.newImageFiles.length == 0 ){
        response = await putFormDataWithFiles(
          'properties/${property['id']}',
          nonReactiveFormJson,
          myGlobalController.token
        );
      }else if(ipc.newImageFiles.length > 0 && coverImageFile == null){
          response = await putFormDataWithFiles(
          'properties/${property['id']}',
          nonReactiveFormJson,
          myGlobalController.token,
          photoFiles: ipc.newImageFiles
        );
      }else{
          response = await putFormDataWithFiles(
          'properties/${property['id']}',
          nonReactiveFormJson,
          myGlobalController.token,
          photoFiles: ipc.newImageFiles,
          coverFile: coverImageFile
        );
      }

    if (response['status'] == 200 || response['status'] == 201) {
      Get.back();
      mySnackBar('Anúncio atualizado com sucesso!', true);
      Get.toNamed('/main_dash');

    } else {
      Get.back();
      mySnackBar(response['message'] ?? 'Erro ao atualizar anúncio', false);
    }
  } catch (e) {
    Get.back();
    mySnackBar('Erro ao atualizar anúncio', false);
  }
}



}

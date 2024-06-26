import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/load_widget.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';

class MyPropertiesPageController extends GetxController {
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
  late MyGlobalController myGlobalController;
  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
  }

  init(context) async {
    // Aqui você pode buscar os dados das propriedades de uma API ou de uma fonte de dados local
     myGlobalController = Get.find();
    await getUserProperties(context);
    return true;
  }
  Future<String> handleArchive( context, Map<String, dynamic> info, String label) async {
    var imgs = info['pictures'].map((img) => img['url']).toList();

    var formJson = {
      'sellerEmail': myGlobalController.userInfo['email'],
      'sellerType': myGlobalController.userInfo['type'],
      'oldPhotos': imgs,
    };

    var high = false;
    var returnString = '';
    var returnErrorString = '';

    if (label == 'Arquivar') {
      formJson['isHighlighted'] = false;
      formJson['isPublished'] = false;
      returnString = 'Arquivado';
    } else if (label == 'Populares') {
      formJson['isHighlighted'] = false;
      formJson['isPublished'] = true;
      returnString = 'Populares';
    } else {
      formJson['isHighlighted'] = true;
      formJson['isPublished'] = true;
      returnString = 'Destaques';
      high = true;
    }

    if(info['is_highlighted'] == false && info['is_published'] == false){
      returnErrorString = 'Arquivado';
    }else if(info['is_highlighted'] == true){
      returnErrorString = 'Destaques';
    }else{
      returnErrorString = 'Populares';
    }



    try {
      showLoad(context);
      var response = await putFormDataA('properties/${info['id']}', formJson, myGlobalController.token);
      if(response['status'] == 200){
        Get.back();
        mySnackBar('Imovel alterado com sucesso', true); 
        return returnString;
      } else {
        Get.back();    
        mySnackBar(response['message'].toString(), false);
        return returnErrorString;// Retorna uma String indicando o erro
      }
    } catch (e) {
      Get.back();
      print(e);
      return returnErrorString;// Retorna uma String indicando o erro
    }
  }

  changePage(int page, context) {
    currentPage.value = page;
    getUserProperties(context);

  }

  deleteProperty(context,property) async {
    showLoad(context);
    try{
      var response = await delete('properties/${property['id']}', myGlobalController.token);
      if(response['status'] == 200){
        Get.back();Get.back();
        myProperties.remove(property);
        totalItens.value = totalItens.value - 1;

        
      }else{
        Get.back();Get.back();
        mySnackBar(response['message'].toString(), false);
      }

    }catch (e){ 
      Get.back();Get.back();
      mySnackBar(e.toString(), false);
    }
    print(property['description']);

  }
  getUserProperties(context) async {
    MyGlobalController mgc = Get.find();
    var formJson = {
      'allProperties': true,
      'email': mgc.userInfo['email'],
      'announcementType': advertsType.value,
      'state': state.value,
    };

    if (status.value.isNotEmpty) {
      formJson['allProperties'] = false;
    }

    bool h = false;
    bool p = false;

    if (status.value == 'Arquivado') {
      h = false;
      p = false;
    } else if (status.value == 'Populares') {
      h = false;
      p = true;
    } else if (status.value == 'Destaques') {
      h = true;
      p = true;
    }

    if (!formJson['allProperties'] && h) {
      formJson.addAll({'onlyHighlighted': true});
    } else if (!formJson['allProperties'] && p) {
      formJson.addAll({'onlyPublished': true});
    }

    if (city.value.isNotEmpty) {
      formJson.addAll({'city': city.value});
    }
    if (shared.value.isNotEmpty && shared.value == 'Meus') {
      formJson.addAll({'shared': false});
    }else if(shared.value.isNotEmpty && shared.value == 'Compartilhados'){
      formJson.addAll({'shared': true});
    }
    
    if (advertsType.value == 'Ambas') {
      formJson['announcementType'] = '';
    }


    loading.value = true;

    try {
      var response = await put('dashboard/properties/filter?page=${currentPage.value + 1}', formJson, token:mgc.token);
      if (response['status'] == 200) {
        if(((response['data']['pagination']['total'] * 6) / ((currentPage.value + 1 ) * 6) <  currentPage.value + 1) && response['data']['pagination']['total'] > 0 ){
          print('entrei');
          currentPage.value = 0;
          getUserProperties(context);
        }else{
          myProperties.value = response['data']['properties'];
          totalItens.value = response['data']['pagination']['total'];
        }
        
        loading.value = false;
      } else {
        print('Erro ao buscar as propriedades: ${response['message']}');
      }
    } catch (e) {
      print('Erro ao buscar as propriedades: $e');
      loading.value = false;
    }
  }


  cleanFilters() async{
      state.value = '';
      city.value = '';
      shared.value = '';
      advertsType.value = '';
      status.value = '';
      isExpanded.value = false;
      await getUserProperties(Get.context!);
    }
  }

 


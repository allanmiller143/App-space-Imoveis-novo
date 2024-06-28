import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/AppPages/allHighligthedProperties/allHighligthedPropertiesController.dart';
import 'package:space_imoveis/services/api.dart';
import 'package:get/get.dart';


class HighligthedGridController extends GetxController {
  var isLoading = true.obs;
  var properties = [].obs;
  var currentPage = 0.obs;
  var totalItens = 0.obs;
  late MyGlobalController myGlobalController;



  @override
  void onInit() {
    super.onInit();

    myGlobalController = Get.find();
    fetchProperties();
  }

  void fetchProperties() async {
    Allhighligthedpropertiescontroller ahpc = Get.find();
    isLoading.value = true;
    Map<String,dynamic> formJson = {
      'propertyType': ahpc.propertyType.value,
      'bathrooms': ahpc.bathrooms.value,
      'bedrooms': ahpc.bedrooms.value,
      'parkingSpaces': ahpc.parkingSpaces.value,
      'city': ahpc.city.text,
      'state': ahpc.state.value,
      'minSize': ahpc.minSize.text,
      'maxSize': ahpc.maxSize.text,
      'onlyHighlighted' : true
    };

    for (var option in ahpc.options) {
      if(option['checked'] == true){
        formJson[option['dbValue'] as String] = option['checked'];
      }
    }





    print('${ahpc.propertyType.value}');
    try {
      var response = await put('properties/filter?page=${currentPage.value + 1}&limit=20',formJson);
      if (response['status'] == 200 || response['status'] == 201) {
        properties.value = response['data']['properties'];
        totalItens.value = response['data']['pagination']['total'];
      } else {
        print('API call failed');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
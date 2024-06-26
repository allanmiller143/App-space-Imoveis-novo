import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';
import 'package:get/get.dart';


class GridController extends GetxController {
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
    isLoading.value = true;
    Map<String,dynamic> formJson = {
      'propertyType': '',
      'bathrooms': '',
      'bedrooms': '',
      'parkingSpaces': '',
      'city': '',
      'state': '',
      'minSize': '',
      'maxSize': '',
    };
    try {
      var response = await put('properties/filter?page=${currentPage.value + 1}&isHighlighted=false&isPublished=true',formJson);
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
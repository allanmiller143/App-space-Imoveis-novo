import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/AppPages/advertiser_data/advertiser_data_page_controller.dart';
import 'package:space_imoveis/services/api.dart';
import 'package:get/get.dart';


class AdvertiserGridController extends GetxController {
  var isLoading = true.obs;
  var properties = [].obs;
  var currentPage = 0.obs;
  var totalItens = 0.obs;
  late MyGlobalController myGlobalController;
  late AdvertiserDataController controller;

  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
    controller = Get.find();
    fetchProperties();
  }

  void fetchProperties() async {
    isLoading.value = true;
    Map<String,dynamic> formJson = {
      'propertyType': '',
      'email': controller.advertiser['email'],
      'allProperties': true,
      'parkingSpaces': '',
      'state': '',

    };
    try {
      var response = await put('properties/filter?page=${currentPage.value + 1}',formJson);
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
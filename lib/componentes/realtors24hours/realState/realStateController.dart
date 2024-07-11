import 'package:flutter/material.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';
import 'package:get/get.dart';


class RealtorRealStateGridRealStateController extends GetxController {
  var isLoading = true.obs;
  var realStates = [].obs;
  var currentPage = 0.obs;
  var totalItens = 0.obs;
  var name = TextEditingController();
  var city = TextEditingController();

  var myProperties = [].obs;
  RxBool loading = false.obs;
  RxString state = ''.obs;



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
      'name': name.text,
      'city': city.text,
    };
    try {
      var response = await put('realstate/filter?page=${currentPage.value + 1}',formJson);
      if (response['status'] == 200 || response['status'] == 201) {
        realStates.value = response['data']['result'];
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
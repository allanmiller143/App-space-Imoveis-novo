import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';
import 'package:get/get.dart';


class PropertyController extends GetxController {
  var isLoading = true.obs;
  var properties = [].obs;
  late MyGlobalController myGlobalController;

  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
    fetchProperties();
  }

  void fetchProperties() async {
    try {
      var response = await get('properties/recommended');
      if (response['status'] == 200 || response['status'] == 201) {
        properties.value = response['data'];
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
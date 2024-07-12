// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class RealtorRealState24HoursController extends GetxController {

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

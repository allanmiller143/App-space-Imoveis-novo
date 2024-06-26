import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';

class AdvertiserDataController extends GetxController {
  late MyGlobalController myGlobalController;

  final String advertiserEmail = Get.parameters['email']!;
  late var advertiser = {};
  @override
  void onInit()async {
    super.onInit();
    myGlobalController = Get.find();
  }

  init() async {
    try{
      var response = await get('find/$advertiserEmail');
      if(response['status'] == 200 || response['status'] == 201){
        advertiser = response['data'];
      }else{
        print('deu ruim');
      }
    }catch(e){
      print('caiu no catch');
    }
    return true;
  }
}

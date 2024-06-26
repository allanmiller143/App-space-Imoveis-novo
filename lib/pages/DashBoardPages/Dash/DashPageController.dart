import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';


class DashPageController extends GetxController {
  late MyGlobalController myGlobalController;
  RxString totalLikes = '0'.obs;
  RxString totalViews = '0'.obs;
  RxList top3 = [].obs;
  List SeenList = [];
  List likesList = [];

  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
  
  }

  init() async {
    await getLikes();
    await getViews();
    await getTop3();
    await getSeenList();
    await getLikesList();
    return true;
  }

getLikes() async {
  try {
    var response = await get('dashboard/likes', token: myGlobalController.token);
    if (response['status'] == 200 || response['status'] == 201) {
      totalLikes.value = response['data']['total'].toString();
    } else {
      print('deu ruim no else');
    }
  } catch (error) {
    print(error);
  }
}

getViews() async {
  try {
    var response = await get('dashboard/views', token: myGlobalController.token);
    if (response['status'] == 200 || response['status'] == 201) {
      totalViews.value = response['data']['total'].toString();
    } else {
      print('deu ruim no else');
    }
  } catch (error) {
    print(error);
  }
}


getTop3() async {
  try {
    var response = await get('dashboard/top/properties', token: myGlobalController.token);
    if (response['status'] == 200 || response['status'] == 201) {

      top3.value = response['data'];
    } else {
      print('deu ruim no else');
    }
  } catch (error) {
    print(error);
  }
}

getSeenList() async {
  try {
    var response = await get('dashboard/views/monthly', token: myGlobalController.token);
    if (response['status'] == 200 || response['status'] == 201) {
      SeenList = response['data'];
      print( SeenList);
    } else {
      print('deu ruim no else');
    }
  } catch (error) {
    print(error);
  }
}

getLikesList() async {
  try {
    var response = await get('dashboard/likes/monthly', token: myGlobalController.token);
    if (response['status'] == 200 || response['status'] == 201) {
      likesList = response['data'];
      print( likesList);
    } else {
      print('deu ruim no else');
    }
  } catch (error) {
    print(error);
  }
}


}

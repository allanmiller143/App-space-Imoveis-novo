import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/Chat_Socket_Controller.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/Chat/ChatService/ChatApi.dart';
import 'package:space_imoveis/services/api.dart';

class ChatsPageController extends GetxController {
  RxBool searchBar = false.obs;
  var chats = [].obs;
  var tempChats = [].obs;

  
  late MyGlobalController myGlobalController; 
  late Chat_Socket_Controller chat_socket_controller;

  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
    chat_socket_controller = Get.find();
    init(); // Call init when the controller is initialized
  }

  Future<void> init() async {
    // Fetch data from API or local data source
    myGlobalController = Get.find();
    await getChats();
    tempChats.assignAll(chats); // Initialize tempChats with the original chats
  }

  Future<void> getChats() async {
    try {
      var response = await get('chat', token: myGlobalController.token);
      if (response['status'] == 200 || response['status'] == 201) {
        chats.value = response['data'];
        tempChats.assignAll(chats); // Initialize tempChats with the original chats
        print(chats);
      } else {
        print('An error occurred');
      }
    } catch (e) {
      print(e);
    }
  }

  void search(String valor) async {
    if (valor.isEmpty) {
      tempChats.assignAll(chats); // Show all chats when the search input is cleared
      searchBar.value = false;
    } else {
      searchBar.value = true;
      var filteredChats = chats.where((chat) {
        final user = chat['user1']['email'] == myGlobalController.userInfo['email']
            ? chat['user2']
            : chat['user1'];
        final userName = user['type'] != 'realstate' ? user['name'] : user['companyName'];
        return userName != null && userName.toLowerCase().contains(valor.toLowerCase());
      }).toList();

      tempChats.assignAll(filteredChats);
    }
  }
}


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:space_imoveis/config/controllers/Chat_Socket_Controller.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/config/routes/routes.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/firebase_options.dart';
import 'package:space_imoveis/pages/Chat/ChatService/ChatApi.dart';
import 'package:space_imoveis/services/notifications/firebase_notification.dart';


void main() async {
  Chat_Socket_Controller chat_socket_controller =  Get.put(Chat_Socket_Controller());
  Get.put(MyGlobalController()); // carregar coisas por dentro da aplicação
  Get.put(ChatService(chat_socket_controller.socket));
  WidgetsFlutterBinding.ensureInitialized(); // carregar coisas por fora da aplicação
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotification();

  runApp(const MyApp()); // rodar a aplicação
}



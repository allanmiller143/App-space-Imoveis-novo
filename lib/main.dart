
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/config/routes/routes.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/firebase_options.dart';


void main() async {
  Get.put(MyGlobalController()); // carregar coisas por dentro da aplicação
  WidgetsFlutterBinding.ensureInitialized(); // carregar coisas por fora da aplicação
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); // rodar a aplicação
}


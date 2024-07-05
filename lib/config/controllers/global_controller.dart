
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGlobalController extends GetxController {
  var userInfo;
  RxBool internet = true.obs;
  late String token;
  RxInt counter = 0.obs;
  RxList<dynamic> userFavorites = <dynamic>[].obs; // userFavorites como RxList<String>
  var color = Color.fromARGB(255, 9, 47, 70);
  var color2 = Color.fromARGB(13, 52, 52, 52);
  var color3 = Color.fromARGB(255, 44, 87, 109);

}


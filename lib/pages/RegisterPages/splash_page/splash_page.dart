import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/AppPages/home/home.dart';
import 'package:uni_links2/uni_links.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _handleStartupLogic();
  }

  Future<void> _handleStartupLogic() async {
    await _checkLoginStatus();
    final Uri? initialLink = await getInitialUri();

    if (initialLink != null) {
      // Handle the deep link
      _handleDeepLink(initialLink);
    } else {
      // No deep link, navigate to home
      _navigateToHomePage();
    }
  }

  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    if (user != null) {
      MyGlobalController myGlobalController = Get.find();
      final String? token = prefs.getString('token');
      final String? userFavorites = prefs.getString('userFavorites');

      myGlobalController.userInfo = jsonDecode(user);
      myGlobalController.token = token!;

      if (userFavorites != null) {
        List<dynamic> favoritesList = jsonDecode(userFavorites);
        myGlobalController.userFavorites.value = favoritesList.cast<String>();
      } else {
        myGlobalController.userFavorites.value = [];
      }
    }
  }

  void _handleDeepLink(Uri link) {
    if (link.pathSegments.contains('property_detail')) {
      final String propertyId = link.pathSegments.last;
      Get.offNamed('/property_detail/$propertyId');
    } else if(link.pathSegments.contains('advertiser_data')){
      final String email = link.pathSegments.last;
      Get.offNamed('/advertiser_data/$email');
    } else {
      _navigateToHomePage();
    }
  }

  void _navigateToHomePage() {
    Get.off(Home());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

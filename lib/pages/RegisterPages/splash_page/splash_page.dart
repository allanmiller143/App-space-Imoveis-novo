import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/AppPages/home/home.dart';
import 'package:space_imoveis/pages/RegisterPages/login_page/login_page.dart';
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
    final bool isLoggedIn = await _checkLoginStatus();
    final Uri? initialLink = await getInitialUri();

    if (initialLink != null) {
      // Handle the deep link
      _handleDeepLink(initialLink, isLoggedIn);
    } else {
      // No deep link, navigate to home or login based on login status
      _navigateToInitialPage(isLoggedIn);
    }
  }

  Future<bool> _checkLoginStatus() async {
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

      return true;
    } else {
      return false;
    }
  }

  void _handleDeepLink(Uri link, bool isLoggedIn) {
    if (link.pathSegments.contains('property_detail')) {
      final String propertyId = link.pathSegments.last;
      Get.offNamed('/property_detail/$propertyId');
    } else {
      _navigateToInitialPage(isLoggedIn);
    }
  }

  void _navigateToInitialPage(bool isLoggedIn) {
    if (isLoggedIn) {
      Get.off(Home());
    } else {
      Get.off(LoginPage());
    }
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

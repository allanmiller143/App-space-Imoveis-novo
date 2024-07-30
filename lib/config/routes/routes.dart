
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/pages/AppPages/RealtorRealState24Hours/RealtorRealState24Hours.dart';
import 'package:space_imoveis/pages/AppPages/allHighligthedProperties/allHighligthedProperties.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/Conversation.dart';
import 'package:space_imoveis/pages/DashBoardPages/EditPropertyPage/EditPropertyPage.dart';
import 'package:space_imoveis/pages/DashBoardPages/MainDashPage/MainDashPage.dart';
import 'package:space_imoveis/pages/AppPages/advertiser_data/advertiser_data_page.dart';
import 'package:space_imoveis/pages/AppPages/edit_profile_data/edit_profile_data.dart';
import 'package:space_imoveis/pages/AppPages/insert_property/insert_property.dart';
import 'package:space_imoveis/pages/AppPages/property_detail_page/property_detail_page.dart';
import 'package:space_imoveis/pages/RegisterPages/complete_signUp__bio_page/complete_signUp__bio_page.dart';
import 'package:space_imoveis/pages/RegisterPages/complete_signUp_page/complete_signUp_page.dart';
import 'package:space_imoveis/pages/AppPages/home/home.dart';
import 'package:space_imoveis/pages/RegisterPages/login_page/login_page.dart';
import 'package:space_imoveis/pages/RegisterPages/signUp_page/signUp_page.dart';
import 'package:space_imoveis/pages/RegisterPages/splash_page/splash_page.dart';
import 'package:space_imoveis/pages/RegisterPages/who_are_you_page/who_are_you_page.dart';

class MyApp extends StatelessWidget {
  
  const MyApp({super.key,chatId});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        splashColor: Colors.transparent, // Remove o efeito de ondulação
        highlightColor: Colors.transparent, // Remove o efeito de highlight
      ),
      
      getPages: [
        //GetPage(name: '/', page: () => Home(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),

        GetPage(name: '/', page: () => SplashPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/main_dash', page: () => MainDashPage(),transition: Transition.leftToRight,transitionDuration: const Duration(milliseconds: 400)),

        GetPage(name: '/login', page: () => LoginPage(),transition: Transition.leftToRight,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/who_are_you_page', page: () => WhoAreYouPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/sign_up', page: () => SignUpPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/complete_sign_up', page: () => CompleteSignUpPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/complete_sign_up_bio', page: () => CompleteSignUpBioPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/home', page: () => Home(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/edit_profile_data', page: () => EditProfileDataPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(
          name: '/property_detail/:id',
          page: () => PropertyDetail(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 400),
          preventDuplicates: false,
        ),
        GetPage(name: '/advertiser_data/:email', page: () => AdvertiserDataPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400),preventDuplicates: false),
        GetPage(name: '/insert_property', page: () => InsertProperty(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400),preventDuplicates: false),
        GetPage(name: '/all_highligthed_property', page: () => AllhighligthedpropertiesPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400),preventDuplicates: false),
        GetPage(name: '/edit_property', page: () => EditProperty(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400),preventDuplicates: false),
        GetPage(name: '/edit_property', page: () => EditProperty(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400),preventDuplicates: false),
        GetPage(name: '/chat_conversation', page: () => ConversationPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400),preventDuplicates: false),
        GetPage(name: '/realtor_real_state_24_hours', page: () => RealtorRealState24Hours(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400),preventDuplicates: false),


      ],
    );
  }
}

// class SplashPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Verifique se há um link profundo ao iniciar o aplicativo
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       handleDeepLink();
//     });

//     return Scaffold(
//       body: Center(child: Text('Splash Page')),
//     );
//   }

//   void handleDeepLink() {
//     // Obtenha o link profundo e navegue para a página apropriada
//     final uri = Uri.base;
//     if (uri.scheme == 'myapp' && uri.host == 'property_detail') {
//       final propertyId = uri.pathSegments[1];
//       Get.toNamed('/property_detail/$propertyId');
//     }
//   }
// }

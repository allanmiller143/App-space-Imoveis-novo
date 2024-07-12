import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/pages/AppPages/advertiser_data/advertiser_data_page_controller.dart';
import 'package:space_imoveis/pages/AppPages/home/home_controller.dart';

class AdvertiserDataHeader extends StatelessWidget {
  var advertiserData;

  AdvertiserDataHeader({
    Key? key,
    required this.advertiserData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdvertiserDataController adc = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    if(Get.isRegistered<HomeController>()){
                      print('entrei aqui');
                      Get.back();
                    }else{
                      print('Entrei no else');
                      Get.offAllNamed('/home');
                    }  
                  },
                ),
              ),
            ),
          
        ),
        Text(
          'Perfil do anunciante',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    adc.shareAdvertiserLink(context);
                  },
                ),
              ),
            
          ),
        ),
      ],
    );
  }
}

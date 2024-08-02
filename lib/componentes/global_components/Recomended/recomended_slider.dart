import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/Recomended/recomended_slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:space_imoveis/componentes/global_components/home_carousel_slider/card.dart';
import 'package:space_imoveis/componentes/global_components/home_carousel_slider/loading_card.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';


class RecomendedCarousel extends StatelessWidget {
  final List<dynamic> properties;
  final MyGlobalController globalController;
  const RecomendedCarousel({required this.properties, required this.globalController, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  
    Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: properties.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 225,
            child: PropertyCard(
              property: properties[index],
            ),
          );
        },
      ),
    );
                   
  }
}


class RecomenedLoadingCarousel extends StatelessWidget {
  const RecomenedLoadingCarousel({ Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return     Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 225,
            child: PropertyLoadingCard()
          );
        },
      ),
    );
  }
}



class RecomendedSlider extends StatelessWidget {
  final RecomenedCarouselController controller = Get.put(RecomenedCarouselController());
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,15,0,0),
              child: Text(
                'Você pode gostar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                ),
              ),
            ),
            controller.isLoading.value ? 
            RecomenedLoadingCarousel() 
            :
            RecomendedCarousel(properties: controller.properties, globalController: controller.myGlobalController),
          ],
        )
    );
  }
}
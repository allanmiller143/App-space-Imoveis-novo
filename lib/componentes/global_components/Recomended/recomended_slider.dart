import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/Recomended/Recomended_slider_card.dart';
import 'package:space_imoveis/componentes/global_components/Recomended/recomended_slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:space_imoveis/componentes/global_components/home_carousel_slider/loading_card.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';


class RecomendedCarousel extends StatelessWidget {
  final List<dynamic> properties;
  final MyGlobalController globalController;
  const RecomendedCarousel({required this.properties, required this.globalController, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: properties.length,
      itemBuilder: (context, index, realIdx) {
        var property = properties[index];
        globalController.userFavorites.contains(property['id']);
        return RecomendedPropertyCard(property: property);
      },
      options: CarouselOptions(
        height: 130, // Adjust the height to control the size of the cards
        enlargeCenterPage: false,
        disableCenter: true,

        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 1000),
        autoPlayInterval: Duration(seconds: 5),
        viewportFraction: 0.33,
      ),
    );
  }
}


class RecomenedLoadingCarousel extends StatelessWidget {
  const RecomenedLoadingCarousel({ Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 0,
      itemBuilder: (context, index, realIdx) {
        return PropertyLoadingCard();
      },
      options: CarouselOptions(
        height: 160, // Adjust the height to control the size of the cards
        enlargeCenterPage: false,
        autoPlay: true,
        aspectRatio: 16 / 6,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 1000),
        autoPlayInterval: Duration(seconds: 5),
        viewportFraction: 0.3333,
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
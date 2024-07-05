import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/Grid/HighligthedGridController.dart';
import 'package:space_imoveis/componentes/global_components/Grid/card.dart';
import 'package:space_imoveis/componentes/global_components/home_carousel_slider/loading_card.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class HighligthedPropertyGrid extends StatelessWidget {
  final String title;

  HighligthedPropertyGrid({Key? key, required this.title}) : super(key: key);

  final HighligthedGridController controller = Get.put(HighligthedGridController());
  final MyGlobalController globalController = Get.find();
  final GlobalKey _titleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
            shrinkWrap: true, // Allow GridView to shrink and expand
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5,
              childAspectRatio: 0.75,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return PropertyLoadingCard();
            },
          ),
        );
      } else if (controller.properties.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              key: _titleKey,
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
              shrinkWrap: true, // Allow GridView to shrink and expand
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5,
                childAspectRatio: 0.7, // Aspect ratio between width and height
              ),
              itemCount: controller.properties.length,
              itemBuilder: (context, index) {
                var property = controller.properties[index];
                return PropertyCard2(property: property);
              },
            ),
            NumberPaginator(
              initialPage: controller.currentPage.value,
              numberPages: ((controller.totalItens / 20).ceil()),
              onPageChange: (int index) {
                controller.currentPage.value = index;
                controller.fetchProperties();
              },
              showNextButton: true,
              showPrevButton: true,
              config: NumberPaginatorUIConfig(
                buttonSelectedBackgroundColor: controller.myGlobalController.color,
                buttonUnselectedForegroundColor: const Color.fromARGB(255, 0, 0, 0),
                buttonUnselectedBackgroundColor: Colors.white,
                buttonSelectedForegroundColor: Colors.white,
                buttonPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                buttonShape: CircleBorder(),
                height: 35,
                buttonTextStyle: TextStyle(fontSize: 10),
              ),
            ),
          ],
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                key: _titleKey,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Ops!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Não foram encontrados imóveis.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                width: 50,
                height: 50,
                child: Image.asset('assets/imgs/logo.png', height: 300),
              ),
            ],
          ),
        );
      }
    });
  }
}

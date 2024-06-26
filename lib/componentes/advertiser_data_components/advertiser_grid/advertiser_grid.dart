import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/advertiser_grid/advertiser_gridController.dart';
import 'package:space_imoveis/componentes/global_components/Grid/card.dart';
import 'package:space_imoveis/componentes/global_components/home_carousel_slider/loading_card.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class AdvertiserPropertyGrid extends StatelessWidget {
  final String title;
  AdvertiserPropertyGrid({Key? key, required this.title}) : super(key: key);

  final AdvertiserGridController controller = Get.put(AdvertiserGridController());
  final MyGlobalController globalController = Get.find();
  final GlobalKey _titleKey = GlobalKey();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? Container(
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              controller: scrollController,
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
          )
        : controller.properties.isNotEmpty
            ? Column(
                children: [
                  Padding(
                    key: _titleKey,
                    padding: const EdgeInsets.all(0),
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      controller: scrollController,
                      physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                      shrinkWrap: true, // Allow GridView to shrink and expand
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.75, // Aspect ratio between width and height
                      ),
                      itemCount: controller.properties.length,
                      itemBuilder: (context, index) {
                        var property = controller.properties[index];
                        return PropertyCard2(property: property);
                      },
                    ),
                  ),
                  NumberPaginator(
                    initialPage: controller.currentPage.value,
                    numberPages: ((controller.totalItens / 6).ceil()),
                    onPageChange: (int index) {
                      controller.currentPage.value = index;
                      controller.fetchProperties();
                      scrollController.animateTo(
                        500,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    showNextButton: true,
                    showPrevButton: true,
                    config: NumberPaginatorUIConfig(
                      buttonSelectedBackgroundColor: const Color.fromARGB(255, 168, 192, 211), // Cor de fundo do botão selecionado
                      buttonUnselectedForegroundColor: const Color.fromARGB(255, 0, 0, 0), // Cor do texto dos botões não selecionados
                      buttonUnselectedBackgroundColor: Colors.white, // Cor de fundo dos botões não selecionados
                      buttonSelectedForegroundColor: Colors.white, // Cor do texto do botão selecionado
                      buttonPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      buttonShape: CircleBorder(),
                      height: 35, // Altura do botão
                      buttonTextStyle: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  children: [
                  Padding(
                    key: _titleKey,
                    padding: const EdgeInsets.all(0),
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
                    Text(
                      'Ops!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Parece que o anunciante não possui imóveis para mostrar',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/imgs/logo.png', height: 300),
                    )
                  ],
                ),
              )
            );
  }
}

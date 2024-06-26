import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/Recomended/recomended_slider.dart';
import 'package:space_imoveis/componentes/global_components/app_bar.dart';
import 'package:space_imoveis/componentes/global_components/drawer.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/componentes/property_detail_components/advertiser_mini_card.dart';
import 'package:space_imoveis/componentes/property_detail_components/buy_rent_visit.dart';
import 'package:space_imoveis/componentes/property_detail_components/property_detail_card1.dart';
import 'package:space_imoveis/componentes/property_detail_components/property_detail_img_carrossel.dart';
import 'package:space_imoveis/pages/AppPages/advertiser_data/advertiser_data_page_controller.dart';
import 'package:space_imoveis/pages/AppPages/property_detail_page/property_detail_page_controller.dart';

// ignore: must_be_immutable
class PropertyDetail extends StatelessWidget {
  PropertyDetail({Key? key}) : super(key: key);
  var controller = Get.put(PropertyDetailController());
  Future<void> _refreshPage() async {
    await controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<PropertyDetailController>(
        init: PropertyDetailController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white), // Define o ícone do Drawer como branco
              backgroundColor: controller.myGlobalController.color,
              centerTitle: true,
              title: MyAppBar(myGlobalController: controller.myGlobalController),
            ),
            drawer: MyDrawer(myGlobalController: controller.myGlobalController),
            body: FutureBuilder(
              future: controller.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: _refreshPage,
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10,10,10,10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PropertyDetailImgCarrossel(property: controller.property, globalController: controller.myGlobalController),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10,0,10,0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15),
                                        AdvertiserMiniCard(
                                          onPressed: (){
                                            if(controller.property['seller']['type']== 'owner'){
                                              mySnackBar('Este anunciante não posssui Perfil por não ser um corretor ou imobiliária', false);
                                            }else{
                                              if(Get.isRegistered<AdvertiserDataController>()){
                                                Get.delete<AdvertiserDataController>();
                                              }          
                                              Get.toNamed('/advertiser_data/${controller.property['seller']['email']}');
                                            }
                                          },
                                          advertiserData: controller.property,
                                        ),
                                        SizedBox(height: 15),
                                        PropertyDetailCard1(
                                          onPressed: (){ },
                                          propertyData: controller.property,
                                        ),
                                        SizedBox(height: 15),
                                        BuyRentVisit(
                                          onPressed: (){},
                                          advertiserData: controller.property,
                                        ),
                                        RecomendedSlider(),  
                                        
                                                                           
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: const Text('Ocorreu um erro inesperado'));
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 253, 72, 0),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
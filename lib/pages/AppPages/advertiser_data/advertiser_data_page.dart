import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/Comments/ratingSummary.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/advertiser_grid/advertiser_grid.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/advertiser_header.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/advertiser_info_data.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/advertiser_most_Seen.dart';
import 'package:space_imoveis/pages/AppPages/advertiser_data/advertiser_data_page_controller.dart';

// ignore: must_be_immutable
class AdvertiserDataPage extends StatelessWidget {
  AdvertiserDataPage({Key? key}) : super(key: key);
  var controller = Get.put(AdvertiserDataController());
  Future<void> _refreshPage() async {
    await controller.init();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<AdvertiserDataController>(
        init: AdvertiserDataController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(
              backgroundColor: controller.myGlobalController.color,
              centerTitle: true,
              title: AdvertiserDataHeader(advertiserData: controller.advertiser), 
            ),
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
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AdvertiserInfoData(advertiserData: controller.advertiser,),
                                  SizedBox(height: 20),
                                  AdvertiserMostSeen( advertiserData: {},),
                                  SizedBox(height: 20),
                                  AdvertiserPropertyGrid(title: 'Imóveis do anunciante',),
                                  SizedBox(height: 10 ),
                                  RatingSummaryWidget(email: controller.advertiser['email'],advertiserData: controller.advertiser,), SizedBox(height: 15),


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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/app_bar.dart'; // Certifique-se de que este caminho está correto
import 'package:space_imoveis/componentes/global_components/drawer.dart';
import 'package:space_imoveis/componentes/global_components/home_banner_sliders.dart';
import 'package:space_imoveis/componentes/realtors24hours/menu.dart';
import 'package:space_imoveis/pages/AppPages/RealtorRealState24Hours/RealtorRealState24HoursController.dart';
import 'package:space_imoveis/pages/AppPages/home/home_controller.dart';

// ignore: must_be_immutable
class RealtorRealState24Hours extends StatelessWidget {
  RealtorRealState24Hours({Key? key}) : super(key: key);
  var controller = Get.put(RealtorRealState24HoursController());

  Future<void> _refreshPage() async {
    await controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<HomeController>(
        init: HomeController(),
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              HomeBannerCarousel(),
                              
                              CustomMenuExample(),
                              
                            ],
                          ),
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

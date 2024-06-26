import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/allHighligthedPropertiesFilter.dart';
import 'package:space_imoveis/componentes/global_components/Grid/grid.dart';
import 'package:space_imoveis/componentes/global_components/app_bar.dart'; // Certifique-se de que este caminho está correto
import 'package:space_imoveis/componentes/global_components/drawer.dart';
import 'package:space_imoveis/componentes/home/filterCards.dart';
import 'package:space_imoveis/pages/AppPages/allHighligthedProperties/allHighligthedPropertiesController.dart';


// ignore: must_be_immutable
class AllhighligthedpropertiesPage extends StatelessWidget {
  AllhighligthedpropertiesPage({Key? key}) : super(key: key);
  var controller = Get.put(Allhighligthedpropertiescontroller());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<Allhighligthedpropertiescontroller>(
        init: Allhighligthedpropertiescontroller(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255,255,255,255),
            appBar: AppBar(
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
                    return SingleChildScrollView(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      
                                      builder: (BuildContext context) {
                                        return FractionallySizedBox(
                                          widthFactor: 1,
                                          child: CustomDrawer(),
                                        );
                                      },
                                    );
                                  },
                                  child: Text('Open Drawer'),
                                ),
                                FiltersCards(),
                                SizedBox(height: 10),               
                                PropertyGrid(title: 'Encontre o imovel ideal',),
                              ],
                            ),
                          ),
                        ],
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

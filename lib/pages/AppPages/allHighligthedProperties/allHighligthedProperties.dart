import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/Grid/HighligthedPropertyGrid.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/filterCards.dart';
import 'package:space_imoveis/componentes/global_components/Dialogs/informationDialog/information_dialog.dart';
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
              iconTheme: IconThemeData(color: Colors.white), // Define o ícone do Drawer como branco
              backgroundColor: controller.myGlobalController.color,
              centerTitle: true,
              title: Row(
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
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    
                  ),
                  Text(
                    'Imóveis em destaque',	
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
                              Icons.info_outline,
                              size: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MyInformationDialog(
                                    title: 'Destaques',
                                    subtitle: 'Encontre os imóveis mais cobiçados pelos nossos clientes na página de imóveis em destaque',
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      
                    ),
                  ),
                ],
              )
            ),
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
                                //HomeBannerCarousel(),
                                SizedBox(height: 10),
                                HighligthedFiltersCards(),
                                SizedBox(height: 10),               
                                HighligthedPropertyGrid(title: 'Imóveis em destaque',),
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

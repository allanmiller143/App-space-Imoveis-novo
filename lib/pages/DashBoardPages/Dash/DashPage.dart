import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/DashBoardComponents/Insights/chats.dart';
import 'package:space_imoveis/componentes/DashBoardComponents/Insights/insightCards.dart';
import 'package:space_imoveis/componentes/global_components/home_carousel_slider/card.dart';
import 'package:space_imoveis/pages/DashBoardPages/Dash/DashPageController.dart';

class DashPage extends StatelessWidget {
  DashPage({Key? key}) : super(key: key);
  final controller = Get.put(DashPageController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: controller.myGlobalController.color,
        toolbarHeight: 80,
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
                  'Meus imoveis',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
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
                            Icons.info,
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
              ],
            ),
            ),
      body: FutureBuilder(
        future: controller.init(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    Text(
                        'Dados gerais',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color : controller.myGlobalController.color),
                      ),
                      SizedBox(height: 5),
                      Column(
                        children: [
                          Obx(() => CardInfo(title: 'Visualizações',subtitle: 'Número de visualizações',value: controller.totalViews.value,icon: Icons.visibility,)),
                          SizedBox(height: 5),
                          Obx(() => CardInfo(title: 'Curtidas',subtitle: 'Número de curtidas',value: controller.totalLikes.value,icon: Icons.thumb_up,)),
                          SizedBox(height: 5),
                          CardInfo(title: 'Imóveis em Negociação',subtitle: 'Número de imóveis em negociação',value: '0',icon: Icons.home,),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Top 3 Mais Vistos',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color : controller.myGlobalController.color),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.top3.length > 3 ? 3 : controller.top3.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 225,
                              child: PropertyCard(
                                property: controller.top3[index],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Charts( title: 'Visualizações/mês',data: controller.SeenList),
                      SizedBox(height: 8),
                      Charts( title: 'Likes/mês',data: controller.likesList),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text('Ocorreu um erro inesperado'));
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            );
          }
        },
      ),
    );
  }
}

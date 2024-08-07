// ignore_for_file: must_be_immutabl
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Chats/Chats.dart';
import 'package:space_imoveis/pages/DashBoardPages/Dash/DashPage.dart';
import 'package:space_imoveis/pages/DashBoardPages/MyPropertiesPage/MyPropertiesPage.dart';

class PrincipaAppController extends GetxController {
  RxInt opcaoSelecionada = 0.obs;
  Color corItemSelecionado = Color.fromARGB(255, 255, 255, 255);
  Color corItemNaoSelecionado = Color.fromARGB(255, 115, 124, 136);
  MyGlobalController myGlobalController = Get.find();
  Future<String> func() async{
    return 'allan';
  }

  void mudaOpcaoSelecionada(int index) {
    opcaoSelecionada.value = index;
  }
}


class MainDashPage extends StatelessWidget {
  const MainDashPage({super.key});

  @override
  Widget build(BuildContext context) {
    var principaAppController = PrincipaAppController();
    return MaterialApp(
      home: GetBuilder<PrincipaAppController>(
          init: PrincipaAppController(),
          builder: (_) {
            return Scaffold(
              backgroundColor: principaAppController.myGlobalController.color,
             
              bottomNavigationBar: Obx(
                () => Container(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(width: 0.1, color: Colors.black))),    
                    child: BottomNavigationBar(
                    elevation: 8,
                    onTap: (index) {
                      principaAppController.mudaOpcaoSelecionada(index);
                    },
                    type: BottomNavigationBarType.fixed,
                    currentIndex: principaAppController.opcaoSelecionada.value,
                    backgroundColor: principaAppController.myGlobalController.color,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard),
                        label: 'DashBoard',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.chat),
                        label: 'chat',
                      ),
                   
                    ],
                    selectedItemColor: principaAppController.corItemSelecionado,
                    unselectedItemColor:principaAppController.corItemNaoSelecionado,
                  ),
                ),
              ),
              body: FutureBuilder(
              future: principaAppController.func(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Obx(
                    () => IndexedStack(
                      index: principaAppController.opcaoSelecionada.value,
                      children: <Widget>[
                        MyPropertiesPage(),
                        DashPage(),
                        ChatsPage()
                       
                      ],
                    ),
                );
                  } else {
                    return const Text('Nenhum pet');
                  }
                } else if (snapshot.hasError) {
                  return Text(
                      'Erro ao carregar a listd de pets: ${snapshot.error}');
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  );
                }
              },
            ),
              
            );
          }),
    );
  }
}

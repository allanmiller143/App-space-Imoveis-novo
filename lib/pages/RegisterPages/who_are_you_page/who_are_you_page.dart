import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/drop_down.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/pages/RegisterPages/who_are_you_page/who_are_you_page_controller.dart';

// ignore: must_be_immutable
class WhoAreYouPage extends StatelessWidget {
  WhoAreYouPage({Key? key}) : super(key: key);
  var controller = Get.put(WhoAreYouPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<WhoAreYouPageController>(
        init: WhoAreYouPageController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 247, 247, 247),
            body: FutureBuilder(
              future: controller.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Stack(
                        children: [
                          Container(
                            child: SingleChildScrollView(
                              child: Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [controller.myGlobalController.color, controller.myGlobalController.color3],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.elliptical(MediaQuery.of(context).size.width, 90),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                                        child: Center(
                                          child: Text(
                                            controller.myGlobalController.userInfo != null && controller.myGlobalController.userInfo['type'] == 'client' ? 'Eleve Sua conta' :
                                            'Bem vindo!',
                                            style: TextStyle(
                                              color: const Color.fromARGB(255, 255, 255, 255),
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                        child: Material(
                                          elevation: 4,
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 20),
                                                Text(
                                                  'Quem é você?',
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    letterSpacing: 0.1,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0.8,
                                                    color: controller.myGlobalController.color,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  '(Propriétario, Corretor, Imobiliária)',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    letterSpacing: 0.1,
                                                    color: controller.myGlobalController.color3,
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                CustomDropdownButton(labelText: 'Tipo de usuário',items: ["Proprietário", "Corretor", "Imobiliária"],controller: controller.selectedUserType,),
                                                const SizedBox(height: 10),
                                                MyButtom(
                                                  onPressed: () {
                                                    controller.nextStep();
                                                  },
                                                  label: 'Continuar Cadastro',
                                                ),
                                                const SizedBox(height: 15),
                                                const Text(
                                                  'Ao me cadastrar, aceito os Termos de Uso e Política de Privacidade da Space Imóveis e afirmo ter 18 anos ou mais.',
                                                  style: TextStyle(fontSize: 13, letterSpacing: 0.1),
                                                  textAlign: TextAlign.center,
                                                ),
                                                TextButton(
                                                  style: const ButtonStyle(
                                                    fixedSize: WidgetStatePropertyAll(Size(200, 10)),
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                    'Já tem uma Conta? Clique aqui',
                                                    style: TextStyle(fontSize: 12, letterSpacing: 0.1, color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            left: 10,
                            child: IconButton(
                              icon: Icon(Icons.arrow_circle_left, size: 40, color: Color.fromARGB(255, 255, 255, 255)),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text('erro');
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

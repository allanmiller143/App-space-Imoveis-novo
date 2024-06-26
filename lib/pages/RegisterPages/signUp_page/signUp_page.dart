// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/pages/RegisterPages/signUp_page/signUp_page_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  var controller = Get.put(SignUpPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<SignUpPageController>(
        init: SignUpPageController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            body: FutureBuilder(
              future: controller.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Stack(

                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 125), // Espaço para o logo e botão voltar
                                  Text(
                                    'Bem-vindo ${controller.whoAreYouController.selectedUserType}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Color.fromARGB(223, 0, 0, 0),
                                    ),
                                  ),
                                  const Text(
                                    'Complete o cadastro e anuncie seus imóveis',
                                    style: TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 0.1,
                                      color: Color.fromARGB(166, 0, 0, 0),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Divider(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: controller.gerarTextFields(),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  MyButtom(
                                    onPressed: () {
                                      controller.register(context);
                                    },
                                    label: 'Cadastrar',
                                    buttomColor: controller.myGlobalController.color,
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Ao me cadastrar, aceito os Termos de Uso e Política de Privacidade da Space Imóveis e afirmo ter 18 anos ou mais.',
                                    style: TextStyle(fontSize: 13,letterSpacing: 0.1),
                                    textAlign: TextAlign.center,
                                  ),
                                  TextButton(
                                    style: const ButtonStyle(
                                      fixedSize: WidgetStatePropertyAll(Size(200, 10)),
                                    ),
                                    onPressed: (){Get.back();}, child: const Text('Já tem uma Conta? Clique aqui', style: TextStyle(fontSize: 12,letterSpacing: 0.1,color: Colors.black),)
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 50,
                              left: 10,
                              child: IconButton(
                              icon: Icon(Icons.arrow_circle_left, size: 40, color: controller.myGlobalController.color),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: MediaQuery.of(context).size.width * 0.5 - 40,
                              child: Image.asset(
                                'assets/imgs/logo.png',
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ],
                        
                      ),
                    );
                  } else {
                    return const Text('erro');
                  }
                } else {
                  return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 253, 72, 0)));
                }
              },
            ),
          );
        },
      ),
    );
  }
}

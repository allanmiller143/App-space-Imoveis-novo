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
                                          padding: const EdgeInsets.fromLTRB(0,50,0,0),
                                          child: Center(
                                            child: Text('Bem vindo!',
                                              style: TextStyle(
                                                color: const Color.fromARGB(255, 255, 255, 255),
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text('${controller.whoAreYouController.selectedUserType}',
                                            style: TextStyle(
                                              color: Color.fromARGB(200, 255, 255, 255),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                          child: Material(
                                            elevation: 4,
                                            borderRadius: BorderRadius.circular(10),
                                          
                                            child: Container(
                                              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                              width: MediaQuery.of(context).size.width,
                                              
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                
                                                children: [
              
                                                  Text(
                                              'Complete o cadastro e anuncie seus imóveis na Space Imóveis',
                                              style: TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 0.1,
                                                color: controller.myGlobalController.color,
                                                fontWeight: FontWeight.bold
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
                                              label:  'Cadastrar',
                                              buttomColor: controller.myGlobalController.color,
                                            ),
                                            const SizedBox(height: 5),
                                            const Text(
                                              'Ao me cadastrar, aceito os Termos de Uso e Política de Privacidade da Space Imóveis e afirmo ter 18 anos ou mais.',
                                              style: TextStyle(fontSize: 13,letterSpacing: 0.1),
                                              textAlign: TextAlign.center,
                                            ),

                
                                            

                                                  const SizedBox(height: 15),
                                                ],                   
                                              ),
                                            ),
                                          ),
                                        ),

                                  
                                      ],
                                    )
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


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/componentes/register_components/signUp_photo.dart';
import 'package:space_imoveis/pages/RegisterPages/complete_signUp_page/complete_signUp_page_controller.dart';

// ignore: must_be_immutable
class CompleteSignUpPage extends StatelessWidget {
  CompleteSignUpPage({Key? key}) : super(key: key);
  var controller = Get.put(CompleteSignUpPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<CompleteSignUpPageController>(
        init: CompleteSignUpPageController(),
        builder: (_) {
          return Scaffold(
            backgroundColor:const  Color.fromARGB(255, 247, 247, 247),
            body: FutureBuilder(
              future: controller.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Stack(
                        children: [ 
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SignUpPhoto(onPressed: (){controller.showBottomSheet(context);}, image: controller.imageFile),
                                  const SizedBox(height: 15,),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: const Text(
                                      'Vamos inserir uma foto de perfil?',
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Color.fromARGB(223, 0, 0, 0),
                                        height: 1.2                                      
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: const Text(
                                      'Corretores e imobiliárias com fotos de perfil tendem a ser mais bem vistos na plataforma',
                                      style: TextStyle(
                                        fontSize: 12,letterSpacing: 0.1,color: Color.fromARGB(166, 0, 0, 0),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MyButtom(
                                        onPressed: () {
                                          controller.jumpStep();
                                        },label: 'Pular',
                                        buttomColor: const Color.fromARGB(255, 165, 165, 165),
                                        textColor: const Color.fromARGB(255, 255, 255, 255),
                                        width: MediaQuery.of(context).size.width * 0.4,
                                      ),
                                      MyButtom(
                                        onPressed: () {
                                          controller.insertProfilePic(context);
                                        },
                                        label: 'Próximo',
                                        buttomColor: controller.myGlobalController.color,
                                        width: MediaQuery.of(context).size.width * 0.4,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: MediaQuery.of(context).size.width * 0.5 - 50,
                            child: Image.asset(
                              'assets/imgs/logo.png',
                              height: 100,
                              width: 100,
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

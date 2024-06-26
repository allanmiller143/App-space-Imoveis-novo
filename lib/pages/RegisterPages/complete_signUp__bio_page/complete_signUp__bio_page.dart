
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/pages/RegisterPages/complete_signUp__bio_page/complete_signUp__bio_page_controller.dart';

// ignore: must_be_immutable
class CompleteSignUpBioPage extends StatelessWidget {
  CompleteSignUpBioPage({Key? key}) : super(key: key);
  var controller = Get.put(CompleteSignUpPageBioController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<CompleteSignUpPageBioController>(
        init: CompleteSignUpPageBioController(),
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
                                  const SizedBox(height: 15,),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: const Text(
                                      'Vamos inserir uma Bio?',
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Color.fromARGB(223, 0, 0, 0),
                                        height: 1.2                                      
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: const Text(
                                      'Nos fale um pouco de você',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(223, 0, 0, 0),
                                        height: 1.2                                      
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: const Text(
                                      'Corretores e imobiliárias com uma bio detalhada tendem a ser mais bem vistos na plataforma, ',
                                      style: TextStyle(
                                        fontSize: 12,letterSpacing: 0.1,color: Color.fromARGB(166, 0, 0, 0),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  TextFormField(
                                    minLines: 1, // Número mínimo de linhas
                                    maxLines: 7, // Número máximo de linhas
                                    expands: false, // Para expandir automaticamente
                                    controller: controller.bio,
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),     
                                    decoration: const InputDecoration(
                                      hintText: 'Digite o seu texto aqui...',
                                      labelText: 'Bio',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 0.5),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)), // Define a borda como transparente
                                      ),
                                      focusedBorder: OutlineInputBorder(),
                                      focusColor: Colors.black,
                                      labelStyle: TextStyle(color: Colors.black),
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
                                          controller.insertBio(context);
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
                          // Positioned(
                          //   top: 50,
                          //   left: 10,
                          //   child: IconButton(
                          //     icon: Icon(Icons.arrow_circle_left, size: 40, color: controller.myGlobalController.color),
                          //     onPressed: () {
                          //       Get.back();
                          //     },
                          //   ),
                          // ),
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

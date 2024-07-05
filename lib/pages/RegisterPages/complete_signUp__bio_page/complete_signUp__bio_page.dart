
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/TextFields/biggerTextField.dart';
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
                    return Container(
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
                                padding: const EdgeInsets.fromLTRB(0,120,0,0),
            
                              ),

                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                child: Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(10),
                                
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                    width: MediaQuery.of(context).size.width,
                                    
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      
                                      children: [
                                       
                                  const SizedBox(height: 15,),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      'Vamos inserir uma Bio?',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: controller.myGlobalController.color,
                                        height: 1.2,
                                                                            
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      'Nos fale um pouco de você',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: controller.myGlobalController.color3,
                                        height: 1.2                                      
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      'Corretores e imobiliárias com uma bio detalhada tendem a ser mais bem vistos na plataforma, ',
                                      style: TextStyle(
                                        fontSize: 12,letterSpacing: 0.1,color: controller.myGlobalController.color,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  MyBiggerTextFormField(controller: controller.bio,hint: 'Bio',),


                                  
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
                                        width: MediaQuery.of(context).size.width * 0.35,
                                      ),
                                      MyButtom(
                                        onPressed: () {
                                          controller.insertBio(context);
                                        },
                                        label: 'Próximo',
                                        buttomColor: controller.myGlobalController.color3,
                                        width: MediaQuery.of(context).size.width * 0.35,
                                      ),
                                    ],
                                  ),
                               
                        
                                      ],                   
                                    ),
                                  ),
                                ),
                              ),

                         
                            ],
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

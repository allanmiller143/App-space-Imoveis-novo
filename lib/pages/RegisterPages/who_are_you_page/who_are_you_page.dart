
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            backgroundColor:const  Color.fromARGB(255, 247, 247, 247),
            body: FutureBuilder(
              future: controller.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Stack(
                        children: [ 
                          // Container(
                          //   width: double.infinity,
                          //   height: MediaQuery.of(context).size.height,
                          //   decoration: const BoxDecoration(
                          //     image: DecorationImage(
                          //       image: AssetImage('assets/imgs/background.png'),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Bem vindo à Space Imóveis!',
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Color.fromARGB(223, 0, 0, 0),
                                          height: 1.15, // Ajuste este valor conforme necessário

                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20,),
                                  const Text(
                                    'Quem é você',
                                    style: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: 0.1,
                                      fontWeight: FontWeight.w500,
                                      height: 0.8
                                    ),
                                  ),
                                  const Text(
                                    '(Propriétario, Corretor, Imobiliária)',
                                    style: TextStyle(
                                      fontSize: 11,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  DropdownSearch<String>(
                                      items: const ["Proprietário", "Corretor", "Imobiliária",],
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                            focusColor: Colors.black,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black),
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                              labelText: "Tipo de usuário",
                                              labelStyle: TextStyle(fontSize: 15),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              contentPadding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                                              
                                          ),
                                      ),
                                      onChanged: (value) {
                                        controller.selectedUserType = value.toString();
                                      },
                                  ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/register_components/forget_passwork.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/componentes/register_components/networks.dart';
import 'package:space_imoveis/componentes/register_components/no_account.dart';
import 'package:space_imoveis/componentes/global_components/text_form_field.dart';
import 'package:space_imoveis/pages/RegisterPages/login_page/login_page_controller.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  var controller = Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<LoginPageController>(
        init: LoginPageController(),
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
                          // Adicione o Container com a imagem de fundo
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
                                    'Bem-vindo',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                                      ),
                                  ),
                                  const Text(
                                    'Faça login e entre na sua conta',
                                    style: TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 0.1,
                                      fontFamily: 'OpenSans-VariableFont_wdth,wght',
                                      color: Color.fromARGB(166, 0, 0, 0),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  MyTextFormField(
                                    hint: 'user@gmail.com',
                                    controller: controller.email,
                                    obscureText: false,
                                    icon: const Icon(Icons.email),
                                  ),
                                  const SizedBox(height: 15),
                                  MyTextFormField(
                                    hint: '*************',
                                    controller: controller.password,
                                    obscureText: true,
                                    icon: const Icon(Icons.lock),
                                  ),
                                  const SizedBox(height: 15),
                                  MyButtom(
                                    onPressed: () {
                                      controller.login(context);
                                    },
                                    label: 'Login',
                                    buttomColor: controller.myGlobalController.color,
                                  ),
                                  ForgetPassword(),
                                  const SizedBox(height: 15),
                                  const Networks(),
                                  const SizedBox(height: 25),
                                  NoAccount(textColor: controller.myGlobalController.color),
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
                    return const Text('efghfghgfhfghgrro');
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
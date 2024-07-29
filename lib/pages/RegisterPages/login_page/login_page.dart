import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/register_components/forget_passwork.dart';
import 'package:space_imoveis/componentes/register_components/networks.dart';
import 'package:space_imoveis/componentes/register_components/no_account.dart';
import 'package:space_imoveis/componentes/global_components/TextFields/text_form_field.dart';
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
                                padding: const EdgeInsets.fromLTRB(0,50,0,0),
                                child: Center(
                                  child: Text('Login',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text('Entre na sua conta',
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
                                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                    width: MediaQuery.of(context).size.width,
                                    
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        MyTextFormField(
                                          hint: 'user@gmail.com',
                                          controller: controller.email,
                                          obscureText: false,
                                          icon: const Icon(Icons.email),
                                        ),
                                        const SizedBox(height: 15),
                                        MyTextFormField(
                                          hint: 'Senha',
                                          controller: controller.password,
                                          obscureText: true,
                                          icon: const Icon(Icons.lock),
                                        ),
                                        ForgetPassword(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            controller.login(context);  
                                          },
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(35,10,35,10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: controller.myGlobalController.color
                                              ),
                                              child: Text('Entrar',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                                            ),
                                          ),
                                        ), 
                                        const SizedBox(height: 15),
                                        const Networks(),
                                      ],                   
                                    ),
                                  ),
                                ),
                              ),

                              NoAccount(),


                         
                            ],
                          )
                        ],
                      ),
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
// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/AlertDialog/alert_header.dart';
import 'package:space_imoveis/componentes/global_components/load_widget.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key});
  var email = TextEditingController();
  var otp = TextEditingController();
  var pass = TextEditingController();
  var confirmPass = TextEditingController();
  RxString returnMessage = ''.obs;
  
  sendEmail(BuildContext context) async{
    if(email.text.isNotEmpty){
      try{
        showLoad(context);
        Map<String, String> data = {
          "email": email.text,
        };
        var sendEmailResponse = await post('rescue/password', data);
        if(sendEmailResponse['status'] == 200 || sendEmailResponse['status'] == 201){
          Get.back();Get.back();
          changePass(context); // abrir a segunda etapa do processo de trocar a senha 

        } 
        else{
          Get.back();
          returnMessage.value = sendEmailResponse['body']['message'];
        } 
      }on Exception {
        Get.back();
        returnMessage.value = 'Ocorreu um erro ao enviar o email';
      }
    }else{
      returnMessage.value = 'Preencha o campo de e-mail.';  
    }

  }
  change(BuildContext context) async {
    if (otp.text.isNotEmpty && pass.text.isNotEmpty && confirmPass.text.isNotEmpty) {
      if (pass.text == confirmPass.text) {
        try {
          showLoad(context);
          Map<String, String> data = {
            'email': email.text,
            'otp': otp.text,
            'password': pass.text
          };

          var changePassResponse = await post('reset/password', data);
          Get.back(); // Fecha o diálogo de carregamento
          if (changePassResponse['status'] == 200 || changePassResponse['status'] == 201) {
            Get.back(); // Fecha o diálogo de alteração de senha
            Get.snackbar(
              "Sucesso",
              'Senha alterada com sucesso',
              backgroundColor: Color.fromARGB(255, 119, 205, 28),
              colorText: Colors.white,
            );
            otp.text = '';
            email.text = '';
            pass.text = '';
            confirmPass.text = '';
            returnMessage.value = '';
          } else {
            returnMessage.value = changePassResponse['body'].toString();
          }
        } on Exception {
          Get.back(); // Fecha o diálogo de carregamento em caso de erro
          returnMessage.value = 'Ocorreu um erro ao alterar a senha';
        }
      } else {
        returnMessage.value = 'As senhas precisam ser iguais.';
      }
    } else {
      returnMessage.value = 'Preencha todos os campos.';
    }
  }
  
  void forgetPass(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        MyGlobalController mgc = Get.find();
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AlertDialogHeader(
                title: 'Esqueceu sua senha?',
                close: () {
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Digite seu e-mail para receber o código de recuperação.',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: 12
                        ),
                        labelText: 'E-mail',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 12
                        ), 
                         
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      style: TextStyle(fontSize: 12),
                      controller: email,
                      onChanged: (value) {
                        returnMessage.value = '';
                      },
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              returnMessage.value,
                              style: const TextStyle(color: Color.fromARGB(224, 144, 34, 7),fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        TextButton(
                          onPressed: () {
                            email.text = '';
                            Navigator.of(context).pop(); // Fecha o diálogo
                          },
                          child: const Text('Cancelar', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                        GestureDetector(
                          onTap: () {
                            sendEmail(context);
                          },  
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8,2,8,2),
                            decoration: BoxDecoration(
                              color: mgc.color,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text('Enviar', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 12)),
                          ),
                        ),
                      ],
                    )


                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void changePass(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Não fechar ao clicar fora
      builder: (BuildContext context) {
        MyGlobalController mgc = Get.find();
        return WillPopScope(
          onWillPop: () async => false, // Não fechar ao pressionar o botão "Voltar"
          child: SingleChildScrollView(
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AlertDialogHeader(
                    title: 'Um código foi enviado',
                    close: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Digite o código de recuperação e a sua nova senha nos campos abaixo.',
                          style: TextStyle(fontSize: 12),
                        ),
                        const Text(
                          'Sua nova senha precisa ter no mínimo 8 caracteres, uma letra maiúscula, uma letra minúscula e um número.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            labelText: 'Código',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12
                            ),                             focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          controller: otp,
                          onChanged: (value) {
                            returnMessage.value = '';
                          },
                        ),
                        TextField(
                          style: TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            labelText: 'Nova senha',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12
                            ),                             
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          controller: pass,
                          onChanged: (value) {
                            returnMessage.value = '';
                          },
                          obscureText: true,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            labelText: 'Confirmar nova senha',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12
                            ), 
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          controller: confirmPass,
                          onChanged: (value) {
                            returnMessage.value = '';
                          },
                          obscureText: true,
                        ),
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                returnMessage.value,
                                style: const TextStyle(color: Color.fromARGB(224, 144, 34, 7)),
                              ),
                            ),
                          ],
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                otp.text = '';
                                pass.text = '';
                                confirmPass.text = '';
                                Navigator.of(context).pop(); // Fecha o diálogo
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              ),
                              child: const Text('Cancelar', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                            ),
                            GestureDetector(
                              onTap: () {
                                change(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: mgc.color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  'Enviar',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MyGlobalController mgc = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: Text('Esqueceu a senha?', style: TextStyle(color: mgc.color3)),
          onPressed: () {
            forgetPass(context);
          },
        ),
      ],
    );
  }
}

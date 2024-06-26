

// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, unused_catch_clause

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/componentes/global_components/load_widget.dart';
import 'package:space_imoveis/componentes/global_components/simple_text_form_field.dart';
import 'package:space_imoveis/componentes/global_components/text_form_field.dart';
import 'package:space_imoveis/componentes/inser_property_components/mandatory.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/RegisterPages/who_are_you_page/who_are_you_page_controller.dart';
import 'package:space_imoveis/services/Complete_cep.dart';
import 'package:space_imoveis/services/api.dart';

class SignUpPageController extends GetxController {
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var cpf = TextEditingController();
  var rg = TextEditingController();
  var cep = TextEditingController();
  var number = TextEditingController();
  var street = TextEditingController();
  var neighborhood = TextEditingController();
  var city = TextEditingController();
  var uf = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var cnpj = TextEditingController();
  var creci = TextEditingController();
  var socialOne = TextEditingController();
  var socialTwo = TextEditingController();

  var activateStreet  = false.obs;
  var  activateNeighborhood = false.obs;

  late MyGlobalController myGlobalController;
  late WhoAreYouPageController whoAreYouController; 

  init() async {
    myGlobalController = Get.find();
    whoAreYouController = Get.find();
    return true;
  }

  Future<void> completarEndereco(cep) async {
    Map<String, dynamic> dados = await searchCep(cep);
    if(dados['bairro'] == ''){
      activateNeighborhood.value = true;
    }else{
      activateNeighborhood.value = false;
    }
    if(dados['logradouro'] == ''){
      activateStreet.value = true;
    }else{
      activateStreet.value = false;
    }
    
    city.text = dados["localidade"];
    uf.text = dados["uf"];
    neighborhood.text = dados['bairro'];
    street.text = dados['logradouro'];
  }

  List<Widget> gerarTextFields() {
    return [
      
      MandatoryOptional(text: 'Suas informações essenciais', subtext: 'Obrigatório', subtext2: 'Insira suas informaçõe, como nome, telefone, email e etc.'),
      const SizedBox(height: 4),
      whoAreYouController.selectedUserType != 'Imobiliária' ? MySimpleTextFormField(controller: name, hint: 'Nome Completo'):MySimpleTextFormField(controller: name, hint: 'Razão social'),
      const SizedBox(height: 8),
      MySimpleTextFormField(controller: email, hint: 'E-mail'),
      const SizedBox(height: 8),
      MySimpleTextFormField(controller: phone, hint: 'Telefone'),
      const SizedBox(height: 8),
      whoAreYouController.selectedUserType != 'Imobiliária' ? 
      Row(
        children: [
          Expanded(child: MySimpleTextFormField(controller: cpf, hint: 'CPF'),),
          const SizedBox(width: 10,),
          SizedBox(
            width: 140,
            child: MySimpleTextFormField(controller: rg, hint: 'RG',),  
          ),
        ],
      ):
      MySimpleTextFormField(controller: cnpj, hint: 'CNPJ'),
      whoAreYouController.selectedUserType != 'Proprietário'?  Column(
        children: [
          const SizedBox(height: 8),
          MySimpleTextFormField(controller: creci, hint: 'CRECI ex: CRECI-UF 00000'),
          const SizedBox(height: 8),
        ],
      ) : const SizedBox(height: 8,),
      MandatoryOptional(text: 'Endereço', subtext: 'Obrigatório', subtext2: 'Insira aqui as informações do seu endereço.'),
    
      const SizedBox(height: 4),
      MySimpleTextFormField(
        controller: cep,
        hint: 'CEP',
        enable: true,
        onChange: (value) async {
          if (value.length == 8) {
            await completarEndereco(cep.text);
          }
        },
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(child: Obx(()=> MySimpleTextFormField(controller: street, hint: 'Rua',enable: activateStreet.value,))),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: MySimpleTextFormField(controller: number, hint: 'N°'),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: MySimpleTextFormField(controller: city, hint: 'Cidade',enable: false),
          ),
          const SizedBox(width: 10,),
          SizedBox(
            width: 80,
            child: MySimpleTextFormField(controller: uf, hint: 'UF',enable: false,),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Obx(()=> MySimpleTextFormField(controller: neighborhood, hint: 'Bairro', enable: activateNeighborhood.value)),
      const SizedBox(height: 8),
      MandatoryOptional(text: 'Senha', subtext: 'Obrigatório', subtext2: 'Sua senha deve ter pelo menos 8 caracteres, com letras e números e um caractere especial'),
      const SizedBox(height: 4),
      MyTextFormField(controller: password, hint: 'Senha', obscureText: true,icon: const  Icon(Icons.lock),),
      const SizedBox(height: 8),
      MyTextFormField(controller: confirmPassword, hint: 'Confirmar Senha', obscureText: true,icon: const  Icon(Icons.lock),),
      
      whoAreYouController.selectedUserType != 'Proprietário' ? 
      Column(
        children: [
          const SizedBox(height: 8),
          MandatoryOptional(text: 'Redes Sociais', subtext: 'Obrigatório', subtext2: 'Insira suas redes sociais, como Facebook, Instagram e etc.'),
          const SizedBox(height: 4),
          MySimpleTextFormField(controller: socialOne, hint: 'Instagram'),
          const SizedBox(height: 8),          
          MySimpleTextFormField(controller: socialTwo, hint: 'Facebook'),
        ],
      ):SizedBox()
    
    ];
  }

  register(BuildContext context) async {
    // verificar se algum campo é vazio e definir a rota de inserção
    var fields = [name.text,email.text,phone.text,cpf.text,rg.text,cep.text,street.text,city.text,number.text,uf.text,neighborhood.text,password.text,confirmPassword.text,];
    var route = 'owners';
    if(whoAreYouController.selectedUserType == 'Imobiliária'){
      fields = [
        name.text,email.text,phone.text,cnpj.text,creci.text,cep.text,street.text,city.text,number.text,uf.text,neighborhood.text,password.text,confirmPassword.text,
      ];
      route = 'realstate';
    }else if(whoAreYouController.selectedUserType == 'Corretor'){
      fields = [
        name.text,email.text,rg.text,cpf.text,phone.text,creci.text,cep.text,street.text,city.text,number.text,uf.text,neighborhood.text,password.text,confirmPassword.text,
      ];
      route = 'realtors';
    }
    bool emptyFiled = false;

    for (var field in fields) { 
      if (field.isEmpty) {
        emptyFiled = true;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha todos os campos obrigatórios'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
        break;
      }
    }   
    if (!emptyFiled) {
      try {
        showLoad(context);
        Map<String, String> formData = {};
        if(whoAreYouController.selectedUserType == 'Imobiliária'){
          formData = {'company_name':name.text,'email':email.text,'password':password.text,'phone':phone.text,'creci':creci.text,'cep':cep.text,'cnpj':cnpj.text,'address':street.text,'house_number':number.text,'city':city.text,'district':neighborhood.text,'state':uf.text,'socialOne':socialOne.text,'socialTwo':socialTwo.text}; 
        }else if(whoAreYouController.selectedUserType == 'Corretor'){
          formData = {'name':name.text,'email':email.text,'password':password.text,'phone':phone.text,'creci':creci.text,'cep':cep.text,'rg':rg.text,'cpf':cpf.text,'address':street.text,'house_number':number.text,'city':city.text,'district':neighborhood.text,'state':uf.text,'socialOne':socialOne.text,'socialTwo':socialTwo.text};
        }else{
          formData = {'name':name.text,'email':email.text,'password':password.text,'phone':phone.text,'rg':rg.text,'cep':cep.text,'cpf':cpf.text,'address':street.text,'house_number':number.text,'city':city.text,'district':neighborhood.text,'state':uf.text};
        }
        print(formData);

        var response = await postFormData(route, formData,'');
        if (response['status'] == 200 || response['status'] == 201) { // acabou de criar a conta
          Map<String,String> data = {'email': email.text,'password': password.text};
          var loginResponse = await post('login',data);
          if (loginResponse['status'] == 200 || loginResponse['status'] == 201) {
            myGlobalController.userInfo = loginResponse['body']['user'];
            myGlobalController.token = loginResponse['body']['token'];
            myGlobalController.userFavorites.value = [];
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', loginResponse['body']['token']);
            await prefs.setString('user', jsonEncode(loginResponse['body']['user']));
            await prefs.setString('favorites', jsonEncode([]));


            Get.back(); // Fecha o loading

            if(whoAreYouController.selectedUserType == 'Proprietário'){
              Get.offAllNamed('/home');
            }else{
              Get.toNamed('/complete_sign_up');
            }
            
          } else {
            Get.back(); // Fecha o loading
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('E-mail ou senha incorreta'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
          }
        } else {
          Get.back(); // Fecha o loading
          print(response['body']);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' ${response['message'].toString()}'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
        }
      } on Exception catch (e) {
        Get.back(); // Fecha o loading
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocorreu um erro inesperado'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Insira todos os campos obrigatórios'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
    }
  }



}



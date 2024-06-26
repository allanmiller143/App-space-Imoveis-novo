

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
import 'package:space_imoveis/services/Complete_cep.dart';
import 'package:space_imoveis/services/api.dart';

class EditProfileDataPageController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    myGlobalController = Get.find();
  }

  init() async {
    myGlobalController = Get.find();
    if(myGlobalController.userInfo['type'] == 'realstate'){
      name.text = myGlobalController.userInfo['company_name'];
    }else{
      name.text = myGlobalController.userInfo['name'];
    }

    if(myGlobalController.userInfo['type'] == 'client'){
      email.text = myGlobalController.userInfo['email'];
      phone.text = myGlobalController.userInfo['phone'] ?? '';      

    }else{
      email.text = myGlobalController.userInfo['email'];
      phone.text = myGlobalController.userInfo['phone'] ?? '';
      if(myGlobalController.userInfo['type'] == 'realstate'){
        cnpj.text = myGlobalController.userInfo['cnpj'];
        creci.text = myGlobalController.userInfo['creci'];
        socialOne.text = myGlobalController.userInfo['social_one'] ?? '';
        socialTwo.text = myGlobalController.userInfo['social_two'] ?? '';
      }else if(myGlobalController.userInfo['type'] == 'realtor'){
        cpf.text = myGlobalController.userInfo['cpf'];
        rg.text = myGlobalController.userInfo['rg'];
        creci.text = myGlobalController.userInfo['creci'];
        socialOne.text = myGlobalController.userInfo['social_one'] ?? '';
        socialTwo.text = myGlobalController.userInfo['social_two'] ?? '';
      }else if(myGlobalController.userInfo['type'] == 'owner'){
        cpf.text = myGlobalController.userInfo['cpf'];
        rg.text = myGlobalController.userInfo['rg'];
      }
      cep.text = myGlobalController.userInfo['cep'];
      street.text = myGlobalController.userInfo['address'];
      number.text = myGlobalController.userInfo['house_number'];  
      city.text = myGlobalController.userInfo['city'];
      uf.text = myGlobalController.userInfo['state'];
      neighborhood.text = myGlobalController.userInfo['district'];      
    }


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
      ExpansionTile(
        initiallyExpanded: true,
        title: Text('Informações pessoais'),
        subtitle: Text('Clique para editar informações pessoais do perfil',style: TextStyle(color: const Color.fromARGB(255, 87, 87, 87),fontSize: 12,fontWeight: FontWeight.w300),),
        childrenPadding: EdgeInsets.all(0),
        tilePadding: EdgeInsets.all(0),
        shape: Border.fromBorderSide(BorderSide.none),
        children: <Widget>[
          const SizedBox(height: 8),          
          myGlobalController.userInfo['type'] != 'realstate' ? MySimpleTextFormField(controller: name, hint: 'Nome Completo',):MySimpleTextFormField(controller: name, hint: 'Razão social'),
          const SizedBox(height: 12),
          MySimpleTextFormField(controller: email, hint: 'E-mail',enable: false,),
          const SizedBox(height: 12),
          MySimpleTextFormField(controller: phone, hint: 'Telefone'),
          const SizedBox(height: 12),
          myGlobalController.userInfo['type'] != 'realstate' ? 
          Row(
            children: [
              Expanded(child: MySimpleTextFormField(controller: cpf, hint: 'CPF',enable: false),),
              const SizedBox(width: 10,),
              SizedBox(
                width: 140,
                child: MySimpleTextFormField(controller: rg, hint: 'RG',enable: false),  
              ),
            ],
          ):
          MySimpleTextFormField(controller: cnpj, hint: 'CNPJ',enable: false),
          myGlobalController.userInfo['type'] != 'owner'?  Column(
            children: [
              const SizedBox(height: 12),
              MySimpleTextFormField(controller: creci, hint: 'CRECI ex: CRECI-UF 00000',enable: false),
              const SizedBox(height: 12),
            ],
          ) : const SizedBox(height: 12),
        ],
      ),
      ExpansionTile(
        title: Text('Endereço'),
        subtitle: Text('Clique para editar informações referentes ao endereço',style: TextStyle(color: const Color.fromARGB(255, 87, 87, 87),fontSize: 12,fontWeight: FontWeight.w300),),
        childrenPadding: EdgeInsets.all(0),
        tilePadding: EdgeInsets.all(0),
        shape: Border.fromBorderSide(BorderSide.none),
        children: <Widget>[
          const SizedBox(height: 15),          
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
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: Obx(()=> MySimpleTextFormField(controller: street, hint: 'Rua',enable: activateStreet.value)),),
              const SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: MySimpleTextFormField(controller: number, hint: 'N°'),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [ 
              Expanded(
                child: 
                 MySimpleTextFormField(controller: city, hint: 'Cidade',enable: false,),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                width: 80,
                child:  MySimpleTextFormField(controller: uf, hint: 'UF',enable:false),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Obx(()=> MySimpleTextFormField(controller: neighborhood, hint: 'Bairro', enable: activateNeighborhood.value)),
                        

        ],
      ),              
      ExpansionTile(
        title: Text('Redes sociais'),
        subtitle: Text('Clique para editar suas redes sociais',style: TextStyle(color: const Color.fromARGB(255, 87, 87, 87),fontSize: 12,fontWeight: FontWeight.w300),),
        childrenPadding: EdgeInsets.all(0),
        tilePadding: EdgeInsets.all(0),
        shape: Border.fromBorderSide(BorderSide.none),
        children: <Widget>[
          Column(
            children: [
              const SizedBox(height: 8),

              MandatoryOptional(text: 'Redes sociais', subtext: 'Opcional'),
              const SizedBox(height: 4),
              MySimpleTextFormField(controller: socialOne, hint: 'Instagram'),
              const SizedBox(height: 8),          
              MySimpleTextFormField(controller: socialTwo, hint: 'Facebook'),
            ],
          )
        ],
      ),   

    
    ];
  }

   List<Widget> gerarTextFieldsClient() {
    return [
      ExpansionTile(
        title: Text('Informações pessoais'),
        subtitle: Text('Clique para editar informações pessoais do perfil',style: TextStyle(color: const Color.fromARGB(255, 87, 87, 87),fontSize: 12),),
        childrenPadding: EdgeInsets.all(0),
        tilePadding: EdgeInsets.all(0),
        shape: Border.fromBorderSide(BorderSide.none),
        children: <Widget>[
          const SizedBox(height: 8),          
          MyTextFormField(controller: name, hint: 'Nome',icon: const  Icon(Icons.person),),
          const SizedBox(height: 12),
          MyTextFormField(controller: email, hint: 'E-mail',enable: false,icon: const Icon(Icons.email)),
          const SizedBox(height: 12),
          MyTextFormField(controller: phone, hint: 'Telefone',icon: const  Icon(Icons.phone)),
        ],
      ),
    ];
  }

  updateProfileData(BuildContext context) async {
    var fields = [];
    var route = '';    
    if(myGlobalController.userInfo['type'] == 'realstate'){
      fields = [
        name.text,email.text,phone.text,cnpj.text,creci.text,cep.text,street.text,city.text,number.text,uf.text,neighborhood.text,
      ];
      route = 'realstate/${myGlobalController.userInfo['email']}';
    }else if(myGlobalController.userInfo['type'] == 'realtor'){
      fields = [
        name.text,email.text,rg.text,cpf.text,phone.text,creci.text,cep.text,street.text,city.text,number.text,uf.text,neighborhood.text,password.text,
      ];
      route = 'realtors/${myGlobalController.userInfo['email']}';
    }else if(myGlobalController.userInfo['type'] == 'owner'){
      fields = [name.text,email.text,phone.text,cpf.text,rg.text,cep.text,street.text,city.text,number.text,uf.text,neighborhood.text,];
      route = 'owners/${myGlobalController.userInfo['email']}';
    }else{
      fields = [name.text,email.text,];
      route = 'clients/${myGlobalController.userInfo['email']}';
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
        if(myGlobalController.userInfo['type'] == 'realstate'){
          formData = {'company_name':name.text,'email':email.text,'phone':phone.text,'creci':creci.text,'cep':cep.text,'cnpj':cnpj.text,'address':street.text,'house_number':number.text,'city':city.text,'district':neighborhood.text,'state':uf.text,'socialOne':socialOne.text,'socialTwo':socialTwo.text}; 
        }else if(myGlobalController.userInfo['type'] == 'realtor'){
          formData = {'name':name.text,'email':email.text,'phone':phone.text,'creci':creci.text,'cep':cep.text,'rg':rg.text,'cpf':cpf.text,'address':street.text,'house_number':number.text,'city':city.text,'district':neighborhood.text,'state':uf.text,'socialOne':socialOne.text,'socialTwo':socialTwo.text};
        }else if(myGlobalController.userInfo['type'] == 'owner'){
          formData = {'name':name.text,'email':email.text,'phone':phone.text,'rg':rg.text,'cep':cep.text,'cpf':cpf.text,'address':street.text,'house_number':number.text,'city':city.text,'district':neighborhood.text,'state':uf.text};
        }else{
          formData = {'name':name.text,'email':email.text,'type' :'client'};
        }
        var response = await putFormDataA(route, formData, myGlobalController.token);
        if (response['status'] == 200 || response['status'] == 201) { 
          var userData = await get(route);
          if (userData['status'] == 200 || userData['status'] == 201) {
            myGlobalController.userInfo = userData['data'];
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('user', jsonEncode(userData['data']));
            print('deu bom');
            Get.back();
          } else {
            Get.back();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocorreu um erro inesperado 1'),backgroundColor: Color.fromARGB(155, 250, 0, 0),));
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



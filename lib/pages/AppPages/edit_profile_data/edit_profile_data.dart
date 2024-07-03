// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/componentes/register_components/signUp_photo.dart';
import 'package:space_imoveis/pages/AppPages/edit_profile_data/editPhoto.dart';
import 'package:space_imoveis/pages/AppPages/edit_profile_data/edit_profile_data_controller.dart';

class EditProfileDataPage extends StatelessWidget {
  EditProfileDataPage({Key? key}) : super(key: key);
  var controller = Get.put(EditProfileDataPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<EditProfileDataPageController>(
        init: EditProfileDataPageController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
              appBar: AppBar(
              backgroundColor: controller.myGlobalController.color,
              elevation: 0,  
              title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                  ),
                ),
                Text(
                  'Meu Perfil',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.info,
                            size: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                  ),
                ),
              ],
            ),
            ),
            body: FutureBuilder(
              future: controller.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: controller.myGlobalController.userInfo['type'] != 'client' ? controller.gerarTextFields() : controller.gerarTextFieldsClient(),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ExpansionTile(
                                    title: Text('Foto de perfil'),
                                    subtitle: Text('Insira/altere sua foto',style: TextStyle(color: const Color.fromARGB(255, 87, 87, 87),fontSize: 12,fontWeight: FontWeight.w300),),
                                    childrenPadding: EdgeInsets.all(0),
                                    tilePadding: EdgeInsets.all(0),
                                    shape: Border.fromBorderSide(BorderSide.none),
                                    children: <Widget>[
                                      EditPhoto(
                                        onPressed: (){controller.showBottomSheet(context);},
                                        image: controller.imageFile,
                                        imageUrl: controller.myGlobalController.userInfo['profile'] != null && controller.myGlobalController.userInfo['profile']['url'] != '' ? controller.myGlobalController.userInfo['profile']['url'] : null,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  MyButtom(
                                    onPressed: () {
                                      controller.updateProfileData(context);
                                    },
                                    label: 'Atualizar',
                                    buttomColor: controller.myGlobalController.color,
                                  ),
                                ],
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/DashBoardComponents/Myproperties/edit.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/componentes/inser_property_components/horizontal_stepper.dart';
import 'package:space_imoveis/componentes/inser_property_components/imageSelect.dart';
import 'package:space_imoveis/componentes/inser_property_components/step_one.dart';
import 'package:space_imoveis/componentes/inser_property_components/step_three.dart';
import 'package:space_imoveis/componentes/inser_property_components/step_two.dart';
import 'package:space_imoveis/pages/DashBoardPages/EditPropertyPage/EditPropertyPageController.dart';

// ignore: must_be_immutable
class EditProperty extends StatelessWidget {
  EditProperty({Key? key}) : super(key: key);
  var controller = Get.put(EditPropertyController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<EditPropertyController>(
        init: EditPropertyController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            extendBody: true,
            extendBodyBehindAppBar: false,
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
                  'Edite seu Imóvel',
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
                      child: 
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              MultiEditImagePicker(),
                              StepOne(withButton: false, controller : controller),
                              StepTwo(withButton: false , controller : controller),
                              MyButtom(onPressed: (){
                                controller.updateProperty(context);
                              }, label: 'Alterar')
  
                              ],
                            ),
                          ),
                    
                    );
                  } else {
                    return Center(child: const Text('Ocorreu um erro inesperado'));
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/ConversationController.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final ConversationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (controller.imageFiles.isEmpty) {
                  return Center(child: Text('No images selected'));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: controller.imageFiles.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Image.file(
                          File(controller.imageFiles[index].path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () => controller.removeImage(index),
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: Get.width * 0.3,
                child: MyButtom(
                  label: 'Cancelar',
                  onPressed: () => Navigator.pop(context),
                  buttomColor: Colors.grey,
                ),
              ),
              SizedBox(
                width: Get.width * 0.3,
                child: MyButtom(
                  onPressed: (){
                    Navigator.pop(context);
                    controller.sendImg();
                  },
                  label: "Enviar",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

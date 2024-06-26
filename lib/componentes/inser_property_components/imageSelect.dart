import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/componentes/inser_property_components/mandatory.dart';

class ImagePickerController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var imageFiles = <XFile>[].obs;
  var coverImageIndex = (-1).obs;

  Future<void> pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    
    if (selectedImages != null && selectedImages.isNotEmpty) {
      imageFiles.addAll(selectedImages);
      if (coverImageIndex.value == -1 && imageFiles.isNotEmpty) {
        coverImageIndex.value = 0; // Set the first image as cover by default
      }
    }
  }

  void removeImage(int index) {
    imageFiles.removeAt(index);
    if (index == coverImageIndex.value) {
      coverImageIndex.value = imageFiles.isNotEmpty ? 0 : -1;
    } else if (index < coverImageIndex.value) {
      coverImageIndex.value--;
    }
  }

  void setCoverImage(int index) {
    coverImageIndex.value = index;
  }
}

class MultiImagePicker extends StatelessWidget {
  final ImagePickerController controller = Get.put(ImagePickerController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (controller.coverImageIndex.value != -1 && controller.imageFiles.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MandatoryOptional(text: 'imagem de capa', subtext: 'Obrigatório',subtext2: 'Esta é imagem que aparecerá no card do seu imóvel',),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(controller.imageFiles[controller.coverImageIndex.value].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          }),
          SizedBox(height: 5),
          Obx(()=> controller.coverImageIndex.value != -1 && controller.imageFiles.isNotEmpty?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MandatoryOptional(text: 'Outras imagens', subtext: 'Obrigatório',subtext2: 'As imagens que aparecerão no seu anúncio.\nInsira pelo menos 5 imagens',),
                SizedBox(height: 3),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white
                  ),
                  child: Obx(
                    () => GridView.builder(
                      controller: scrollController,
                      physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                      shrinkWrap: true, // Allow GridView to shrink and expand
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: controller.imageFiles.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(controller.imageFiles[index].path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  controller.removeImage(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(149, 154, 154, 154),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.close,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    size: 8,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  controller.setCoverImage(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 240, 146, 5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Obx(()=>
                                    Icon(
                                      controller.coverImageIndex.value == index
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
            : Container(),
          ),
          SizedBox(height: 8),
          MyButtom(
            onPressed: () => controller.pickImages(),
            label: 'Adicionar imagens',
          ),
        ],
      ),
    );
  }
}
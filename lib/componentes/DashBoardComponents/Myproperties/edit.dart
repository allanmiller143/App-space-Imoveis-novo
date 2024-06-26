import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/componentes/inser_property_components/mandatory.dart';

class ImageEditPickerController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  RxList<String> imageUrls = <String>[].obs;
  var newImageFiles = <XFile>[].obs; // Lista de novas imagens adicionadas
  var coverImageIndex = (-1).obs;

  Future<void> pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      newImageFiles.addAll(selectedImages);
      if (coverImageIndex.value == -1 && (imageUrls.isNotEmpty || newImageFiles.isNotEmpty)) {
        coverImageIndex.value = 0; // Set the first image as cover by default
      }
    }
  }

  void removeImage(int index) {
    if (index < imageUrls.length) {
      imageUrls.removeAt(index);
    } else {
      int newImageIndex = index - imageUrls.length;
      newImageFiles.removeAt(newImageIndex);
    }
    if (index == coverImageIndex.value) {
      coverImageIndex.value = (imageUrls.isNotEmpty || newImageFiles.isNotEmpty) ? 0 : -1;
    } else if (index < coverImageIndex.value) {
      coverImageIndex.value--;
    }
  }

  void setCoverImage(int index) {
    coverImageIndex.value = index;
  }
}

class MultiEditImagePicker extends StatelessWidget {
  final ImageEditPickerController controller = Get.put(ImageEditPickerController());
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
            if (controller.coverImageIndex.value != -1 && (controller.imageUrls.isNotEmpty || controller.newImageFiles.isNotEmpty)) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MandatoryOptional(text: 'Imagem de capa', subtext: 'Obrigatório', subtext2: 'Esta é a imagem que aparecerá no card do seu imóvel',),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: controller.coverImageIndex.value < controller.imageUrls.length
                          ? Image.network(
                              controller.imageUrls[controller.coverImageIndex.value],
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(controller.newImageFiles[controller.coverImageIndex.value - controller.imageUrls.length].path),
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
          Obx(() => (controller.imageUrls.isNotEmpty || controller.newImageFiles.isNotEmpty)
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MandatoryOptional(text: 'Outras imagens', subtext: 'Obrigatório', subtext2: 'As imagens que aparecerão no seu anúncio.\nInsira pelo menos 5 imagens',),
                SizedBox(height: 3),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Obx(() => GridView.builder(
                    controller: scrollController,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: controller.imageUrls.length + controller.newImageFiles.length,
                    itemBuilder: (context, index) {
                      bool isUrl = index < controller.imageUrls.length;
                      return Stack(
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: isUrl
                                ? Image.network(
                                    controller.imageUrls[index],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                : Image.file(
                                    File(controller.newImageFiles[index - controller.imageUrls.length].path),
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
                                child: Obx(() => Icon(
                                  controller.coverImageIndex.value == index
                                    ? Icons.star
                                    : Icons.star_border,
                                  color: Colors.white,
                                  size: 16,
                                )),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )),
                ),
              ],
            )
            : Container()
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

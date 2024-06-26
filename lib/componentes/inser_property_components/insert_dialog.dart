import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:space_imoveis/componentes/global_components/load_widget.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/componentes/inser_property_components/imageSelect.dart';
import 'package:space_imoveis/pages/AppPages/insert_property/insert_property_controller.dart';
import 'package:space_imoveis/services/api.dart';

class InsertDialog extends StatelessWidget {
  final RxBool publicarAnuncio = true.obs;
  final RxBool anuncioPublicado = false.obs;
  var controller;
  InsertDialog({Key? key, required this.controller}) : super(key: key);

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop(); // Fecha o diálogo
    Get.back(); // Volta para a tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          if (anuncioPublicado.value) {
            closeDialog(context);
          }
          return true;
        },
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                  child: Text(
                    anuncioPublicado.value ? 'Anúncio Publicado' : 'O que deseja fazer?',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (anuncioPublicado.value) {
                    closeDialog(context);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          titlePadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          contentPadding: EdgeInsets.all(6),
          content: Container(
            child: anuncioPublicado.value
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      Text(
                        'Seu imóvel será analisado pela nossa equipe e se tudo estiver de acordo será publicado.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Icon(Icons.check_circle, color: Colors.green, size: 30),
                      
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Checkbox(
                              visualDensity: VisualDensity(horizontal: -4.0, vertical: 0),
                              activeColor: Color(Colors.green.value),
                              value: publicarAnuncio.value,
                              onChanged: (value) {
                                publicarAnuncio.value = value!;
                              },
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Publicar Anúncio nos populares'),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  'Selecione esta opção para publicar o anúncio nos anúncios mais populares da rede.',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 10),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              activeColor: Color(Colors.green.value),
                              visualDensity: VisualDensity(horizontal: -4.0, vertical: 0),
                              value: !publicarAnuncio.value,
                              onChanged: (value) {
                                publicarAnuncio.value = !value!;
                              },
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cadastrar anúncio'),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  'Selecione esta opção para cadastrar o anúncio, mas sem publicá-lo.',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 10),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
          ),
          actions: anuncioPublicado.value
              ? [
                  TextButton(
                    onPressed: () {
                      closeDialog(context);
                    },
                    child: const Text('Fechar', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  ),
                ]
              : [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o diálogo
                    },
                    child: const Text('Voltar', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  ),
                  TextButton(
                    onPressed: () async {
                      var formJson = {
                        'announcementType': controller.advertsType,
                        'propertyType': controller.announceType,
                        'address': controller.street.text,
                        'city': controller.city.text,
                        'district': controller.neighborwood.text,
                        'state': controller.state.text,
                        'cep': controller.cep.text,
                        'size': controller.size.text,
                        'description': controller.description.text,
                        'contact': controller.myGlobalController.userInfo['phone'],
                        'sellerEmail': controller.myGlobalController.userInfo['email'],
                        'sellerType': controller.myGlobalController.userInfo['type'],
                        'aditionalFees': controller.otherPrices.text,
                        'isHighlighted': false,
                        'isPublished': publicarAnuncio.value,
                        'negotiable': false,
                      };
                      if (controller.announceType == 'Apartamento') {
                        formJson.addAll(
                          {'rooms': controller.floors,}
                        );
                      }

                      if (controller.finance == 'Sim') {
                        formJson.addAll({'financiable': true});
                      } else {
                        formJson.addAll({'financiable': false});
                      }

                      if (controller.advertsType == 'Aluguel') {
                        formJson.addAll(
                          {'rentPrice': controller.rentPrice.text}
                        );
                      } else if (controller.advertsType == 'Venda') {
                        formJson.addAll(
                          {'sellPrice': controller.sellPrice.text}
                        );
                      } else {
                        formJson.addAll(
                          {'rentPrice': controller.rentPrice.text, 'sellPrice': controller.sellPrice.text}
                        );
                      }
                      if (controller.announceType != 'Terreno') {
                        for (var option in controller.options) {
                          formJson[option['dbValue'] as String] = option['checked'];
                        }

                        formJson.addAll(
                          {'bathrooms': controller.bathrooms, 'bedrooms': controller.bedrooms, 'parkingSpaces': controller.parkingSpaces, 'suites': controller.suits, 'houseNumber': controller.houseNumber.text}
                        );
                      }

                      if (controller.furnished == 'Mobiliado') {
                        formJson.addAll({'furnished': 'furnished'});
                      } else if (controller.furnished == 'Semi mobiliado') {
                        formJson.addAll({'furnished': 'semi-furnished'});
                      } else {
                        formJson.addAll({'furnished': 'not-furnished'});
                      }

                      formJson.forEach((key, value) {
                        print("$key: $value");
                      });

                      ImagePickerController ipc = Get.find();
                      if (ipc.imageFiles.length < 5) {
                        mySnackBar('Selecione pelo menos 5 imagens', false);
                      } else if (controller.advertsType == 'Ambas' && (controller.rentPrice.text.isEmpty || controller.sellPrice.text.isEmpty)) {
                        mySnackBar('Insira o valor de aluguel e de venda', false);
                      } else {
                        showLoad(context);
                        try {
                          // Remove the cover image from the list and create a new list without it
                          List<XFile> newImageFiles = List.from(ipc.imageFiles);
                          newImageFiles.removeAt(ipc.coverImageIndex.value);

                          // Get the cover image
                          XFile coverImage = ipc.imageFiles[ipc.coverImageIndex.value];

                          // Ensure all Rx variables are converted to their actual values
                          Map<String, dynamic> nonReactiveFormJson = {};
                          formJson.forEach((key, value) {
                            nonReactiveFormJson[key] = value is Rx ? value.value : value;
                          });

                          var response = await postFormDataWithFiles(
                            'properties',
                            nonReactiveFormJson,
                            newImageFiles,
                            coverImage,
                            controller.myGlobalController.token,
                          );

                          if (response['status'] == 200 || response['status'] == 201) {
                            Navigator.of(context).pop();
                            anuncioPublicado.value = true;
                          } else {
                            Navigator.of(context).pop();
                            mySnackBar('Erro ao cadastrar anúncio', false);
                          }
                        } catch (e) {
                          Navigator.of(context).pop();
                          print(e);
                        }
                      }
                    },
                    child: const Text(
                      'Continuar',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ],
        ),
      );
    });
  }
}

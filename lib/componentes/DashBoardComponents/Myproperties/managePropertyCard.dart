import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:space_imoveis/componentes/DashBoardComponents/Myproperties/analysisDialog.dart';
import 'package:space_imoveis/componentes/global_components/Dialogs/AlertDialog/alert_dialog.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/DashBoardPages/MyPropertiesPage/MyPropertiesPageController.dart';

class ManagePropertyCardController extends GetxController {
  var isExpanded = false.obs;
  RxString x = ''.obs;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }

  String formatNumber(dynamic number) {
    if (number == null) return 'N/A';
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(number);
  } 
}

// Defina a classe do cartão da propriedade
class ManagePropertyCard extends StatelessWidget {
  var property;

  ManagePropertyCard({
    required this.property,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Cada card terá seu próprio controlador
    final ManagePropertyCardController controller = Get.put(ManagePropertyCardController(), tag: property['id']);
    MyPropertiesPageController mppc = Get.find();
    MyGlobalController myGlobalController = Get.find();
    controller.x.value =  (property['is_highlighted'] == false && property['is_published'] == false) ?
                                    'Arquivado':
                                    (property['is_highlighted'] == true) ?
                                    'Destaques' : 'Populares';

  void handleButtonPress(label) async {
    String result = await mppc.handleArchive(context, property, label);

    if(label == 'Arquivado' && result == 'Arquivado'){
      print('tentativa de arquivar');
      property['is_highlighted'] = false;
      property['is_published'] =  false;
    }else if(label == 'Destaques' && result == 'Destaques'){
      print('tentativa de destaque');
      property['is_highlighted'] = true;
      property['is_published'] =  true; 
    }else if(label == 'Populares' && result == 'Populares'){
      print('tentativa de popular');
      property['is_highlighted'] = false;
      property['is_published'] =  true;
    }
    controller.x.value = result;

  }
    return GestureDetector(
      onTap: controller.toggleExpand,

      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.fromLTRB(0,0,0,5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: const Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 221, 221, 221).withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children:[ 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: 50,
                            height: 50,
                            child: property['pictures']  != null && property['pictures'].length > 0
                              ? Image.network(
                                  property['pictures'][0]['url'],
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/imgs/corretor.jpg',
                                  fit: BoxFit.cover,
                              ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${property['property_type']} - ${property['announcement_type']}" ,
                                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12,fontWeight: FontWeight.w400)),
                              Text(
                                  '${property['address']}-${property['house_number']}, ${property['city']} - ${property['state']}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 9,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300
                                  ),
                                  maxLines: 2,
                                )
                            ],
                          ),
                        ), 
                        SizedBox(width: 10), 
                        Container(
                            height: 45,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(()=>
                                    Text(
                                      controller.x.value,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400
                                      )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                        showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DashBoardWaitingAvaliationProperties(
                                            open: true,
                                              handleClose: () {
                                                Navigator.of(context).pop();
                                              },
                                              property: property,
                                              func: () {
                                                // Some function to be executed
                                              },
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(5, 4, 5, 4), 
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 146, 146, 146).withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0, 1), // changes position of shadow
                                          ),
                                        ]
                                      ),
                                      child: Text(
                                        (property['verified'] == 'pending') ?'Em análise':
                                        (property['verified'] == 'verified') ?
                                        'Aprovado' : 'Rejeitado',
                                        style: TextStyle(
                                          color: (property['verified'] == 'pending') ? Color.fromARGB(194, 0, 0, 0):
                                        (property['verified'] == 'verified') ?
                                        Color.fromARGB(194, 14, 133, 20): Color.fromARGB(194, 127, 9, 9),
                                          fontSize: 8,
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                      ],
                    ),
                  ),
                  Obx(() => AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.isExpanded.value) ...[
                          // Adicione as informações estáticas aqui antes de expandir
                          SizedBox(height: 10),
                          Text('Outros detalhes da propriedade', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                          Text(property['description'], style: TextStyle(fontSize: 9)),
                          Text(property['sell_price'] != null ? 'Preço de venda R\$ ${controller.formatNumber(property['sell_price'])}' : '', style: TextStyle(fontSize: 9)),
                          Text(property['rent_price'] != null ? 'Preço de Aluguel R\$ ${controller.formatNumber(property['rent_price'])}/mês' : '', style: TextStyle(fontSize: 9)),
                          property['property_type'] == 'Terreno' ? SizedBox() :
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.bed_outlined, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                                  SizedBox(width: 2),
                                  Text(
                                    property['bedrooms'].toString(),
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(width: 5),
                              Row(
                                children: [
                                  Icon(Icons.shower_outlined, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                                  SizedBox(width: 2),
                                  Text(
                                    property['bathrooms'].toString(),
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(width: 5),
                              Row(
                                children: [
                                  Icon(Icons.garage_outlined, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                                  SizedBox(width: 2),
                                  Text(
                                    property['parking_spaces'].toString(),
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 0.3,
                            color: Color.fromARGB(255, 65, 106, 110),
                          ),

                          
                          Obx(()=>(controller.x.value == 'Arquivado' ||  (property['is_highlighted'] == false && property['is_published'] == false) )?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tb('Inserir nos destaques', () {
                                  handleButtonPress('Destaques');
                                }),
                                tb('Inserir nos populares', () {
                                  handleButtonPress('Populares');
                                }),
                              ],
                            )
                          :property['is_highlighted'] == true ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tb('Arquivar', () {
                                  handleButtonPress('Arquivar');
                                }),
                                tb('Inserir nos populares', () {
                                  handleButtonPress('Populares');
                                }),
                              ],
                            ):
                          
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tb('Arquivar', () {
                                  handleButtonPress( 'Arquivar');
                                }),
                                tb('Inserir nos destaques', () {
                                  handleButtonPress('Destaques' );
                                }),
                              ],
                            )
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tb('Apagar Imóvel', () {
                                if(property['shared'] && property['seller']['email'] == myGlobalController.userInfo['email']){
                                  mySnackBar('Apenas o dono original do imóvel pode Removê-lo ',false);
                                }else{
                                    showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return MyAlertDialog(
                                        title: 'Tem certeza que deseja excluir esse imóvel?',
                                        subtitle: 'Ao excluir, todos os dados referentes a esse imóvel serão excluídos.\n\nTem certeza de que deseja continuar?',
                                        onSend: () {
                                          mppc.deleteProperty(context, property);},
                                      );
                                    },
                                  );        
                                }
                              }, color: const Color.fromARGB(255, 127, 9, 9),),
                              tb('Editar imóvel', () {
                                Get.offNamed('edit_property', arguments: [property]);
                              }),
                            
                            ],
                          )
                        ],
                      ],
                    ),
                  )),
                ],
              ),

              Container(
                height: 53,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Icon(Icons.arrow_drop_down, size: 15, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
                
            ]
          ),
        
      ),
    );
  }
}

Widget tb(String title,VoidCallback onTap, {Color color = const  Color.fromARGB(255, 65, 106, 110),}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 10
        ),
      ),
    ),
  );
}
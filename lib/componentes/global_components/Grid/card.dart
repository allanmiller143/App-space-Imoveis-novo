
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/AppPages/property_detail_page/property_detail_page_controller.dart';
import 'package:space_imoveis/services/api.dart';
import 'package:intl/intl.dart';

class PropertyCard2 extends StatelessWidget {
  final property;
  MyGlobalController  myGlobalController = Get.find();
  PropertyCard2({required this.property, Key? key}) : super(key: key);
 
  toggleFavorite() async {
    MyGlobalController myGlobalController = Get.find();
    try {
      var favoriteData = {
        'propertyId': property['id'], 
        'email': myGlobalController.userInfo['email'] 
      };
      var response = await post('favorites', favoriteData, token: myGlobalController.token);
      if (response['status'] == 200 || response['status'] == 201) {
        myGlobalController.userFavorites.add(property['id']);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userFavorites', jsonEncode(myGlobalController.userFavorites)); 
      } else {
        mySnackBar(response['message'], true);
      }
    } catch (e) {
      mySnackBar('Ocorreu um erro: ${e.toString()}', true);
    }
  }

  togleUnfavorite() async{
    MyGlobalController myGlobalController = Get.find();
    try{
      var response = await delete('favorites/${myGlobalController.userInfo['email']}/${property['id']}', myGlobalController.token);
      if(response['status'] == 200 || response['status'] == 204){
        myGlobalController.userFavorites.remove(property['id']);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userFavorites', jsonEncode(myGlobalController.userFavorites)); 
 
      }else{
        mySnackBar(response['message'], true);
      } 
    }catch(e){
      mySnackBar(e.toString(), false);
    }
  }

  String formatNumber(dynamic number) {
    if (number == null) return 'N/A'; // Verifica se o número é nulo
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(number);
  }  
 
  @override
  Widget build(BuildContext context) {
        return GestureDetector(
          onTap: () {
            if(Get.isRegistered<PropertyDetailController>()){
               Get.delete<PropertyDetailController>();
            }          
            Get.toNamed('/property_detail/${property['id']}');
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(2, 5, 2, 7),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 209, 209, 209).withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children:[ 
                      Container(
                        width: double.infinity,
                        height:98,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                          child: Image.network(
                            property['pictures'][0]['url'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Obx(() => myGlobalController.userFavorites.contains(property['id'])
                            ? IconButton(
                                onPressed: () {
                                  togleUnfavorite();
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: Color.fromARGB(255, 245, 4, 4),
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  toggleFavorite();
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              )
                            ),
                      )
                    ]
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4,5,4,0),
                    child: Text(
                      '${property['address']}, ${property['city']}-${property['state']}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      property['description'],
                      style: TextStyle(fontSize: 10,wordSpacing: 0.2),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  property['property_type'] == 'Terreno' ? SizedBox() :
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical:3),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bed_outlined, size: 14, color: const Color.fromARGB(255, 0, 0, 0)),
                            SizedBox(width: 2),
                            Text(
                              property['bedrooms'].toString(),
                              style: TextStyle(fontSize: 8),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: [
                            Icon(Icons.shower_outlined, size: 14, color: const Color.fromARGB(255, 0, 0, 0)),
                            SizedBox(width: 2),
                            Text(
                              property['bathrooms'].toString(),
                              style: TextStyle(fontSize: 8),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: [
                            Icon(Icons.garage_outlined, size: 14, color: const Color.fromARGB(255, 0, 0, 0)),
                            SizedBox(width: 2),
                            Text(
                              property['parking_spaces'].toString(),
                              style: TextStyle(fontSize: 8),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            property['sell_price'] == null ? SizedBox() :
                            Text(
                              'Aluguel: R\$ ${formatNumber(property['sell_price'])}/mês',
                              style: TextStyle(fontSize: 8),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis, 
                            ),
                            property['sell_price'] == null ? SizedBox() : SizedBox(width: 5),
                            property['rent_price'] == null ? SizedBox() :
                            Text(
                              'Venda: R\$ ${formatNumber(property['rent_price'])}/mês',
                              style: TextStyle(fontSize: 8),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis, 
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 169, 169, 169),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${formatNumber(property['size'])}m²',
                            style: TextStyle(fontSize: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4,5,4,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 14,
                              backgroundImage: property['seller']['profile'] != null &&
                                      property['seller']['profile']['url'] != ''
                                  ? NetworkImage(
                                      property['seller']['profile']['url'],
                                    ) as ImageProvider<Object>
                                  : AssetImage(
                                      'assets/imgs/logo.png',
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${property['seller']['name']}',
                              style: TextStyle(fontSize: 8),
                            ),
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
  }
}
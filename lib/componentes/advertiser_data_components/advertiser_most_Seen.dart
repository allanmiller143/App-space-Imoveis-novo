import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:space_imoveis/pages/AppPages/advertiser_data/advertiser_data_page_controller.dart';
import 'package:space_imoveis/pages/AppPages/property_detail_page/property_detail_page_controller.dart';
import 'package:space_imoveis/services/api.dart';

class MostSeenController extends GetxController {
  var isLoading = true.obs;
  var properties = [].obs;
  late AdvertiserDataController controller;

  @override
  void onInit() {
    super.onInit();
    controller = Get.find();
    fetchProperties();
  }

  void fetchProperties() async {
    isLoading.value = true;
    try {
      var response = await get('properties/most-seen/${controller.advertiser['email']}');
      if (response['status'] == 200 || response['status'] == 201) {
        properties.value = response['data'];
        print(properties[0]['pictures'][0]['url']);
      } else {
        print('API call failed');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

class AdvertiserMostSeen extends StatelessWidget {
  var advertiserData;
  AdvertiserMostSeen({
    super.key,
    required this.advertiserData,
  });
  final MostSeenController controller = Get.put(MostSeenController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Mais vistos',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
            ),
          ),
          SizedBox(height: 3),
          Obx(() => controller.isLoading.value ?
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              dragStartBehavior: DragStartBehavior.start,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(6, (index) {
                  return Shimmer.fromColors(
                    baseColor: Color.fromARGB(255, 223, 223, 223),
                    highlightColor: Color.fromARGB(255, 192, 192, 192),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0,0,3,0),
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ),
            )
            :
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              dragStartBehavior: DragStartBehavior.start,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(controller.properties.length, (index) {
                  return GestureDetector(
                    onTap: () { 

                      if(Get.isRegistered<PropertyDetailController>()){
                        Get.delete<PropertyDetailController>();
                      }
                      
                      Get.toNamed('/property_detail/${controller.properties[index]['id']}');
                      },
                    child: Container(
                      width: 55,
                      height: 55,
                      margin: EdgeInsets.fromLTRB(0,0,5,0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.grey[300],
                        image: controller.properties[index]['pictures'].isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(controller.properties[index]['pictures'][0]['url']),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

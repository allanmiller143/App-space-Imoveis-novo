import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/rating.dart';
import 'package:space_imoveis/pages/AppPages/advertiser_data/advertiser_data_page_controller.dart';

class RealStateCard extends StatelessWidget {
  final Map<String, dynamic> data;

  RealStateCard({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    double avgRate = double.tryParse(data['avgRate']) ?? 0.0;

    return GestureDetector(
      onTap: (){
        if(Get.isRegistered<AdvertiserDataController>()){
          Get.delete<AdvertiserDataController>();
        }          
        Get.toNamed('/advertiser_data/${data['email']}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Container(
                width: double.infinity,
                height: 120,
                child: data['profile'] != null && data['profile']['url'] != ''
                    ? Image.network(
                        data['profile']['url'],
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/imgs/corretor.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['company_name'],
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    data['bio'] ?? 'Sem biografia',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[700],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nota:',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      Rating(
                        rating: avgRate.isNaN ? 0.0 : avgRate * 2,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

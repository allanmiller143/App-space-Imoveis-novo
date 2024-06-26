

import 'package:flutter/material.dart';
import 'package:flutter_rating_null_safe/flutter_rating_null_safe.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/Comments/CommentsController.dart';
            
class Rating extends StatelessWidget {

  double rating = 0;
  final double size;
  final bool write;


  Rating({
    super.key,
    required this.rating,
    this.size = 20,
    this.write = false,

  });

  @override
  Widget build(BuildContext context) {
    RxDouble rate = rating.obs;

    return Obx(()=>
      FlutterRating(
            rating: rate.value,
            starCount: 5,
            borderColor: Colors.grey,
            color: Colors.amber,
            allowHalfRating: true,
            size: size,
            mainAxisAlignment: MainAxisAlignment.start,
            onRatingChanged: (r) {
              if(write){
                CommentsController cc = Get.find();
                rate.value = r; 
                cc.newRate = r;
              }
            },
        ),
    );
  }
}

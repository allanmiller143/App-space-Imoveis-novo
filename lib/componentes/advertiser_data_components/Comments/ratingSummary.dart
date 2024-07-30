import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/Comments/Comment.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/Comments/CommentsController.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/Comments/InsertComment.dart';
import 'package:space_imoveis/componentes/advertiser_data_components/Comments/LoadingComments.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class RatingSummaryWidget extends StatelessWidget {
  String email;
  var advertiserData;
  RatingSummaryWidget({
    Key? key,
    required this.email,
    required this.advertiserData,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommentsController cc = Get.put(CommentsController(email));
    MyGlobalController mgc = Get.find();
    double avgRate = double.tryParse(advertiserData['avgRate']) ?? 0.0;

    return Obx(() => cc.loading.value
        ? Center(child: CircularProgressIndicator())
        : Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: const Color.fromARGB(255, 255, 255, 255),
              // boxShadow: [
              //   BoxShadow(
              //     color: const Color.fromARGB(255, 221, 221, 221).withOpacity(0.5),
              //     spreadRadius: 1,
              //     blurRadius: 2,
              //     offset: Offset(0, 1), // changes position of shadow
              //   ),
              // ],
            ),
            child: Column(
              children: [
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Avaliações',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                RatingSummary(
                  label: 'Avaliações',
                  labelStyle: TextStyle(fontWeight: FontWeight.w200),
                  averageStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  counter: avgRate.isNaN ? 1 : cc.totalComments.value,
                  average:  avgRate.isNaN ? 0.0 : avgRate * 2,
                  counterFiveStars: 5,
                  counterFourStars: 4,
                  counterThreeStars: 2,
                  counterTwoStars: 1,
                  counterOneStars: 1,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Dê uma avaliação ao anunciante',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InsertComment(),
                ),

                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Todos os comentários',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Obx(()=>
                  cc.loadingcomments.value ? 
                  Column(
                    children: [
                      LoadingComment(), LoadingComment(), LoadingComment(), LoadingComment(), LoadingComment(),
                    ],
                  ) :
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: cc.commets.map((commentData) {
                        return Column(
                          children: [
                            Comment(commnentData: commentData),
                            SizedBox(height: 8),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: NumberPaginator(
                    initialPage: cc.totalComments.value == 0 ? 0 : cc.currentPage.value,
                    numberPages: cc.totalComments.value == 0 ? 1 : ((cc.totalComments.value / 6).ceil()),
                    onPageChange: (int index) {
                      cc.currentPage.value = index;
                      cc.getCommnets(false);
                    },
                    showNextButton: true,
                    showPrevButton: true,
                    config: NumberPaginatorUIConfig(
                      buttonSelectedBackgroundColor: mgc.color,
                      buttonUnselectedForegroundColor: const Color.fromARGB(255, 0, 0, 0),
                      buttonUnselectedBackgroundColor: Colors.white,
                      buttonSelectedForegroundColor: Colors.white,
                      buttonPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      buttonShape: CircleBorder(),
                      height: 35,
                      buttonTextStyle: TextStyle(fontSize: 10),
                    ),
                  ),
                ),

              ],
            ),
          ));
  }
}

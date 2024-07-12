import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/AppPages/home/home_controller.dart';
import 'package:space_imoveis/pages/AppPages/property_detail_page/property_detail_page_controller.dart';

class PropertyDetailImgCarrossel extends StatefulWidget {
  final property;
  final MyGlobalController globalController;
  PropertyDetailImgCarrossel({required this.property, required this.globalController, Key? key}) : super(key: key);
  String formatNumber(dynamic number) {
    if (number == null) return 'N/A'; // Verifica se o número é nulo
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(number);
  }


  @override
  _PropertyDetailImgCarrosselState createState() => _PropertyDetailImgCarrosselState();
}



class _PropertyDetailImgCarrosselState extends State<PropertyDetailImgCarrossel> {
  int activeIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.property['pictures'].length,
          itemBuilder: (context, index, realIdx) {
            var property = widget.property['pictures'][index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        property['url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(125, 136, 136, 136),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 18,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () {
                                  if(Get.isRegistered<HomeController>()){
                                      print('entrei aqui');
                                      Get.back();
                                  }else{
                                    print('Entrei no else');
                                    Get.offAllNamed('/home');
                                  }          
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      right: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(125, 136, 136, 136),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.share,
                                  size: 18,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () {
                                  PropertyDetailController pdc = Get.find();
                                  pdc.sharePropertyLink(context);

                                },
                              ),
                            ),
                          ),
                        ),
                      ),              
                    ), 
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height:45,
                            padding: const EdgeInsets.fromLTRB(16,5,16,5),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(125, 136, 136, 136),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.property['property']['announcement_type'] == 'Ambas' || widget.property['property']['announcement_type'] == 'Venda')
                                    Column(
                                      children: [
                                        Text(
                                          'Preço',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        ),
                                        Text(
                                          'R\$ ${widget.formatNumber(widget.property['property']['sell_price'])}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (widget.property['property']['announcement_type'] == 'Ambas')
                                    SizedBox(width: 16), // Espaçamento entre os preços de venda e aluguel
                                  if (widget.property['property']['announcement_type'] == 'Ambas' || widget.property['property']['announcement_type'] == 'Aluguel')
                                    Column(
                                      children: [
                                        Text(
                                          'Aluguel',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        ),
                                        Text(
                                          'R\$ ${widget.formatNumber(widget.property['property']['rent_price'])}/mês',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 380,
            enlargeCenterPage: false,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 1500),
            viewportFraction: 1,
            disableCenter: true,
            autoPlayInterval: Duration(seconds: 10),
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 8),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.property['pictures'].length,
        effect: ExpandingDotsEffect(
          dotWidth: 7,
          dotHeight: 7,
          activeDotColor: Color.fromARGB(255, 0, 0, 0),
          dotColor: Colors.grey,
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:space_imoveis/componentes/global_components/rating.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertiserInfoDataController extends GetxController with GetTickerProviderStateMixin {
  var isExpanded = false.obs;
  var buttonText = 'Veja Mais'.obs;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
    buttonText.value = isExpanded.value ? 'Veja Menos' : 'Veja Mais';
  }

  String formatNumber(dynamic number) {
    if (number == null) return 'N/A';
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(number);
  } 

void abrirInstagram() async {
    var messengerUrl = 'https://instagram.com/ianoliveira.dev';
    if (await canLaunchUrl(Uri.parse(messengerUrl))) {
      await launchUrl(Uri.parse(messengerUrl));
    } else {
      throw 'Could not launch $messengerUrl';
    }
  }

  void shareProperty(String url) async {
    if(await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),);
    }else{
      print('deu ruim vei ');
    }
  }

  
}

class AdvertiserInfoData extends StatelessWidget {
  var advertiserData;
  final AdvertiserInfoDataController controller = Get.put(AdvertiserInfoDataController());

  AdvertiserInfoData({
    super.key,
    required this.advertiserData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          print(advertiserData);
        },
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 60,
                        height: 60,
                        child: advertiserData['profile'] != null && advertiserData['profile']['url'] != ''
                            ? Image.network(
                                advertiserData['profile']['url'],
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/imgs/corretor.jpg',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2,0,0,0),
                            child: Text(
                              advertiserData['type'] == 'realstate'? advertiserData['conpany_name'] : advertiserData['name'],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                              ),
                            ),
                          ),
                          Rating(rating: double.parse(advertiserData['avgRate']) * 2),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Informações',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                ),
              ),
              SizedBox(height: 5),
              IconTextButton(icon: FaIcon(FontAwesomeIcons.whatsapp, size: 10, color: Color.fromARGB(255, 0, 0, 0)), text: 'Entrar em contato com o anunciante', url: 'https://wa.me/55${advertiserData['phone'].replaceAll(' ', '').replaceAll('-', '').replaceAll('(', '').replaceAll(')', '').replaceAll('(', '')}', ),
              SizedBox(height: 5),  
              IconTextButton(icon: FaIcon(FontAwesomeIcons.heart,size: 10,color: Color.fromARGB(255, 0, 0, 0),),text: '0 Curtidas', url: 'https://wa.me/5581996171889', onlyRead: true ),
              SizedBox(height: 5), 
              IconTextButton(icon: Icon(Icons.email, size: 10, color: Color.fromARGB(255, 0, 0, 0)),text: 'Enviar um email', url:'mailto:${advertiserData['email']}', ),               
              SizedBox(height: 5),
              Text(
                'Sobre mim',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                ),
              ),
              Obx(() => AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      advertiserData['bio'] ?? 'Nenhuma descrição disponibilizada',
                      maxLines: controller.isExpanded.value ? null : 3,
                      overflow: controller.isExpanded.value ? TextOverflow.visible : TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                      ),
                    ),
                    if (controller.isExpanded.value) ...[
                      SizedBox(height: 8),
                      Text(
                        'Redes Sociais',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                        ),
                      ),
                      SizedBox(height: 5),

                      IconTextButton(
                        icon: FaIcon(FontAwesomeIcons.instagram,size: 10,color: Color.fromARGB(255, 0, 0, 0),),
                        text: 'Instagram',
                        url: advertiserData['social_one'] ?? 'https://www.instagram.com/',
                      ),
                      SizedBox(height: 5),
                      IconTextButton(
                        icon: FaIcon(FontAwesomeIcons.facebook,size: 10,color: Color.fromARGB(255, 0, 0, 0),),
                        text: 'Facebook',
                        url: advertiserData['social_two'] ?? 'https://www.facebook.com/',
                      ),
                    ],
                  ],
                ),
              )),
              Obx(() => GestureDetector(
                onTap: controller.toggleExpand,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          controller.buttonText.value,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, size: 20, color: Color.fromARGB(255, 0, 0, 0)),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}


class IconTextButton extends StatelessWidget {
  final Widget icon; // Changed to Widget to accept both Icon and FaIcon
  final String text;
  final String url;
  final bool onlyRead;
  IconTextButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.url,
    this.onlyRead = false,
  }) : super(key: key);


  void openLink(String url) async {
    if(await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),);
    }else{
      print('deu ruim vei ');
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onlyRead) {
          return;
        }
        openLink(url);
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 4, 5, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(120)),
              color: Color.fromARGB(67, 95, 95, 95),
            ),
            child: icon, // Use the provided icon directly
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 54, 54, 54),
              fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
            ),
          ),
        ],
      ),
    );
  }
}





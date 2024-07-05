import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class MandatoryOptional extends StatelessWidget {
  final String text;final String subtext; final String subtext2;
  MandatoryOptional({
    Key? key,
    required this.text,
    required this.subtext,
    this.subtext2 = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  MyGlobalController controller = Get.find();
  return Padding(
    padding: const EdgeInsets.fromLTRB(0,0,0,8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                    color: controller.color
                  ),
              ),
              Text(
                subtext,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                  color: subtext == 'Obrigatório'? controller.color3:Color.fromARGB(255, 6, 126, 74)

                ),
              ),
            ],
          ),
          subtext2 == '' ? SizedBox() :
          Text(
            subtext2,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w300,
              fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
              color: controller.color3
            ),
          ),
        ],
      ),
    );
  }
}

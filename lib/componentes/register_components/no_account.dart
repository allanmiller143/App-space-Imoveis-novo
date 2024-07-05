import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class NoAccount extends StatelessWidget {
  
  final Color? textColor; // Cor opcional
    const NoAccount(
      {
        super.key,
        this.textColor,
      }
    );
  @override
  Widget build(BuildContext context) {
    MyGlobalController mgc = Get.find();
    return RichText(
      text: TextSpan(
        text: 'Ainda não possui conta? ',
        style:const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87
        ),
        children: [
          TextSpan(
            text: 'Clique aqui',
            style: TextStyle(
              color: textColor ?? mgc.color3,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
              recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed('/who_are_you_page');
              },
          ),
        ],
      ),
    );
    
  }
}

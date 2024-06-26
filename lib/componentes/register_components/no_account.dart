import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

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
    return Center(
      child: RichText(
        text: TextSpan(
          text: 'Ainda não possui conta? ',
          style:const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          children: [
            TextSpan(
              text: 'Clique aqui',
              style: TextStyle(
                color: textColor ?? const  Color.fromARGB(0, 6, 67, 86),
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
      ),
    );
  }
}

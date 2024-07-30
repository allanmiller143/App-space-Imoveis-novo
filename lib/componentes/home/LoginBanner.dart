import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class SignUpBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyGlobalController mgc = Get.find();
    return GestureDetector(
      onTap: () {
       
        Get.toNamed('/login');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: [mgc.color, mgc.color.withOpacity(0.9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ainda não possui conta?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Clique aqui e cadastre-se!",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_drop_down_rounded, color: Colors.white, size: 30),
          ],
        ),
      ),
    );
  }
}

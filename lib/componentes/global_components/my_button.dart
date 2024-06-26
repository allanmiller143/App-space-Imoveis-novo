import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class MyButtom extends StatelessWidget {

  
  final VoidCallback onPressed;
  final String label;
  final Color? buttomColor; // Cor opcional
  final Color? textColor; // Cor opcional
  final double? width;

  const MyButtom(
    {
      super.key,
      required this.onPressed,
      required this.label,
      this.buttomColor, // Cor opcional
      this.textColor,
      this.width,
    }
  );

  @override
  Widget build(BuildContext context) {
    MyGlobalController controller = Get.find();
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
          backgroundColor: buttomColor ?? controller.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor ?? const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class AlertDialogHeader extends StatelessWidget {
  final String title;
  final VoidCallback? close;
  const AlertDialogHeader({
    super.key,
    required this.title,  
    required this.close,
  
  });

  @override
  Widget build(BuildContext context) {
    MyGlobalController mgc = Get.find();
    return  AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 11, color: Colors.white),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: close,
          color: Colors.white,
          iconSize: 15,
        ),
      ],
      backgroundColor: mgc.color,
    );
  }
}
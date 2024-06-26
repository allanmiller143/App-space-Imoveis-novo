import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class CardInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final IconData icon;

  const CardInfo({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyGlobalController mgc = Get.find();
    return Container(
      decoration: BoxDecoration(
        color: mgc.color2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
          leading: Icon(icon, color: mgc.color),
          title: Text(title , style: TextStyle(color: mgc.color,fontSize: 14, fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle, style: TextStyle(color: mgc.color,fontSize: 12, fontWeight: FontWeight.w300)),
          trailing: Text(value, style: TextStyle(color: mgc.color,fontSize: 12, fontWeight: FontWeight.bold)),
        ),
    );
  
  }
}
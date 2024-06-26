import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/manageFilters.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';




class CustomDrawer extends StatelessWidget {
  MyGlobalController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      color: controller.color,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
              AllFilter()

          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class CustomRadioChoice extends StatelessWidget {
  final Map<String, String> choices;
  final ValueChanged<String> onChange;
  final RxString item;



  CustomRadioChoice({
    required this.choices,
    required this.onChange,
    required this.item
  });

  @override
  Widget build(BuildContext context) {

    MyGlobalController myGlobalController = Get.put(MyGlobalController());

    return Obx(() {
      return Row(
        children: choices.keys.map((key) {
          bool isSelected = item.value == key;
          return GestureDetector(
            onTap: () {
              item.value = key;
              onChange(key);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0,0,4,0),
              padding: const EdgeInsets.fromLTRB(8,2,8,2),
              decoration: BoxDecoration(
                color: isSelected ? Color.fromARGB(255, 12, 74, 105) : Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                choices[key]!,
                style: TextStyle(
                  color:  isSelected ? Colors.white : myGlobalController.color,
                  fontSize: 11.0,
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}



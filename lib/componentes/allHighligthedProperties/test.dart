import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class CustomRadioChoice extends StatelessWidget {
  final Map<String, String> choices;
  final ValueChanged<String> onChange;

  CustomRadioChoice({
    required this.choices,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RadioChoiceController());
    MyGlobalController myGlobalController = Get.put(MyGlobalController());

    return Obx(() {
      return Row(
        children: choices.keys.map((key) {
          bool isSelected = controller.state.value == key;
          return GestureDetector(
            onTap: () {
              controller.state.value = key;
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

class RadioChoiceController extends GetxController {
  var state = ''.obs;

}

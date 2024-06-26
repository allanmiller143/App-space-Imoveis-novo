import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageTextField extends StatelessWidget {
  final String label;
  final RxString controller;
  final double width;

  ManageTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.width = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        Container(
          width: width,
          height:35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color.fromARGB(47, 0, 0, 0), width: 0.3),
          ),
          child: TextField(
            controller: TextEditingController(text: controller.value),
            onChanged: (value) => controller.value = value,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255),
              constraints: BoxConstraints(maxHeight: 40),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(69, 0, 0, 0), width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(87, 245, 245, 245), width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              isDense: true, // Ensures the input field height is smaller
            ),
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }
}

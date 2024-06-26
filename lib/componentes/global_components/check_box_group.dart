// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckBoxGroup extends StatelessWidget {
  RxList<Map<String, Object>> options;
  final ScrollController scrollController = ScrollController();

  CheckBoxGroup({required this.options}) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: GridView.builder(
            controller: scrollController,
            physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
            shrinkWrap: true, // Allow GridView to shrink and expand
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4,
            ),
            itemCount: options.length,
            itemBuilder: (context, index) {
              return Obx(()=>
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.all(0),
                  checkColor: Color.fromARGB(255, 255, 255, 255),
                  activeColor: Color.fromARGB(255, 57, 112, 15),
                  visualDensity: VisualDensity(horizontal:  -4.0, vertical: 0),
                  title:Text(options[index]['value'] as String, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                  side: BorderSide(
                    color: Colors.black
                  ),
                  value: options[index]['checked'] as bool,
                  onChanged: (bool? value) {
                    options[index]['checked'] = value! as bool;
                    options.refresh();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


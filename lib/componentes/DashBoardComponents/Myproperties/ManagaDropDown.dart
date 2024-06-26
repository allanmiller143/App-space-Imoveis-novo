import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageDropDown extends StatelessWidget {
  List<String> itens = [];
  String label;
  RxString controller;
  double width;
  ManageDropDown({super.key, required this.label, required this.controller, required this.itens,this .width = 100});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4,0,0,0),
          child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 255, 255, 255)),),
        ),
        Container(
          width: width,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color.fromARGB(47, 0, 0, 0), width: 0.3),
          ),
          child: DropdownSearch<String>(
            items: itens,
            selectedItem: controller.value,
            dropdownBuilder: (context, selectedItem) {
              return Text(
                selectedItem ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              );
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
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
                contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                isDense: true, // Ensures the input field height is smaller
              ),
        
            ),
            popupProps: PopupProps.menu(
              
              showSearchBox: false,
              itemBuilder: (context, item, isSelected) {
                return Container(
                  height: 35,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
              constraints: BoxConstraints(maxHeight: 200),
              menuProps: MenuProps(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              controller.value = value ?? '';
            },
          ),
        ),
      ],
    );
  }
}
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final RxString controller;
  final String labelText;

  const CustomDropdownButton({super.key, required this.items, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: items,
      selectedItem: controller.value,
      dropdownBuilder: (context, selectedItem) {
        selectedItem ??= '';
        return Text(
          selectedItem,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        );
      },
      
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          focusColor: const Color.fromARGB(0, 0, 0, 0),
          filled: true,
          fillColor: Color.fromARGB(12, 0, 0, 0),
          constraints: BoxConstraints(maxHeight: 40),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(0, 0, 0, 0),width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(87, 245, 245, 245),width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
          ),
          floatingLabelStyle: TextStyle(
            color: Color.fromARGB(255, 57, 57, 57),
            fontSize: 12,
            fontWeight: FontWeight.w500
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: false,
        itemBuilder: (context, item, isSelected) {
          return Container(
            height: 35, // Altura de cada item
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              item, // Use the item here instead of controller.value
              style: const TextStyle(
                fontSize: 12, // Tamanho da fonte dos itens
                color: Color.fromARGB(255, 0, 0, 0), // Cor dos itens
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
        constraints: BoxConstraints(maxHeight: 150), // Altura máxima da caixinha
        menuProps: MenuProps(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        controller.value = value ?? ''; // Update the controller value on change
      },
    );
  }
}

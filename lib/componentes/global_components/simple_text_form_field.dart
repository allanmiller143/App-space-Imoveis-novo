import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MySimpleTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool enable;
  final Function(String)? onChange;
  final bool formatText;

  const MySimpleTextFormField({
    Key? key,
    required this.hint,
    required this.controller,
    this.enable = true,
    this.onChange,
    this.formatText = false,
  }) : super(key: key);

  String _formatNumber(String value) {
    if (value.isEmpty) return value;
    final formatter = NumberFormat('#,##0', 'pt_BR');
    final parsedValue = int.tryParse(value.replaceAll('.', ''));
    return parsedValue != null ? formatter.format(parsedValue) : value;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value);
        }
        if (formatText) {
          final formattedValue = _formatNumber(value);
          controller.value = TextEditingValue(
            text: formattedValue,
            selection: TextSelection.collapsed(offset: formattedValue.length),
          );
        }
      },
      controller: controller,
      enabled: enable,
      style: TextStyle(
        color: enable
            ? const Color.fromARGB(255, 0, 0, 0)
            : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
        fontSize: 12,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        constraints: const BoxConstraints(
          maxHeight: 40,
        ),
        fillColor: const Color.fromARGB(255, 243, 243, 243),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(0, 0, 0, 0),
            width: 0.2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(0, 0, 0, 0),
            width: 0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(250, 0, 0, 0),
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(0, 0, 0, 0).withOpacity(0.2),
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        labelText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintStyle: TextStyle(
          color: enable
              ? const Color.fromARGB(255, 0, 0, 0)
              : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          color: enable
              ? const Color.fromARGB(255, 0, 0, 0)
              : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }
}

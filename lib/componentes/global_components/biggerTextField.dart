import 'package:flutter/material.dart';

class MyBiggerTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool enable;
  final Function(String)? onChange;

  const MyBiggerTextFormField({
    Key? key,
    required this.hint,
    required this.controller,
    this.enable = true,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value);
        }
      },
      controller: controller,
      enabled: enable,
      expands: true,
      maxLines: null,
      style: TextStyle(
        color: enable
            ? const Color.fromARGB(255, 0, 0, 0)
            : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
        fontSize: 12,
      ),
      textAlignVertical: TextAlignVertical.top, // Alinha o texto ao topo
      decoration: InputDecoration(
        constraints: const BoxConstraints(
          maxHeight: 200,
          minHeight: 40,
        ),
        fillColor: const Color.fromARGB(255, 243, 243, 243), // Define o fundo branco
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8), // Ajusta o preenchimento para alinhar o texto ao topo
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(0, 0, 0, 0),
            width: 0.2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(0, 0, 0, 0),
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(0, 0, 0, 0),
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(0, 0, 0, 0).withOpacity(0.2),
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        labelText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true, // Alinha o label com o hint
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

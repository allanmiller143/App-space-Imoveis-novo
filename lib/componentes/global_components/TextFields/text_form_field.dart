import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Icon? icon;
  final Color? color; // Cor opcional
  final bool obscureText; // obscureText opcional
  final bool enable;
  final Function(String)? onChange;

  const MyTextFormField({
    Key? key,
    required this.hint,
    required this.controller,
    this.icon,
    this.color, // Cor opcional
    this.obscureText = false, // Valor padrão para obscureText
    this.enable = true,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxBool showPassword = false.obs; // Usando RxBool do GetX

    return GetBuilder<MyTextFormFieldController>(
      init: MyTextFormFieldController(), // Inicializa o controlador
      builder: (myController) => Column(
        children: [
          TextFormField(
              onChanged: onChange,
              controller: controller,
              enabled: enable,
              obscureText: showPassword.value ? false : obscureText,
              style: TextStyle(
                color: enable 
                  ? (color ?? const Color.fromARGB(255, 0, 0, 0)) 
                  : (color?.withOpacity(0.5) ?? const Color.fromARGB(255, 100, 100, 100)), // Cor ajustada para desativado
                fontSize: 12,
              ), // Cor padrão se color for nulo
              cursorColor: Color.fromARGB(255, 9, 47, 70),
              textAlignVertical: TextAlignVertical.center, // Centraliza o texto verticalmente
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8), // Ajusta o padding para centralizar o texto
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                labelText: hint, // Usa o hint como label
                
                floatingLabelBehavior: FloatingLabelBehavior.auto, // Faz a label flutuar
                hintStyle: TextStyle(
                  color: enable 
                    ? (color ?? const Color.fromARGB(255, 9, 47, 70)) 
                    : (color?.withOpacity(0.2) ?? const Color.fromARGB(255, 200, 200, 200)), // Cor ajustada para desativado
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: icon,
                prefixIconColor: enable 
                  ? (color ?? const Color.fromARGB(255, 9, 47, 70) ) 
                  : (color?.withOpacity(0.1) ?? const Color.fromARGB(255, 183, 183, 183)), // Cor ajustada para desativado
                suffixIcon: obscureText
                    ? IconButton(
                        onPressed: () {
                          showPassword.toggle(); // Alternar o valor de showPassword
                          myController.updateState(); // Atualizar o estado do widget
                        },
                        icon: Icon(
                          showPassword.value ? Icons.visibility : Icons.visibility_off,
                          color: enable 
                            ? (color ?? const Color.fromARGB(255, 9, 47, 70)) 
                            : (color?.withOpacity(0.5) ?? const Color.fromARGB(255, 100, 100, 100)), // Cor ajustada para desativado
                        ),
                      )
                    : null,
                suffixIconColor: Colors.white,
                labelStyle: TextStyle(
                  color: enable 
                    ? (color ?? const Color.fromARGB(255, 9, 47, 70)) 
                    : (color?.withOpacity(0.2) ?? const Color.fromARGB(255, 200, 200, 200)), // Cor ajustada para desativado
                  fontWeight: FontWeight.w400,
                  fontSize: 13, // Tamanho da fonte da label quando flutuando
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: enable 
                      ? (color ?? const Color.fromARGB(255, 9, 47, 70))
                      : (color?.withOpacity(0.5) ?? const Color.fromARGB(255, 100, 100, 100)), // Cor ajustada para desativado
                  ),
                )
              ),
            ),
          
        ],
      ),
    );
  }
}

class MyTextFormFieldController extends GetxController {
  void updateState() {
    update(); // Notifica os observadores sobre a atualização do estado
  }
}

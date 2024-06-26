import 'package:flutter/material.dart';


Future<void> showLoad(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false, // Impede o fechamento ao tocar fora do diálogo
    builder: (context) {
      return Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(13, 17, 97, 225)
          ),
        )
      );
    },
  );
}
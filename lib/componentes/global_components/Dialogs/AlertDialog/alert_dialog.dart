import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/Dialogs/AlertDialog/alert_header.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onSend;

  const MyAlertDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyGlobalController mgc = Get.find();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AlertDialogHeader(
            title: title,
            close: () {
              Navigator.of(context).pop();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                ),
                child: const Text('Cancelar', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              ),
              GestureDetector(
                onTap: () {
                  onSend();
                },  
                child: Container(
                  padding: EdgeInsets.fromLTRB(8,2,8,2),
                  decoration: BoxDecoration(
                    color: mgc.color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text('Continuar', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 12)),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}

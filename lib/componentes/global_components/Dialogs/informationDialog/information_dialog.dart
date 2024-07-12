import 'package:flutter/material.dart';
import 'package:space_imoveis/componentes/global_components/Dialogs/AlertDialog/alert_header.dart';

class MyInformationDialog extends StatelessWidget {
  final String title;
  final String subtitle;

  const MyInformationDialog({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(15.0),
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
          
        ],
      ),
    );
  }
}

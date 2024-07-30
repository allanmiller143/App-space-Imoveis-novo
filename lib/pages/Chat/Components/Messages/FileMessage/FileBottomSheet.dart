import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/my_button.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/ConversationController.dart';

class FilePreviewBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConversationController controller = Get.find();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controller.selectedFiles.isNotEmpty)
            Text('Arquivo: ${controller.selectedFiles[0].name}'),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: Get.width * 0.3,
                child: MyButtom(
                  onPressed: () {
                    controller.selectedFiles.clear();
                    Get.back(); // Fechar o BottomSheet
                  },
                  label: 'Cancelar',
                ),
              ),
              SizedBox(
                width: Get.width * 0.3,
                child: MyButtom(
                  onPressed: () {
                    // Implementar a lógica de envio do arquivo aqui
                    Get.back(); // Fechar o BottomSheet
                    controller.sendFile();
                  },
                  label: 'Enviar',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

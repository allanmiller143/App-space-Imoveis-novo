import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';

class ImagePreviewDialog extends StatelessWidget {
  final String imgUrl;

  const ImagePreviewDialog({Key? key, required this.imgUrl}) : super(key: key);

  Future<void> downloadImage(BuildContext context) async {
    // Solicitar permissões
    if (await _requestPermission()) {
      try {
        // Baixar a imagem
        var response = await Dio().get(
          imgUrl,
          options: Options(responseType: ResponseType.bytes),
        );
        // Salvar a imagem na galeria
        Navigator.of(context).pop();
        final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
        
        // Mostrar SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Imagem salva na galeria!'),
            duration: Duration(seconds: 2),
          ),
        );
        print("Imagem salva na galeria: $result");
      } catch (e) {
        print(e);
      }
    } else {
      print("Permissão negada");
    }
  }

  Future<bool> _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      child: Stack(
        children: [
          Image.network(
            imgUrl,
            fit: BoxFit.cover,
            width: screenWidth * 0.8,
            height: screenHeight * 0.5,
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Text('Erro ao carregar imagem'));
            },
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.download, color: Colors.white),
              onPressed: () {
                downloadImage(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

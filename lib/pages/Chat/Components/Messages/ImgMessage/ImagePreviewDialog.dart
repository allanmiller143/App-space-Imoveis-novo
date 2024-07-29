import 'package:flutter/material.dart';

class ImagePreviewDialog extends StatelessWidget {
  final String imgUrl;

  const ImagePreviewDialog({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidht = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      child: Stack(
        children: [
          Image.network(
            imgUrl,
            fit: BoxFit.cover,
            width: screenWidht *0.8,
            height: screenHeight *0.5,
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Text('Erro ao carregar imagem'));
            },
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

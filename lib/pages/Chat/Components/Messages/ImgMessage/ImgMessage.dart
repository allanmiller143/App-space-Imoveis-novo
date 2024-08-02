import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/ImgMessage/ImagePreviewDialog.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;

  Avatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.transparent, // Fundo transparente
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        radius: 16,
      ),
    );
  }
}

class ChatImgMessageReceiverWidget extends StatelessWidget {
  final String message;
  final String horaMinuto;
  final String imgUrl;
  final String url;

  const ChatImgMessageReceiverWidget({
    Key? key,
    required this.message,
    required this.horaMinuto,
    required this.url,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: Colors.transparent, // Fundo transparente
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Avatar(
              imageUrl: url,
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ImagePreviewDialog(imgUrl: imgUrl),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 15),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5), // Cor de fundo cinza para o container da imagem
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        imgUrl,
                        width: 150,
                        height: 160,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text('Erro ao carregar imagem'));
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 8,
                  child: Text(
                    horaMinuto,
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatImgMessageSenderWidget extends StatelessWidget {
  final String message;
  final String url;
  final String imgUrl;
  final String horaMinuto;

  const ChatImgMessageSenderWidget({
    Key? key,
    required this.message,
    required this.horaMinuto,
    required this.url,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 3),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 184, 25, 25), // Fundo transparente
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ImagePreviewDialog(imgUrl: imgUrl),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 15),
                        decoration: BoxDecoration(
                          color: Color(0xfff5f5f5), // Cor de fundo cinza para o container da imagem
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: 
                          imgUrl == "" ? Container(
                            width: 150,
                            height: 160,
                            color: Colors.grey[300],
                            child: Center(child: CircularProgressIndicator(
                              color: Colors.grey[600],
                            )),
                          ) :
                          Image.network(
                            imgUrl,
                            width: 150,
                            height: 160,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Text('Erro ao carregar imagem'));
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 8,
                      child: Text(
                        horaMinuto,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5),
              Container(
                child: Avatar(
                  imageUrl: url,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

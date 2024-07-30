import 'package:flutter/material.dart';

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

class ChatMessageReceiverWidget extends StatelessWidget {
  final String message;
  final String horaMinuto;
  final String url;

  const ChatMessageReceiverWidget({
    Key? key,
    required this.message,
    required this.horaMinuto,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double messageWidth = screenWidth * 0.6; // 70% da largura da tela

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Avatar(
              imageUrl: url,
            ),
          ),
          SizedBox(
            width: messageWidth, // Define a largura do container da mensagem
            child: Container(
              padding: const EdgeInsets.fromLTRB(8,4,8,4),
              decoration: BoxDecoration(
                color: Color(0xfff5f5f5), // Cor de fundo cinza para o container da mensagem
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        horaMinuto,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessageSenderWidget extends StatelessWidget {
  final String message;
  final String url;
  final String horaMinuto;

  const ChatMessageSenderWidget({
    Key? key,
    required this.message,
    required this.horaMinuto,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double messageWidth = screenWidth * 0.6; // 70% da largura da tela

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: messageWidth,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8,4,8,4),
        
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f5), // Cor de fundo cinza para o container da mensagem
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyle(fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            horaMinuto,
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
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

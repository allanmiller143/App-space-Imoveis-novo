import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;

  Avatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
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

  const ChatMessageReceiverWidget({Key? key, required this.message, required this.horaMinuto, required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Container(
        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
        padding: const EdgeInsets.fromLTRB(8,8,8,4),
        alignment: Alignment.bottomLeft,
        decoration: const BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Avatar(
              imageUrl: url,
            ),
            SizedBox(width: 5),
            Expanded(
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
                        textAlign: TextAlign.end,
                        horaMinuto,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ChatMessageSenderWidget extends StatelessWidget {
  final String message;
  final String url;
  final String horaMinuto;

  const ChatMessageSenderWidget({Key? key, required this.message, required this.horaMinuto, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Stack(
          children:[ 
            Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 3),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.bottomLeft,
            decoration: const BoxDecoration(
              color: Color(0xfff0f8ff),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: 
                      Text(
                        message,
                        style: const TextStyle(),
                        textAlign: TextAlign.start,
                      ),
                ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                  child: Avatar(
                    imageUrl: url,
                  ),
                ),
                
              ],
            ),
          ),
          Positioned(
            bottom: 4,
            right: 8,
            child: Text(
              horaMinuto,
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ]
      ),
    );
  }
}

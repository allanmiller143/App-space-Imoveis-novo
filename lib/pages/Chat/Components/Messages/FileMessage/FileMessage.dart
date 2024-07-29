import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir links e fazer download

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

class ChatFileMessageReceiverWidget extends StatelessWidget {
  final String horaMinuto;
  final String fileUrl;
  final String url;
  final String fileName;

  const ChatFileMessageReceiverWidget({
    Key? key,
    required this.horaMinuto,
    required this.url,
    required this.fileUrl,
    required this.fileName,
  }) : super(key: key);

  Future<void> _downloadFile() async {
    if (await canLaunch(fileUrl)) {
      await launch(fileUrl);
    } else {
      throw 'Could not launch $fileUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: 
          Container(
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 4),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              color: Colors.transparent, // Fundo transparente
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Avatar(
                    imageUrl: url,
                  ),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                      decoration: BoxDecoration(
                        color: Color(0xfff5f5f5), // Cor de fundo cinza para o container do arquivo
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _downloadFile();
                                },
                                child: Icon(
                                  Icons.download,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  fileName,
                                  style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300),
                                ),
                              ),
                              
                            ],
                          ),
                          Text(
                            horaMinuto,
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                
              ],
            ),
          ), 
    );
  }
}

class ChatFileMessageSenderWidget extends StatelessWidget {
  final String url;
  final String fileUrl;
  final String horaMinuto;
  final String fileName;

  const ChatFileMessageSenderWidget({
    Key? key,
    required this.horaMinuto,
    required this.url,
    required this.fileUrl,
    required this.fileName,
  }) : super(key: key);

  Future<void> _downloadFile() async {
    if (await canLaunch(fileUrl)) {
      await launch(fileUrl);
    } else {
      throw 'Could not launch $fileUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),

            decoration: BoxDecoration(
              color: Colors.transparent, // Fundo transparente
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _downloadFile,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                      decoration: BoxDecoration(
                        color: Color(0xfff5f5f5), // Cor de fundo cinza para o container do arquivo
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _downloadFile();
                                },
                                child: Icon(
                                  Icons.download,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  fileName,
                                  style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            horaMinuto,
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
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
    );
  }
}

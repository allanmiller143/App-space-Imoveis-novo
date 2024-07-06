import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OpenNewChat extends StatelessWidget {
  var  advertiserData;

  OpenNewChat({
    Key? key,
    required this.advertiserData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
        GestureDetector(
          onTap: () async{
            print('email: ${advertiserData['email']}');
            Get.toNamed('/chat_conversation', arguments: [advertiserData]);

          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Icon(Icons.chat),
              ),
              SizedBox(width: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0), // Cor da borda
                      width: 0.5, // Largura da borda
                    ),
                  ),
                ),
                child: Text(
                  'Abrir chat',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                  ),
                ),
              ),
            ],
          ),
        );
     
  }
}

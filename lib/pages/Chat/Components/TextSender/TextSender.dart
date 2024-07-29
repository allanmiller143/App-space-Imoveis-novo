import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/ConversationController.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/ImgMessage/ImageModal.dart';
import 'package:space_imoveis/pages/Chat/Components/TextSender/AudioSender.dart';
import 'package:space_imoveis/pages/Chat/Components/TextSender/SoundPlayer.dart';

class ChatTextSender extends StatelessWidget {
  ChatTextSender({Key? key}) : super(key: key);
  final recorder  = SoundRecorder();


  @override
  Widget build(BuildContext context) {
    ConversationController controller = Get.find();
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              await controller.pickImages();
              if (controller.imageFiles.isNotEmpty) {
                showModalBottomSheet(
                  shape: Border.all(color: Colors.transparent),
                  
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => ImagePickerBottomSheet(),
                );
              }

            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(Icons.camera_alt_sharp,color: Colors.white),
            ),
          ),
          
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.newMessage,
                  cursorColor: controller.myGlobalController.color3,
                  maxLines: 4,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  cursorHeight: 22,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 0, 0, 0),
                        width: 0.5,
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 0, 0, 0),
                        width: 0.5,
                      )
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 0, 0, 0),
                        width: 0.5,
                      )
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 0, 0, 0),
                        width: 0.5,
                      )
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    hintText: 'Escreva uma mensagem',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: controller.myGlobalController.color3,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(0, 228, 6, 6),
                        width: 0,
                      )
                    )
                  ),
                  
                ),
              ),  
            ),
          GestureDetector(
              onTap: () {
                final message = controller.newMessage.text.trim();
                if (message.isNotEmpty) {
                  controller.sendMessage(message);
                  controller.newMessage.clear();
                }
              },
              child: Container(
                width: 22,
                height: 22,
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                decoration: BoxDecoration(
                  color: controller.myGlobalController.color3,
                  borderRadius: BorderRadius.circular(
                    50
                  ),
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 12,
                           
                ),
              ),
            ),
            AudioButton(),
            PlayButton()
        
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/ConversationController.dart';


final pathToReadAudio = 'audio.aac';
class SoundPlayer {
  FlutterSoundPlayer?_audioPlayer;
  RxBool isPlaying = false.obs;
  Future init() async {
    _audioPlayer = FlutterSoundPlayer();

    await _audioPlayer!.openPlayer();
  }

    Future dispose() async {
    _audioPlayer = FlutterSoundPlayer();

    await _audioPlayer!.closePlayer();
  }



  Future _play(VoidCallback whenFinished) async {
    await _audioPlayer!.startPlayer(
      fromURI: pathToReadAudio,
      whenFinished: whenFinished
    );
  }

  Future _stop() async {
    await _audioPlayer!.stopPlayer();
  }

  Future togglePlaying({required VoidCallback whenFinished} ) async {
    if ( _audioPlayer!.isStopped) {
      isPlaying.value = true;
      await _play(whenFinished );
    }else{
      isPlaying.value = false;
      await _stop();
    }
  }

}

Widget PlayButton() {
  ConversationController conversationController = Get.find();

  return GestureDetector(
    onTap: () async {
    
      await conversationController.player.togglePlaying( whenFinished: () {
        conversationController.player.isPlaying.value = false;
      } );
    },
    child: Obx(
      ()=>
      Container(
        margin: EdgeInsets.only(right: 5),
        child: Row(
          children: [
            Text(
              conversationController.player.isPlaying.value ? 'reproduzindo...' : '',
              style: TextStyle(color: conversationController.player.isPlaying.value ? Colors.white : Colors.black),
            ),
            Icon(
              conversationController.player.isPlaying.value ? Icons.pause : Icons.play_arrow,
              color: conversationController.player.isPlaying.value ? const Color.fromARGB(255, 63, 63, 63) : Colors.white,
            ),
            
          ],
        ),
      ),
    ),
  );
}

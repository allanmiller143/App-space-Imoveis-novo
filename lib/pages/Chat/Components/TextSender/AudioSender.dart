import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/ConversationController.dart';
import 'package:permission_handler/permission_handler.dart';

final pathToSaveAudio = 'audio.aac';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool isRecorderInited = false;
  RxBool isRecording = false.obs;

  Future<void> init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('microphone permission not granted');
    }
    await _audioRecorder!.openRecorder();
    isRecorderInited = true;

  }

  void dispose(){
    if (!isRecorderInited) return;

    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    isRecorderInited = false;
  }

  Future<void> _record() async {
    if (!isRecorderInited) return;
    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future<void> _stop() async {
    if (!isRecorderInited) return;
    await _audioRecorder!.stopRecorder(); // Corrigido o método para parar a gravação
  }

  Future<void> toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      isRecording.value = true;
      await _record();
    } else {
      isRecording.value = false;
      await _stop();
    }
  }
}


Widget AudioButton() {
  ConversationController conversationController = Get.find();
  return GestureDetector(
    onTap: () async {
      await conversationController.recorder.toggleRecording();
    },
    child: Obx(
      ()=>
      Container(
        margin: EdgeInsets.only(right: 5),
        child: Row(
          children: [
            Text(
              conversationController.recorder.isRecording.value ? 'Gravando...' : '',
              style: TextStyle(color: conversationController.recorder.isRecording.value ? Colors.white : Colors.black),
            ),
            Icon(
              conversationController.recorder.isRecording.value ? Icons.stop : Icons.mic_none,
              color: conversationController.recorder.isRecording.value ? Colors.red : Colors.white,
            ),
            conversationController.recorder.isRecording.value ?

            Padding(
              padding: const EdgeInsets.fromLTRB(5,0,0,0),
              child: GestureDetector(
                onTap: () async {
                  //await conversationController.sendAudio();
                  await conversationController.recorder.toggleRecording();
                },
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ):SizedBox()
            
          ],
        ),
      ),
    ),
  );
}

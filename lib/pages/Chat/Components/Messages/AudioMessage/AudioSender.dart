import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/pages/Chat/ChatPages/Conversation/ConversationController.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool isRecorderInited = false;
  RxBool isRecording = false.obs;
  Rx<Duration> recordingDuration = Duration.zero.obs;
  Timer? _timer;
  String pathToSaveAudio = '';

  Future<void> init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('microphone permission not granted');
    }
    await _audioRecorder!.openRecorder();
    isRecorderInited = true;

    final directory = await getApplicationDocumentsDirectory();
    pathToSaveAudio = '${directory.path}/audio.aac';
  }

  void dispose() {
    if (!isRecorderInited) return;

    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    isRecorderInited = false;
  }

  Future<void> _record() async {
    if (!isRecorderInited) return;
    recordingDuration.value = Duration.zero; // Reset the duration
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      recordingDuration.value += Duration(seconds: 1);
    });
    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future<void> _stop() async {
    if (!isRecorderInited) return;
    await _audioRecorder!.stopRecorder();
    _timer?.cancel();
    recordingDuration.value = Duration.zero; // Reset the duration
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

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return '$minutes:$seconds';
}

Widget AudioButton() {
  ConversationController conversationController = Get.find();
  return GestureDetector(
    onTap: () async {
      await conversationController.recorder.toggleRecording();
    },
    child: Obx(
      () => Container(
        margin: EdgeInsets.only(right: 5),
        child: Row(
          children: [
            Text(
              conversationController.recorder.isRecording.value
                  ? '${formatDuration(conversationController.recorder.recordingDuration.value)}'
                  : '',
              style: TextStyle(
                color: conversationController.recorder.isRecording.value
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            Icon(
              conversationController.recorder.isRecording.value
                  ? Icons.stop
                  : Icons.mic_none,
              color: conversationController.recorder.isRecording.value
                  ? Colors.red
                  : Colors.white,
            ),
            conversationController.recorder.isRecording.value
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () async {
                        await conversationController.sendAudio();
                        await conversationController.recorder.toggleRecording();
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    ),
  );
}

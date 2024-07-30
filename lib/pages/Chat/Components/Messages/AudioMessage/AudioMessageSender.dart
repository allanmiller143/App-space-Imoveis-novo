import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:space_imoveis/pages/Chat/Components/Messages/TextMessage/Message.dart';

class ChatAudioMessageSenderWidget extends StatefulWidget {
  final String horaMinuto;
  final String audioUrl;
  final String url;

  const ChatAudioMessageSenderWidget({
    Key? key,
    required this.horaMinuto,
    required this.url,
    required this.audioUrl,
  }) : super(key: key);

  @override
  _ChatAudioMessageSenderWidgetState createState() => _ChatAudioMessageSenderWidgetState();
}

class _ChatAudioMessageSenderWidgetState extends State<ChatAudioMessageSenderWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _setAudio();
  }
Future<void> _setAudio() async {
  try {
    if (widget.audioUrl.isNotEmpty) {
      if (_audioPlayer.state != PlayerState.playing) {
        await _audioPlayer.setSource(UrlSource(widget.audioUrl));
      } else {
        print("O áudio está atualmente em reprodução.");
      }
    } else {
      print("URL do áudio está vazio ou nulo.");
    }
  } catch (e) {
    print("Erro ao definir a fonte do áudio: $e");
  }
}

  void _playPauseAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.audioUrl));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _playPauseAudio,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Color.fromARGB(255, 80, 80, 80),
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '${_formatDuration(_position)}',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                              SizedBox(width: 4),
                            ],
                          ),
                          Text(
                            widget.horaMinuto,
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Avatar(
                    imageUrl: widget.url,
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

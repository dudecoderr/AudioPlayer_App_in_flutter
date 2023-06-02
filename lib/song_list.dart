import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
bool isPlaying = false;

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);
  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {


  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.current.listen((playingAudio) {
      setState(() {
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  Color _getButtonColor(int index) {
    if (assetsAudioPlayer.playlist!.audios[index].metas.id ==
        assetsAudioPlayer.current.value!.audio.audio.metas.id) {
      return Colors.black;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: assetsAudioPlayer.playlist!.audios.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    const Divider(
                      color: Color(0xFFd5d4d6),
                      height: 5,
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {
                        assetsAudioPlayer.pause();
                        assetsAudioPlayer.playlistPlayAtIndex(index);
                      },
                      title: Text(assetsAudioPlayer.playlist!.audios[index].metas.title.toString()),
                      trailing: assetsAudioPlayer.playlist!.audios[index].metas.id ==
                          assetsAudioPlayer.current.value!.audio.audio.metas.id ?  Image.asset('assets/icons/music1.png') : null,
                      leading: Container(
                        height: 40,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getButtonColor(index),
                        ),
                        child: PlayerBuilder.realtimePlayingInfos(
                            player: assetsAudioPlayer,
                            builder: (context, play) {
                              return IconButton(
                                icon: (assetsAudioPlayer.playlist!.audios[index].metas.id ==
                                        play.current!.audio.audio.metas.id)
                                    ? Icon(play.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow)
                                    : const Icon(Icons.play_arrow),
                                color: Colors.white,
                                onPressed: () {
                                  assetsAudioPlayer.playOrPause();
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

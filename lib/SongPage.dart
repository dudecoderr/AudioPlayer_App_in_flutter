import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled6/song_list.dart';
import 'card_flip.dart';
import 'list.dart';


class SongPage extends StatefulWidget {
  final String titles;
  final String photo;
  final String desc;
  final String image;
  final String url;
  final Function? function;
  const SongPage({
    Key? key, required this.titles, required this.photo, required this.desc, required this.image, required this.url, this.function
  }) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> with SingleTickerProviderStateMixin {
  final scrollcontroller = ScrollController();
  final SwiperController swiperController = SwiperController();
  late AnimationController animationController;
  bool isLiked = false;
  double screenwidth = 0;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();
    setupPlaylist();
    scrollcontroller.addListener(onScroll);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700)
    );
    animationController.addListener(() {
      setState(() {
      });
    });
  }

  onScroll() {
    if (scrollcontroller.offset < 15) {
      animationController.reverse();
    } else if (scrollcontroller.offset > 15) {
      animationController.forward();
    }
  }

  void setupPlaylist() async {
    await assetsAudioPlayer
        .open(
        Playlist(audios: [
          Audio(widget.url,
              metas: Metas(id: '1', image: MetasImage.asset(widget.image),title: widget.photo,artist: widget.desc,album: widget.titles)),
          Audio('assets/song/Bewafa Tera Muskurana - Jubin Nautiyal 128 Kbps.mp3',
              metas: Metas(id: '2', title: 'Bewafa Tera Muskurana', artist: widget.desc,album: widget.titles)),
          Audio('assets/song/Bheeg Jaunga - Stebin Ben 128 Kbps.mp3',
              metas: Metas(id: '3', title: 'Bheeg Jaunga', artist: widget.desc,album: widget.titles)),
          Audio('assets/song/Dosti - RRR 128 Kbps.mp3',
              metas: Metas(id: '4', title: 'Dosti', artist: widget.desc,album: widget.titles)),
          Audio('assets/song/Khushi Jab Bhi Teri - Jubin Nautiyal 128 Kbps.mp3',
              metas: Metas(id: '5', title: 'Khushi Jab Bhi Teri', artist: widget.desc,album: widget.titles)),
          Audio('assets/song/Mann Bharryaa 2.0 - Shershaah 128 Kbps.mp3',
              metas: Metas(id: '6', title: 'Mann Bharryaa', artist: widget.desc,album: widget.titles)),
          Audio('assets/song/Marjaawaan - Bell Bottom 128 Kbps.mp3',
              metas: Metas(id: '7', title: 'Marjaawaan', artist: widget.desc,album: widget.titles)),
        ]),
        autoStart: false,
        loopMode: LoopMode.playlist)
        .then((value) {
      setState(() {});
    });
  }


  Widget slider(RealtimePlayingInfos realtimePlayingInfos) {
    return SliderTheme(
        data: const SliderThemeData(
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
        ),
        child: Slider.adaptive(
            value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
            max: realtimePlayingInfos.duration.inSeconds.toDouble(),
            activeColor: Colors.black,
            inactiveColor: Colors.grey[600],
            onChanged: (value) {
              assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
            }
            ));
  }

  Widget timestamps(RealtimePlayingInfos realtimePlayingInfos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(transformString(realtimePlayingInfos.currentPosition.inSeconds)),
        Text(transformString(realtimePlayingInfos.duration.inSeconds))
      ],
    );
  }

  Widget playBar(RealtimePlayingInfos realtimePlayingInfos) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.autorenew,
            size: 25,
          ),
          const Icon(
            Icons.fast_rewind,
            size: 25,
            color: Colors.grey,
          ),
          FloatingActionButton(
            onPressed: () {
              assetsAudioPlayer.playOrPause();
              setState(() {
                if (!isPlaying) {
                  isPlaying = true;
                } else {
                  isPlaying = false;
                }
              });
            },
            backgroundColor: Colors.black,
            child: Icon(realtimePlayingInfos.isPlaying
                ? Icons.pause
                : Icons.play_arrow),
          ),
          const Icon(Icons.fast_forward, size: 25, color: Colors.grey),
          const Icon(Icons.shuffle)
        ],
      ),
    );
  }

  String transformString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  @override
  Widget build(BuildContext context) {
    const double size = 30;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 0,
            elevation: 0,
            title: Row(
              children: [
                Transform.translate(
                  offset: Offset(0, -animationController.value * 40),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                    label: const Text(
                      "MENU",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  child: SvgPicture.asset(
                    "assets/icons/circle.svg",
                    height: 40.0,
                    width: 30.0,
                  ),
                ),
              ],
            ),
            actions: [
              Transform.translate(
                offset: Offset(0, -animationController.value * 40),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/icons/profile.png')),
                ),
              )
            ],
            backgroundColor: Colors.transparent
        ),
        // color: Colors.transparent,
       body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
            } else if (notification.direction == ScrollDirection.reverse) {}
            return true;
          },
          child: SingleChildScrollView(
            controller: scrollcontroller,
            child: PlayerBuilder.current(
              player: assetsAudioPlayer,
              builder: (context,play) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon:
                                const Icon(Icons.chevron_left, color: Colors.black),
                            label: const Text(
                              "BACK",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Color(0xFF3b393f)),
                            ),
                          ),
                        ),
                      ],
                    ),
                     Padding(
                      padding:  const EdgeInsets.only(left: 30,right: 30),
                      child: SizedBox(
                        height: 350,
                        child: Cardflip(desc: widget.desc, image: widget.image,),
                      ),
                    ),
                     const SizedBox(
                      height: 15,
                    ),
                     Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, top: 10),
                        child: Text(
                          play.audio.audio.metas.title.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Color(0xFF3b393f)),
                        ),
                      ),
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(left: 30, top: 10),
                          child: Text(
                            play.audio.audio.metas.album.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color(0xFF3b393f)
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 130),
                              child: LikeButton(
                                size: size,
                                circleColor:
                                const CircleColor(start: Color(0xff000000), end: Color(0xff000000)),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Color(0xff0041C2),
                                  dotSecondaryColor: Color(0xff0041C2),
                                ),
                                isLiked: isLiked,
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.favorite,
                                    color: isLiked ? Colors.black : Colors.grey,
                                    size: size,
                                  );
                                },
                              )
                        ),
                        SizedBox(
                            height: 30,
                            width: 50,
                            child: Lottie.asset(
                                animate: isPlaying, 'assets/wave.json'
                            )
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    assetsAudioPlayer.builderRealtimePlayingInfos(
                        builder: (context, realtimePlayingInfos) {
                      // ignore: unnecessary_null_comparison
                      if (realtimePlayingInfos != null) {
                        return Column(
                          children: [
                            SizedBox(height: screenHeight * 0.03),
                            slider(realtimePlayingInfos),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, right: 25),
                              child: timestamps(realtimePlayingInfos),
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            playBar(realtimePlayingInfos),
                          ],
                        );
                      } else {
                        return  const Column();
                      }
                    }),
                    const SizedBox(
                      height: 27,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "TRACK LIST",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: Color(0xFF3f3e3f)),
                      ),
                    ),
                    const Icon(
                      Icons.expand_more,
                    ),
                    const SizedBox(
                      height: 05,
                    ),
                     const SizedBox(
                      height: 435,
                      child: AudioPlayerScreen(),
                    ),
                    const SizedBox(
                      height: 05,
                    ),
                     const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "Related Albums",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Color(0xFF1a191b)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 250,
                      child: ImageNameList(),
                    ),
                  ],
                );
              }
            ),
          ),
        )
    );
  }
}

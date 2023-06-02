import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'SongPage.dart';

class SliderName {
  final String titles;
  final String photo;
  final String desc;
  final String image;
  final String url;

  SliderName({required this.titles, required this.photo, required this.desc, required this.image, required this.url});
}
class SliderNameList extends StatefulWidget {

  @override
  State<SliderNameList> createState() => _SliderNameListState();
}

class _SliderNameListState extends State<SliderNameList> with TickerProviderStateMixin {
  final List<SliderName> SliderNames = [
    SliderName(titles: 'Röyksopp', desc: "Junior", image: 'assets/image/royksopp-junior.png',url: 'assets/song/Bewafa Tera Muskurana - Jubin Nautiyal 128 Kbps.mp3', photo: 'Bewafa Tera Muskurana'),
    SliderName(titles: 'Radiohead', desc: "Supercollider", image: 'assets/image/Radiohead supercollider.png', url: 'assets/song/Desh Mere - Bhuj The Pride Of India 128 Kbps.mp3', photo: 'Desh Mere'),
    SliderName(titles: 'The Black Crows', desc: "Croweology", image: 'assets/image/the black crows Croweology.png',url: 'assets/song/Ishq Mein - Sachet Tandon 128 Kbps.mp3', photo: 'Ishq Mein'),
    SliderName(titles: 'Sebastien Tellier', desc: "Politics", image: 'assets/image/sebastien tellier politics.png',url: 'assets/song/Khushi Jab Bhi Teri - Jubin Nautiyal 128 Kbps.mp3', photo: 'Khushi Jab Bhi Teri'),
    SliderName(titles: 'The Rolling Stone', desc: "Grrr!", image: 'assets/image/rolling-stones-grrr.png',url: 'assets/song/Mann Bharryaa 2.0 - Shershaah 128 Kbps.mp3', photo: 'Mann Bharryaa'),
    SliderName(titles: 'Tame Impala', image: 'assets/image/tame impala the slow rush.png', desc: 'The Slow Rush', url: 'assets/song/Marjaawaan - Bell Bottom 128 Kbps.mp3', photo: 'Marjaawaan'),
    SliderName(titles: 'The Black Crows', image: 'assets/image/sound.png', desc: 'Croweology', url: 'assets/song/Saath Kya Nibhaoge - Tony Kakkar 128 Kbps.mp3', photo: 'Saath Kya Nibhaoge')
  ];
  double _currentPage = 0.0;
  late AnimationController  _animationController;
  late Animation<double> _animation;
  double _dragAmount = 0.0;
  final double _pullDownThreshold = 80.0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFd5d4d1),
      body: SafeArea(
        child: CarouselSlider.builder(
          options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              height: 390,
              aspectRatio: 10/9,
              viewportFraction: 0.70,
              enlargeCenterPage: true,
              reverse: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index.toDouble();
                  _animationController.reset();
                  _animationController.forward();
                });
              }
          ),
          itemCount: SliderNames.length,
          itemBuilder: (context, index, item) {
            return GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dy > 5 && _currentPage == index) {
                  setState(() {
                    _dragAmount += details.delta.dy;
                  });
                }
              },
              onPanEnd: (details) {
                if (_dragAmount > _pullDownThreshold && _currentPage == index) {
                  setState(() {
                    _dragAmount = 0;
                    _currentPage++;
                  });
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(seconds: 1),
                      reverseTransitionDuration: const Duration(seconds: 1),
                      pageBuilder: (context, animation, secondaryAnimation) =>  SongPage(
                        image: SliderNames[index].image,
                        desc: SliderNames[index].desc,
                        photo: SliderNames[index].photo,
                        titles: SliderNames[index].titles,
                        url: SliderNames[index].url,
                      ),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        final tween = Tween(begin: 0.0, end: 1.0);
                        final fadeAnimation = animation.drive(tween);
                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                } else {
                  setState(() {
                    _dragAmount = 0;
                  });
                }
              },
              child: AnimatedContainer(
                alignment: FractionalOffset.center,
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(
                  top: _currentPage == index ? _dragAmount : 3,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: 220,
                          clipBehavior: Clip.hardEdge,
                          margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: ScaleTransition(
                            scale: Tween(
                              begin: 1.3,
                              end: 1.0,
                            ).animate(_animationController),
                            child: Image.asset(
                              SliderNames[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          SliderNames[index].titles,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF6d6c6d)
                          ),
                        ),
                        const SizedBox(height: 05),
                        Text(
                          SliderNames[index].desc,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: Color(0xFF3b393f)
                          ),
                        ),
                        const SizedBox(height: 05),
                        SizedBox(
                          width: 80,
                          child: Image.asset(
                              "assets/image/Rating.png"
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context,child){
                                return Transform.translate(
                                  offset: Offset(0, _animation.value),
                                  child: child,
                                );
                              },
                              child: Column(
                                children:  [
                                  Image.asset("assets/icons/music1.png",height: 20,width: 20),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "DRAG TO LISTEN",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xFF3b393f)
                                    ),
                                  ),
                                  const Icon(
                                    Icons.expand_more,
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Cardflip extends StatefulWidget {
  final String desc;
  final String image;
  const Cardflip({Key? key, required this.desc, required this.image}) : super(key: key);
  @override
  State<Cardflip> createState() => _CardflipState();
}

class _CardflipState extends State<Cardflip> with SingleTickerProviderStateMixin {
  double rating = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Offset> _textAnimation;
  bool isFront = true;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        setState(() {
          isFront = !isFront;
        });
      }
    });
    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void flipCard() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          flipCard();
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final animationValue = _animation.value;
            const perspectiveValue = 0.003;
            final perspective = Matrix4.identity()
              ..setEntry(3, 2, perspectiveValue);
            final backOpacity = isFront ? animationValue : 1.0;
            return Stack(
                children: [
                  FlipCard(
                    front: Container(
                      height: 350,
                      width: 310,
                      decoration: BoxDecoration(
                        image:   DecorationImage(
                          image: AssetImage(
                              widget.image.toString(),
                          ),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    back: Container(),
                  ),
                  // Back of the card
                  Transform(
                    transform: perspective.scaled(1.0, 1.0, 1.0),
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: backOpacity,
                      child: Container(
                        height: 350,
                        width: 310,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFE4E3E4),
                        ),
                        child: SlideTransition(
                          position: _textAnimation,
                          child: Column(
                            children: [
                                Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  widget.desc,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 80,
                                width: 260,
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit maecenas varius tortor nibh. sit amet tempor nibh finibus et aenean eu enim"
                                      " justo vestibulum aliquam hendrerit molestie.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 40,
                                width: 260,
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    FloatingActionButton.small(
                                      heroTag: 'plane',
                                      onPressed: () {},
                                      backgroundColor: Colors.black,
                                      child: const ImageIcon(
                                        AssetImage('assets/icons/plane.png'),
                                        size: 20,
                                      ),
                                    ),
                                    FloatingActionButton.small(
                                      heroTag: 'share',
                                      onPressed: () {},
                                      backgroundColor: Colors.black,
                                      child: const ImageIcon(
                                        AssetImage('assets/icons/share.png'),
                                        size: 20,
                                      ),
                                    ),
                                    FloatingActionButton.small(
                                      heroTag: 'headphone',
                                      onPressed: () {},
                                      backgroundColor: Colors.black,
                                      child: const ImageIcon(
                                        AssetImage(
                                            'assets/icons/headphone.png'),
                                        size: 20,
                                      ),
                                    ),
                                    FloatingActionButton.small(
                                      heroTag: 'setting',
                                      onPressed: () {},
                                      backgroundColor: Colors.black,
                                      child: const ImageIcon(
                                        AssetImage('assets/icons/setting.png'),
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "Rate this Album",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 50,
                                width: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xFFFFFFFF)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 20),
                                  child: RatingBar(
                                    initialRating: 0,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemSize: 25.0,
                                    ratingWidget: RatingWidget(
                                      full: const Icon(
                                          Icons.star, color: Colors.amber),
                                      half: const Icon(Icons.star_half),
                                      empty: const Icon(Icons.star_border),
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ]
            );
          },
        ),
      )
    );
  }
}

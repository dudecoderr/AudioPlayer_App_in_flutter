import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled6/slider_list.dart';

 class Homepage extends StatelessWidget {
   const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFd5d4d1),
      appBar: AppBar(
          elevation: 0,
          title: Row(
            children: [
              TextButton.icon(
                onPressed: (){},
                icon: const Icon(Icons.more_vert,color: Colors.black),
                label: const Text(
                  "MENU",
                  style: TextStyle(
                      color: Colors.black
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
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                  onPressed: (){},
                  icon: Image.asset('assets/icons/profile.png')
              ),
            ),
          ],
          backgroundColor: Colors.transparent
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
               const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
                child: SliderNameList(),
              ),
               const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30,top: 150),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Genres",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 130,left: 40),
                    child: Text(
                        "_ Indie Rock",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 1.0,
                  width: 240.0,
                  color: Colors.black,
                  margin: const EdgeInsets.only(left: 30,bottom: 10.0),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 30),
                      child: InkWell(
                        child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:  const Color(0xFF272c32)
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Indie Rock",
                              style:  TextStyle(
                                fontFamily: "Montserrat-Medium",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        onTap: (){},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10),
                      child: InkWell(
                        child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xFF666564)
                            )
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Pop",
                              style:  TextStyle(
                                fontFamily: "Montserrat-Medium",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF282824),
                              ),
                            ),
                          ),
                        ),
                        onTap: (){},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10),
                      child: InkWell(
                        child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xFF666564)
                            )
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Reggae",
                              style:  TextStyle(
                                fontFamily: "Montserrat-Medium",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF282824),
                              ),
                            ),
                          ),
                        ),
                        onTap: (){},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10),
                      child: InkWell(
                        child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: const Color(0xFF666564)
                              )
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Indie Rock",
                              style:  TextStyle(
                                fontFamily: "Montserrat-Medium",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF282824),
                              ),
                            ),
                          ),
                        ),
                        onTap: (){},
                      ),
                    )
                  ],
                ),
              ),
            ]
          ),
        )
      )
    );
  }
}
import 'package:flutter/material.dart';

class ImageName {
  final String name;
  final String desc;
  final String image;

  ImageName({required this.name, required this.desc, required this.image});
}

class ImageNameList extends StatelessWidget {
  final List<ImageName> imageNames = [
    ImageName(name: 'Pearl Jam', desc: "Rio Act", image: 'assets/image/pearl jam.png'),
    ImageName(name: 'Röyksopp', desc: "Rio Act", image: 'assets/image/royksopp.png'),
    ImageName(name: 'The Black Crows', desc: "Croweology", image: 'assets/image/the black crows Croweology.png'),
    ImageName(name: 'Mgmt', desc: "little dark age", image: 'assets/image/mgmt little dark age.png'),
    ImageName(name: 'Digitalism', desc: "I Love You Dude", image: 'assets/image/digitalism.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageNames.length,
          itemBuilder: (context,index){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20),
                  child: Container(
                    height: 150,
                    width: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imageNames[index].image),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  imageNames[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0xFF242830)
                  ),
                ),
                Text(
                  imageNames[index].desc,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color: Color(0xFF1a191b)
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}

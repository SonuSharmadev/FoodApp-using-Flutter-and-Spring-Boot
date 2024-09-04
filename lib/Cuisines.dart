import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class Cuisines extends StatelessWidget {
  final dynamic item;

  const Cuisines({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, '/itemPage', arguments: {'item': item});
        print("tapped");
      },
      child: Container(
        height: 120,
        width: 110,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 55.0,
                left: 10,
              ),
              child: GlassmorphicContainer(
                height: 100,
                width: 110,
                borderRadius: 16,
                blur: 0.3,
                alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0x020616).withAlpha(18),
                      Color.fromARGB(124, 193, 195, 202),
                    ],
                    stops: [
                      0.1,
                      0.8,
                    ]),
                borderGradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0xFF4579C5).withAlpha(10),
                      Color(0xFFFFFFF).withAlpha(20),
                      Color(0xFFF75035).withAlpha(20),
                    ],
                    stops: [
                      0.6,
                      0.95,
                      1
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Starters",
                      //item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.network(
                item.titleimage,
                width: 220,
                height: 170,
                cacheHeight: 70,
                cacheWidth: 70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/background3.jpg', // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.black
                  .withOpacity(0), // Transparent color to apply blur effect
            ),
          ),
          Center(
            child: GlassmorphicContainer(
              height: MediaQuery.of(context).size.height - 240,
              width: MediaQuery.of(context).size.width - 50,
              borderRadius: 12,
              blur: 8,
              alignment: Alignment.bottomCenter,
              border: 1,
              linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0x020616).withAlpha(40),
                    Color(0xFFffffff).withAlpha(75),
                  ],
                  stops: [
                    0.0,
                    0.5,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/assets/images.png"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26.0),
                    child: Text(
                      "Enhance your diet with a selection of flavorful recipes that provide both great nutrition and enjoyable taste, making each meal a pleasure.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: 190,
                    height: 70,
                    child: FloatingActionButton(
                      backgroundColor: Colors.black87,
                      onPressed: () {
                        Navigator.pushNamed(context, '/introduction');
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

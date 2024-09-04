import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kababjees/landingPage.dart';
import 'package:lottie/lottie.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

void onIntroEnd(BuildContext context) {
  Navigator.pushNamed(context, '/MainScreen');
}

class _IntroductionState extends State<Introduction> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => Landingpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Image.asset(
        'lib/assets/background3.jpg',
        fit: BoxFit.cover,
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          color: Colors.black.withOpacity(0),
        ),
      ),
      Positioned.fill(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: GlassmorphicContainer(
            height: 350,
            width: 175,
            borderRadius: 12,
            blur: 0,
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
                  0.1,
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
            child: IntroductionScreen(
              key: introKey,
              animationDuration: 750,
              globalBackgroundColor: Colors.transparent,
              autoScrollDuration: 5000,
              showDoneButton: true,
              infiniteAutoScroll: true,
              pages: [
                PageViewModel(
                  title: "Order Kababjees Online",
                  body:
                      "Experience the convenience of ordering from Kababjees online. Enjoy a range of high-quality dishes delivered fresh to your home, perfect for any occasion.",
                  image: Padding(
                    padding: const EdgeInsets.only(top: 52.0),
                    child: LottieBuilder.asset('lib/assets/ordering.json'),
                  ),
                ),
                PageViewModel(
                  title: "Carefully Prepared",
                  body:
                      "Meticulously crafted with attention to every flavor and ingredient, ensuring exceptional quality and precision in every dish",
                  image: Padding(
                    padding: const EdgeInsets.only(top: 52.0),
                    child: LottieBuilder.asset('lib/assets/cooking.json'),
                  ),
                ),
                PageViewModel(
                  title: "Fast Delivery",
                  body:
                      "With Kababjees' fast delivery, your meals arrive quickly and with the quality you expect. Order now and experience prompt service with every delivery",
                  image: Padding(
                    padding: const EdgeInsets.only(top: 52.0),
                    child: LottieBuilder.asset('lib/assets/delivery.json'),
                  ),
                ),
              ],
              onDone: () => _onIntroEnd(context),
              onSkip: () => _onIntroEnd(context),
              showSkipButton: true,
              skipOrBackFlex: 0,
              nextFlex: 0,
              showBackButton: false,
              back: const Icon(Icons.arrow_back),
              skip: const Text('Skip',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              next: const Icon(Icons.arrow_forward),
              done: const Text('Done',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              curve: Curves.ease,
              controlsMargin: const EdgeInsets.all(32),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                color: Color(0xFFBDBDBD),
                activeSize: Size(22.0, 10.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              dotsContainerDecorator: const ShapeDecoration(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

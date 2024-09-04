import 'package:flutter/material.dart';

class Createitem extends StatefulWidget {
  const Createitem({super.key});

  @override
  State<Createitem> createState() => _CreateitemState();
}

class _CreateitemState extends State<Createitem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:kababjees/ExpandableButton.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final dynamic item;

  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/itemPage', arguments: {'item': item});
        },
        child: Container(
          height: 220,
          width: 180,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 35.0,
                  left: 15,
                ),
                child: GlassmorphicContainer(
                  height: 200,
                  width: 145,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${item.name}           ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${item.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -3,
                right: 20,
                child: ExpandableButton(
                  item: item,
                ),
              ),
              Image.network(
                item.titleimage,
                width: 220,
                height: 170,
                cacheHeight: 150,
                cacheWidth: 160,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

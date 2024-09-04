import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:kababjees/CustomDrawer.dart';
import 'package:kababjees/HomeScreen.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Itempage extends StatefulWidget {
  const Itempage({super.key});

  @override
  State<Itempage> createState() => _ItempageState();
}

class _ItempageState extends State<Itempage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  void _increment() {
    int currentValue = int.tryParse(_controller.text) ?? 0;

    if (currentValue < 99) {
      _controller.text = (currentValue + 1).toString();
    }
  }

  void _decrement() {
    int currentValue = int.tryParse(_controller.text) ?? 0;

    if (currentValue > 0) {
      _controller.text = (currentValue - 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Items item = arguments['item'] as Items;
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          title: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 202, 40, 29),
              )),
          actions: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 202, 40, 29),
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 32),
              child: GlassmorphicContainer(
                height: 210,
                width: 200,
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
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                SimpleShadow(
                  child: Image.network(item.titleimage),
                  opacity: 1,
                  color: Colors.black,
                  offset: Offset(2, 8),
                  sigma: 10,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "${item.name}",
                  //"Masala Fries",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    "${item.description}",
                    //"Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _decrement();
                        },
                        icon: Icon(
                          Icons.remove,
                          color: Colors.white,
                        )),
                    Container(
                      width: 50,
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          _increment();
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .changequantity(
                                item, int.parse(_controller.text.toString()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart),
                              Text("Set Amount")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        endDrawer: Customdrawer());
  }
}

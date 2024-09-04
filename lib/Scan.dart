import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kababjees/CustomDrawer.dart';
import 'package:kababjees/HomeScreen.dart';
import 'package:kababjees/Special.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Icon(
          Icons.menu,
          color: Colors.transparent,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color.fromARGB(255, 202, 40, 29),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_bag,
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
            'lib/assets/background3.jpg', // Replace with your image asset path
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.black
                  .withOpacity(0), // Transparent color to apply blur effect
            ),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Text(
                "Scan to pay and earn to earn points",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800),
                textAlign: TextAlign.center,
              ),
              Image.asset("lib/assets/scan.jpg"),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Text(
                  "Scan your code and earn points with every purchase",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 70,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 70,
                    child: FloatingActionButton.extended(
                        backgroundColor: Color.fromARGB(255, 202, 40, 29),
                        foregroundColor: Colors.white,
                        onPressed: () {},
                        label: Row(
                          children: [
                            Icon(Icons.qr_code_scanner),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Scan Kababjees Voucher",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        )),
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(18)),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => Homescreen()),
                              );
                            },
                            icon: Icon(
                              Icons.restaurant_menu,
                              color: Colors.white,
                            )),
                        Text(
                          "Menu",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => Specials()),
                              );
                            },
                            icon: Icon(
                              Icons.local_offer_outlined,
                              color: Colors.white,
                            )),
                        Text(
                          "For You",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.create_outlined,
                              color: Color.fromARGB(255, 202, 40, 29)
                                  .withAlpha(240),
                            )),
                        Text(
                          "Scan",
                          style: TextStyle(
                              color: Color.fromARGB(255, 202, 40, 29)
                                  .withAlpha(240)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/cartPage');
                            },
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            )),
                        Text(
                          "Your Order",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
      endDrawer: Customdrawer(),
    );
  }
}

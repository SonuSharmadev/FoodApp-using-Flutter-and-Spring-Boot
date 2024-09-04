import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kababjees/HomeScreen.dart';

class DeliveryMethod extends GetxController {
  RxInt isDelivery = 2.obs;

  void deliverySelected() {
    isDelivery = 1.obs;
  }

  void pickupSelected() {
    isDelivery = 0.obs;
  }
}

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final DeliveryMethod counterController = Get.put(DeliveryMethod());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          Positioned(
            right: -MediaQuery.of(context).size.width / 2.0,
            top: MediaQuery.of(context).size.height / 8,
            child: Transform.rotate(
              angle: pi / 1.95,
              child: Container(
                width: 450,
                height: 300,
                child: Image.asset(
                  'lib/assets/delivery.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: -MediaQuery.of(context).size.width / 8.2,
            bottom: MediaQuery.of(context).size.height / 10,
            child: Transform.rotate(
              angle: pi / 7,
              child: Container(
                width: 280,
                height: 450,
                child: Image.asset(
                  'lib/assets/friesLong.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: Colors.grey.shade900),
                ),
                Text(
                  "Have a lovely \n fry-day",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.grey.shade700),
                ),
                Spacer(),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 70,
                      child: FloatingActionButton.extended(
                          backgroundColor: Color.fromARGB(255, 202, 40, 29),
                          foregroundColor: Colors.white,
                          onPressed: () {
                            counterController.deliverySelected();
                            print("delivery selected");
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => Homescreen()),
                            );
                          },
                          label: Row(
                            children: [
                              Icon(Icons.delivery_dining),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Continue with Delivery"),
                            ],
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 70,
                      child: FloatingActionButton.extended(
                          backgroundColor: Color.fromARGB(255, 202, 40, 29),
                          foregroundColor: Colors.white,
                          onPressed: () {
                            counterController.pickupSelected();
                            print("pickup selected");
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => Homescreen()),
                            );
                          },
                          label: Row(
                            children: [
                              Icon(Icons.shopping_bag),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Continue with Pickup"),
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

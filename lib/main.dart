import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kababjees/CartPage.dart';
import 'package:kababjees/Checkout.dart';
import 'package:kababjees/Delivery.dart';
import 'package:kababjees/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:kababjees/Introduction.dart';
import 'package:kababjees/itemPage.dart';
import 'package:kababjees/Special.dart';
import 'package:kababjees/showOrders.dart';
import 'package:provider/provider.dart';
import 'package:kababjees/cart_provider.dart';

// WHEN ADDING ITEM TO CART. GET ITEM QUANTITY THEN ADD TO CART. NECCESSARY AF FR

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KababJees',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/HomeScreen': (context) => Homescreen(),
        '/itemPage': (context) => Itempage(),
        '/introduction': (context) => Introduction(),
        '/cartPage': (context) => Cartpage(),
        '/specials': (context) => Specials(),
        '/checkOut': (context) => Checkout(),
        '/showOrders': (context) => ShowOrders(),
        '/deliveryPage': (context) => DeliveryPage()
      },
      home: Introduction(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';

class Customdrawer extends StatefulWidget {
  const Customdrawer({super.key});

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(225, 14, 14, 14),
      width: MediaQuery.of(context).size.width * 0.55,
      child: GlassmorphicContainer(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 100,
        blur: 0.3,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(164, 193, 195, 202),
              Color.fromARGB(184, 193, 195, 202),
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
        borderRadius: 16,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_rounded, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                final cart = cartProvider.cart.items;
                return Container(
                  height: MediaQuery.of(context).size.height - 180,
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 150,
                          child: Stack(children: [
                            Center(
                              child: Image.network(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  fit: BoxFit.fitWidth,
                                  item.titleimage),
                            ),
                            /*
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 100.0, left: 100),
                              child: Center(
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white54,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        Provider.of<CartProvider>(context,
                                                listen: false)
                                            .removeItem(item.id, item);
                                      });
                                    },
                                    icon: Icon(Icons.close),
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),*/
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 100.0, right: 100),
                              child: Center(
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white54,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${item.quantity}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return ListTile(
                    title: Text(
                      'Total Price ${cartProvider.totalPrice}',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    trailing: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white54,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cartPage');
                        },
                        icon: Icon(Icons.shopping_cart),
                        color: Color.fromARGB(255, 202, 40, 29),
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:kababjees/CustomDrawer.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedValue = 1;
  bool _isCreditCardSelected = false;
  double containerHeight = 200;
  late List<Map<String, dynamic>> orderItems;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get CartProvider instance
    final cartProvider = Provider.of<CartProvider>(context);

    // Calculate container height based on the number of items
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        containerHeight = 84.0 * cartProvider.cart.items.length + 100;
      });
    });
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void createData(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cart = cartProvider.cart.items;

    orderItems = cart.map((cartItem) {
      return {
        'item': {
          'id': cartItem.id,
        },
        'quantity': cartItem.quantity,
      };
    }).toList();

    final Map<String, dynamic> data = {
      'orderStatus': 'Pending',
      'customerName': 'Testing',
      'orderItems': orderItems,
    };

    print(data);

    postRequest(data);
  }

  Future<void> postRequest(Map<String, dynamic> data) async {
    final url = Uri.parse('http://192.168.18.124:8080/api/order/add');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      print('Request was successful');
      print('Response body: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    Navigator.pushNamed(context, '/showOrders');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        shadowColor: Colors.black.withAlpha(30),
        surfaceTintColor: Colors.black.withAlpha(30),
        //scrolledUnderElevation: 0,
        actions: [
          IconButton(
            color: Color.fromARGB(255, 202, 40, 29),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          Spacer(),
          Text(
            "Checkout",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 202, 40, 29)),
          ),
          Spacer(
            flex: 5,
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color.fromARGB(255, 202, 40, 29),
            ),
            onPressed: () {},
          ),
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
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 5,
                ),
                GlassmorphicContainer(
                  height: 415,
                  width: 175,
                  borderRadius: 16,
                  blur: 0.3,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0x020616).withAlpha(8),
                        Color.fromARGB(104, 193, 195, 202),
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
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text(
                              "Delivery Address",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 202, 40, 29),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 202, 40, 29),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset("lib/assets/location2.png"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ibad Musheer",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "XGen Technologies",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Plot 13C,Stadium Lane 2, Stadium Commercial Area Defence V Defence Housing Authority, Karachi",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800]),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: _isCreditCardSelected ? 360 : 200,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0x020616).withAlpha(8),
                          Color.fromARGB(104, 193, 195, 202),
                        ],
                        stops: [0.1, 0.8],
                      ),
                      border: Border.all(
                        width: 2,
                        color: Colors.transparent,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Payment Method",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 202, 40, 29),
                            ),
                          ),
                        ),
                        RadioListTile<int>(
                          title: Text(
                            'Cash on Delivery',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                          value: 1,
                          groupValue: _selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedValue = value!;
                              _isCreditCardSelected = false;
                            });
                          },
                        ),
                        RadioListTile<int>(
                          title: Text(
                            'Credit / Debit Card',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                          value: 2,
                          groupValue: _selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedValue = value!;
                              _isCreditCardSelected = true;
                            });
                          },
                        ),
                        if (_isCreditCardSelected) ...[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Card Number',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Expiry Date',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'CVV',
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return GlassmorphicContainer(
                      height: containerHeight,
                      width: 175,
                      borderRadius: 16,
                      blur: 0.3,
                      alignment: Alignment.bottomCenter,
                      border: 2,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0x020616).withAlpha(8),
                          Color.fromARGB(104, 193, 195, 202),
                        ],
                        stops: [0.1, 0.8],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFF4579C5).withAlpha(10),
                          Color(0xFFFFFFF).withAlpha(20),
                          Color(0xFFF75035).withAlpha(20),
                        ],
                        stops: [0.6, 0.95, 1],
                      ),
                      child: Builder(
                        builder: (context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize
                                .min, // Column sizes itself based on its content
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Order Summary",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 202, 40, 29),
                                  ),
                                ),
                              ),
                              Consumer<CartProvider>(
                                builder: (context, cartProvider, child) {
                                  final cart = cartProvider.cart.items;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        List.generate(cart.length, (index) {
                                      final item = cart[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${item.name} x ${item.quantity}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "${item.price * item.quantity}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: 200,
                                              height: 40,
                                              child: Text(item.description),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 90,
                )
              ],
            ),
          ),
          Positioned(
              bottom: 16,
              right: 0,
              left: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(18)),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          return Text(
                            '  Total Price: ${cartProvider.totalPrice}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          );
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FloatingActionButton.extended(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          onPressed: () {
                            createData(context);
                            //Navigator.pushNamed(context, '/showOrders');
                          },
                          label: Text("Place Order"),
                          icon: Icon(
                            Icons.check_circle_outline,
                            color: Color.fromARGB(255, 202, 40, 29),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
      endDrawer: Customdrawer(),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kababjees/Cuisines.dart';
import 'package:kababjees/CustomDrawer.dart';
import 'package:kababjees/Delivery.dart';
import 'package:kababjees/ExpandableButton.dart';
import 'package:kababjees/Scan.dart';
import 'package:kababjees/Special.dart';
import 'package:kababjees/itemCard.dart';
import 'package:shimmer/shimmer.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool _isExpanded = false;
  int _quantity = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DeliveryMethod counterController = Get.put(DeliveryMethod());
  List<Items> ItemList = [
    Items(
      id: 3,
      name: 'Masala Fries',
      price: 499,
      quantity: 1,
      description:
          'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
      titleimage:
          'https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e',
    ),
    Items(
      id: 4,
      name: 'Masala Fries',
      price: 499,
      quantity: 1,
      description:
          'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
      titleimage:
          'https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e',
    ),
    Items(
      id: 3,
      name: 'Plain Fries',
      price: 399,
      quantity: 1,
      description:
          'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
      titleimage:
          'https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e',
    ),
  ];

  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;
  List<dynamic> AllIDS = [];
  int index = 0;

  int isDelivery = 0;

  final List<String> _banners = [
    'lib/assets/banner1.jpg',
    'lib/assets/banner1.jpg',
    'lib/assets/banner1.jpg',
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchIDS();
    _startAutoScroll();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % _banners.length;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> fetchData(List<dynamic> ids) async {
    try {
      for (var id in ids) {
        final response = await http
            .get(Uri.parse('http://192.168.18.124:8080/api/items/$id'));
        if (response.statusCode == 200) {
          Map<String, dynamic> data = json.decode(response.body);
          print('Data for ID $id: $data');
          Items item = Items.fromJson(data);
          setState(() {
            ItemList.add(item);
            print(ItemList);
          });
        } else {
          print(
              'Failed to load data for ID $id. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchIDS() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.18.124:8080/api/items/ids'));
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 300) {
        AllIDS = json.decode(response.body);
        print(AllIDS);
        fetchData(AllIDS);
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
    print("all fetched successfully");
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
          title: GestureDetector(
            onTap: () {
              Get.to(() => DeliveryPage());
            },
            child: Row(
              children: [
                ClipRect(
                  child: Align(
                    alignment: Alignment
                        .topLeft, // Adjust alignment to focus on the area you want to display
                    widthFactor: 0.8, // Horizontal cropping factor (0.0 to 1.0)
                    heightFactor: 0.8, // Vertical cropping factor (0.0 to 1.0)
                    child: SvgPicture.asset(
                      height: 60,
                      'lib/assets/pickup.svg',
                      // ignore: deprecated_member_use
                      color: Color.fromARGB(255, 202, 40, 29),
                      fit: BoxFit
                          .cover, // Adjust fit as needed (e.g., BoxFit.contain, BoxFit.fill)
                    ),
                  ),
                ),
                Text(
                  counterController.isDelivery.value == 1
                      ? ' Delivery'
                      : counterController.isDelivery.value == 0
                          ? ' Pickup'
                          : ' None',
                  style: TextStyle(
                      fontSize: 28,
                      color: Color.fromARGB(255, 202, 40, 29),
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.expand_more,
                  color: Color.fromARGB(255, 202, 40, 29),
                )
              ],
            ),
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
        body: Stack(fit: StackFit.expand, children: [
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
          Container(
            child: ListView(children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "What's New",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 202, 40, 29)
                            .withAlpha(240)),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 120.0,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _banners.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _banners[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Our Mainstay Menu",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 202, 40, 29).withAlpha(240)),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 105.0),
                        child: GlassmorphicContainer(
                          height: 300,
                          width: 175,
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
                                  "Combo Burger              ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '900',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        right: 0,
                        child: ExpandableButton(item: ItemList.elementAt(1)),
                      ),
                      Image.asset(
                        "lib/assets/HeartAttack.png",
                        width: 155,
                        height: 320,
                        fit: BoxFit.fitHeight,
                        frameBuilder: (BuildContext context, Widget child,
                            int? frame, bool wasSynchronouslyLoaded) {
                          if (frame != null) {
                            return child;
                          } else {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(color: Colors.white),
                            );
                          }
                        },
                      ),
                    ]),
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 115.0, left: 3),
                        child: GlassmorphicContainer(
                          height: 300,
                          width: 165,
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
                                  "Special Fries              ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '900',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        right: 0,
                        child: ExpandableButton(
                          item: ItemList.elementAt(1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13.0),
                        child: Image.asset(
                          "lib/assets/friesLong.png",
                          width: 150,
                          height: 320,
                          fit: BoxFit.fitHeight,
                          frameBuilder: (BuildContext context, Widget child,
                              int? frame, bool wasSynchronouslyLoaded) {
                            if (frame != null) {
                              return child;
                            } else {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(color: Colors.white),
                              );
                            }
                          },
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Today's Specials",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 202, 40, 29).withAlpha(240)),
                  )),
              SizedBox(
                height: 260,
                width: 140,
                child: ListView.builder(
                  itemCount: ItemList.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = ItemList[index];
                    return ItemCard(item: item);
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Explore Cuisines",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 202, 40, 29).withAlpha(240)),
                  )),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Cuisines(
                          item: ItemList.first,
                        ),
                        Cuisines(
                          item: ItemList.first,
                        ),
                        Cuisines(
                          item: ItemList.first,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Cuisines(
                          item: ItemList.first,
                        ),
                        Cuisines(
                          item: ItemList.first,
                        ),
                        Cuisines(
                          item: ItemList.first,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    repeat: false,
                    'lib/assets/chef3.json',
                    width: MediaQuery.of(context).size.width - 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Can't decide? Treat yourself to",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Today's Special!",
                            style: TextStyle(
                                color: Color.fromARGB(255, 202, 40, 29),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 90,
              ),
            ]),
          ),
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
                            onPressed: () {},
                            icon: Icon(
                              Icons.restaurant_menu,
                              color: Color.fromARGB(255, 202, 40, 29)
                                  .withAlpha(240),
                            )),
                        Text(
                          "Menu",
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
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => Scan()),
                              );
                            },
                            icon: Icon(
                              Icons.create_outlined,
                              color: Colors.white,
                            )),
                        Text(
                          "Scan",
                          style: TextStyle(color: Colors.white),
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
        ]),
        endDrawer: Customdrawer());
  }
}

class Orders {
  final int orderId;
  final DateTime orderDate;
  final DateTime deliveryTime;
  final String orderStatus;
  final String customerName;
  final List<OrderItem> orderItems;

  Orders({
    required this.orderId,
    required this.orderDate,
    required this.deliveryTime,
    required this.customerName,
    required this.orderStatus,
    required this.orderItems,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      orderId: json['orderId'],
      orderDate: DateTime.parse(json['orderDate']),
      deliveryTime: DateTime.parse(json['deliveryTime']),
      customerName: json['customerName'],
      orderStatus: json['orderStatus'],
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }
}

class OrderItem {
  final int itemId;
  final int quantity;
  final Items item;

  OrderItem({
    required this.itemId,
    required this.quantity,
    required this.item,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemId: json['itemId'],
      quantity: json['quantity'],
      item: Items.fromJson(json['item']),
    );
  }
}

class Items {
  final int id;
  final String name;
  final double price;
  int quantity;
  final String description;
  final String titleimage;

  Items({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.titleimage,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: 1,
      description: json['description'],
      titleimage: json['titleImage'],
    );
  }
}

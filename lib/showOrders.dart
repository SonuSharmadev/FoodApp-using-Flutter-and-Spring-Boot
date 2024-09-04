import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kababjees/HomeScreen.dart';
import 'dart:convert';


class ShowOrders extends StatefulWidget {
  const ShowOrders({super.key});

  @override
  State<ShowOrders> createState() => _ShowOrdersState();
}

class _ShowOrdersState extends State<ShowOrders> {
  List<Orders> ordersList = [];

  void fetchOrders() async {
    try {
      final response =
          await http.get(Uri.parse("http://192.168.18.124:8080/api/order/ids"));
      if (response.statusCode == 200) {
        List<dynamic> orderIds = json.decode(response.body);
        fetchData(orderIds);
      } else {
        print('Failed to load order IDs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchData(List<dynamic> ids) async {
    try {
      for (var id in ids) {
        final response = await http
            .get(Uri.parse('http://192.168.18.124:8080/api/order/$id'));
        if (response.statusCode == 200) {
          Map<String, dynamic> data = json.decode(response.body);
          Orders order = Orders.fromJson(data);
          setState(() {
            ordersList.add(order);
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

  void deleteOrder(int id, int index) async {
    try {
      final response = await http
          .delete(Uri.parse("http://192.168.18.124:8080/api/order/delete/$id"));
      if (response.statusCode == 200) {
        setState(() {
          ordersList.removeAt(index);
        });
      } else {
        print('Failed to delete order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 202, 40, 29),
        title: Text(
          'Orders List',
          style: TextStyle(
              color: Color.fromARGB(255, 202, 40, 29),
              fontSize: 26,
              fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
      ),
      body: ordersList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'lib/assets/background3.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.0),
                  ),
                ),
                ListView.builder(
                  itemCount: ordersList.length,
                  itemBuilder: (context, index) {
                    final order = ordersList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color.fromARGB(14, 193, 195, 202),
                        child: ListTile(
                          title: Text('Order ID: ${order.orderId}'),
                          trailing: Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    deleteOrder(order.orderId, index);
                                  },
                                  icon: Icon(Icons.done))
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Customer Name: ${order.customerName}'),
                              Text('Order Status: ${order.orderStatus}'),
                              Text('Order Date: ${order.orderDate}'),
                              Text('Expected Delivery: ${order.deliveryTime}'),
                              Text('Order Items:'),
                              ...order.orderItems.map((orderItem) {
                                return Text(
                                    '  - ${orderItem.item.name} x ${orderItem.quantity}');
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
    );
  }
}

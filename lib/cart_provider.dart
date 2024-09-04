// cart_provider.dart
import 'package:flutter/material.dart';
import 'package:kababjees/HomeScreen.dart';
import 'cart_model.dart';

class CartProvider with ChangeNotifier {
  final Cart _cart = Cart();

  Cart get cart => _cart;

  void addItem(Items item) {
    _cart.addItem(item);
    notifyListeners();
  }

  void changequantity(Items item, int quantity) {
    _cart.changequantity(item, quantity);
    notifyListeners();
  }

  void removeItem(int id, Items item) {
    _cart.removeItem(id, item);
    notifyListeners();
  }

  void increment(Items item) {
    _cart.increment(item);
    notifyListeners();
  }

  void decrement(Items item) {
    _cart.decrement(item);
    notifyListeners();
  }

  int getquantity(Items item) {
    notifyListeners();
    return _cart.getquantity(item);
  }

  double itemPrice(Items item) {
    double temp = _cart.itemPrice(item);
    notifyListeners();
    return temp;
  }

  double get totalPrice => _cart.totalPrice;
}

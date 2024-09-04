import 'package:kababjees/HomeScreen.dart';

class Cart {
  List<Items> items = [];

  void addItem(Items item) {
    final existingItemIndex = items.indexWhere((i) => i.id == item.id);

    if (existingItemIndex != -1) {
      items[existingItemIndex].quantity += 1;
    } else {
      items.add(item);
    }
  }

  void changequantity(Items item, int quantity) {
    final existingItemIndex = items.indexWhere((i) => i.id == item.id);

    if (existingItemIndex != -1) {
      items[existingItemIndex].quantity = quantity;
    } else {
      item.quantity = quantity;
      items.add(item);
    }
  }

  void removeItem(int id, Items item) {
    final existingItemIndex = items.indexWhere((i) => i.id == item.id);
    items[existingItemIndex].quantity = 1;
    items.removeWhere((item) => item.id == id);
  }

  void increment(Items item) {
    final existingItemIndex = items.indexWhere((i) => i.id == item.id);
    items[existingItemIndex].quantity;
    if (items[existingItemIndex].quantity > 98) {
    } else {
      items[existingItemIndex].quantity++;
    }
  }

  void decrement(Items item) {
    final existingItemIndex = items.indexWhere((i) => i.id == item.id);
    items[existingItemIndex].quantity;
    if (items[existingItemIndex].quantity < 1) {
    } else {
      items[existingItemIndex].quantity--;
    }
  }

  int getquantity(Items item) {
    return item.quantity;
  }

  double itemPrice(Items item) {
    return item.price * item.quantity;
  }

  double get totalPrice {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}

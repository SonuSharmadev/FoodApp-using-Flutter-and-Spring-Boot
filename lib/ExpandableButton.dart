import 'package:flutter/material.dart';
import 'package:kababjees/HomeScreen.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';

class ExpandableButton extends StatefulWidget {
  final Items item;

  ExpandableButton({required this.item});

  @override
  _ExpandableButtonState createState() => _ExpandableButtonState();
}

class _ExpandableButtonState extends State<ExpandableButton> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    Items item = widget.item;
    if (item.quantity == 0) {
      setState(() {
        _isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Items item = widget.item;
    if (item.quantity == 0) {
      setState(() {
        _isExpanded = false;
      });
    }
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: _isExpanded
          ? Container(
              key: ValueKey<bool>(_isExpanded),
              width: 105,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.white70),
                    onPressed: () {
                      setState(() {
                        if (item.quantity > 0) {
                          Provider.of<CartProvider>(context, listen: false)
                              .decrement(item);
                        }
                        if (item.quantity == 0) {
                          Provider.of<CartProvider>(context, listen: false)
                              .removeItem(item.id, item);
                          _isExpanded = false;
                        }
                      });
                    },
                  ),
                  Text(
                    '${ Provider.of<CartProvider>(context, listen: false).getquantity(item)}',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.white70),
                    onPressed: () {
                      setState(() {
                        Provider.of<CartProvider>(context, listen: false)
                            .increment(item);
                        if (!_isExpanded) {
                          _isExpanded = true;
                        }
                      });
                    },
                  ),
                ],
              ),
            )
          : Container(
              key: ValueKey<bool>(_isExpanded),
              width: 35,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                    Provider.of<CartProvider>(context, listen: false)
                        .addItem(item);
                  });
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white70,
                ),
              ),
            ),
    );
  }
}

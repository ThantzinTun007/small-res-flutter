import 'package:flutter/material.dart';
import 'package:small_res/models/menuItem.model.dart';
import 'package:small_res/widgets/order_items.dart';
import 'package:small_res/widgets/orders.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen(
      {super.key, required this.orderItems, required this.deleteOrderItem});

  final List<MenuItem> orderItems;
  final void Function(MenuItem menuitem) deleteOrderItem;

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedPageIndex = 0;

  void deleteOrderItem(MenuItem menuitem) {
    setState(() {
      widget.deleteOrderItem(menuitem);
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = OrderItems();

    var activePageTitle = 'Your Order Items';

    if (_selectedPageIndex == 1) {
      activePage = Orders();
      activePageTitle = 'Finished Orders';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}

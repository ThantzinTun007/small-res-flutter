import 'package:flutter/material.dart';
import 'package:small_res/models/menuItem.model.dart';
import 'package:small_res/models/orderItem.dart';
import 'package:small_res/models/tables.dart';
import 'package:small_res/widgets/order_items.dart';
import 'package:small_res/widgets/orders.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen(
      {super.key,
      required this.orderItems,
      required this.deleteOrderItem,
      required this.tables});

  final List<MenuItem> orderItems;
  final void Function(MenuItem menuitem) deleteOrderItem;
  final TableModel tables;

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
    Widget activePage = OrderItems(
      tables: widget.tables,
      orderItem: widget.orderItems,
    );

    if (_selectedPageIndex == 1) {
      activePage = Orders();
    }

    return Scaffold(
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

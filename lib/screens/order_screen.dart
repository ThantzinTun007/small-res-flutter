import 'package:flutter/material.dart';
import 'package:small_res/api/api.dart';
import 'package:small_res/models/menuItem.model.dart';
import 'package:small_res/models/order.dart';
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

  final Api _apiService = Api();
  double _totalAmount = 0.0;

  void _submitOrder(List<OrderItem> orderItem) async {
    final order = Order(
      orderDate: DateTime.now(),
      employeeId: 17,
      // tableId: widget.tables.tableId,
      orderType: 'take away',
      totalAmount: _totalAmount,
    );

    try {
      final orderId = await _apiService.createOrder(order);
      for (var orderItem in orderItem) {
        final item = OrderItem(
          orderId: orderId,
          menuItemId: orderItem.menuItemId,
          quantity: orderItem.quantity,
          price: orderItem.price,
        );
        await _apiService.createOrderItem(item);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order successfully created!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create order: $e')),
      );
    }
  }

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
      addOrder: _submitOrder,
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
              icon: Icon(Icons.set_meal), label: 'Your Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Order list'),
        ],
      ),
    );
  }
}

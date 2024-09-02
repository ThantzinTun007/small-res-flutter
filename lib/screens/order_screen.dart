import 'package:flutter/material.dart';
import 'package:small_res/models/menuItem.model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.orderItems});

  final List<MenuItem> orderItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: ListView.builder(
        itemCount: orderItems.length,
        itemBuilder: (context, index) {
          final orderitem = orderItems[index];

          return ListTile(
            title: Text(orderitem.name),
          );
        },
      ),
    );
  }
}

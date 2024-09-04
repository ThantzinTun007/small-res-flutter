import 'package:flutter/material.dart';
import 'package:small_res/models/menuItem.model.dart';
import 'package:small_res/models/orderItem.dart';
import 'package:small_res/models/tables.dart';

class OrderItems extends StatelessWidget {
  const OrderItems(
      {super.key,
      required this.tables,
      required this.orderItem,
      required this.addOrder});
  final List<MenuItem> orderItem;
  final TableModel tables;
  final Function(List<OrderItem> orderItem) addOrder;

  @override
  Widget build(BuildContext context) {
    List<OrderItem> orderItems = [];

    void getOrderItems(List<MenuItem> menuItems, List<OrderItem> orderItems) {
      Map<String, int> itemCount = {};
      for (MenuItem item in menuItems) {
        itemCount[item.name] = (itemCount[item.name] ?? 0) + 1;
      }

      for (var entry in itemCount.entries) {
        MenuItem menuItem =
            menuItems.firstWhere((item) => item.name == entry.key);

        orderItems.add(OrderItem(
          orderId: 1,
          menuItemId: menuItem.menuItemId,
          quantity: entry.value,
          price: menuItem.price * entry.value,
        ));
      }
    }

    getOrderItems(orderItem, orderItems);

    Map<int, MenuItem> menuItemMap = {
      for (var menuItem in orderItem) menuItem.menuItemId: menuItem,
    };

    MenuItem? menuItem;

    for (var orderItem in orderItems) {
      menuItem = menuItemMap[orderItem.menuItemId];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Table No. ${tables.tableNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  final orderitem = orderItems[index];

                  return ListTile(
                      title: Text(menuItem!.name),
                      trailing:
                          Text('${orderitem.quantity} ${orderitem.price}'));
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await addOrder(orderItems);
              },
              child: const Text('Submit Order'),
            ),
            const SizedBox(height: 20),
            const Text('Total Amount:'),
          ],
        ),
      ),
    );
  }
}

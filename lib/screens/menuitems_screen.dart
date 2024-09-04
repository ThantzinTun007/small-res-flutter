import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:small_res/api/api.dart';
import 'package:small_res/models/menuItem.model.dart';
import 'package:small_res/models/tables.dart';
import 'package:small_res/screens/login_screen.dart';
import 'package:small_res/screens/order_screen.dart';
import 'package:small_res/widgets/menuitem.dart';

class MenuitemsScreen extends StatefulWidget {
  const MenuitemsScreen(
      {super.key, required this.orderItems, required this.deleteOrderItem, required this.tables});

  final List<MenuItem> orderItems;
  final void Function(MenuItem menuitem) deleteOrderItem;
  final TableModel tables;

  @override
  State<MenuitemsScreen> createState() {
    return _MenuitemsScreenState();
  }
}

class _MenuitemsScreenState extends State<MenuitemsScreen> {
  late Future<List<MenuItem>> getMenuItem;

  void addOrderItem(MenuItem menuitem) {
    setState(() {
      widget.orderItems.add(menuitem);
      Fluttertoast.showToast(
        msg: 'Added ${menuitem.name}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getMenuItem = Api().getMenuItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Row(
          children: [
            Image.asset(
              'assets/icon.png',
              scale: 14,
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              'RESTAURANT',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderScreen(
                          orderItems: widget.orderItems,
                          deleteOrderItem: widget.deleteOrderItem, tables: widget.tables,
                        )),
              );
            },
            icon: const Icon(CupertinoIcons.cart),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          ),
        ],
      ),
      body: FutureBuilder<List<MenuItem>>(
          future: getMenuItem,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text('Error: ${snapshot.error}')),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Scaffold(
                body: Center(child: Text('No data found')),
              );
            } else if (snapshot.hasData) {
              return MenuItems(
                menuItem: snapshot,
                addMenuItem: addOrderItem,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

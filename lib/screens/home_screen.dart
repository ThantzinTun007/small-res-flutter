import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_res/api/api.dart';
import 'package:small_res/models/menuItem.model.dart';
import 'package:small_res/models/tables.dart';
import 'package:small_res/screens/login_screen.dart';
import 'package:small_res/screens/menuitems_screen.dart';
import 'package:small_res/screens/order_screen.dart';
import 'package:small_res/widgets/menuitem.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<TableModel>> getTables;

  final List<MenuItem> orderItems = [];

  void deleteOrderItem(MenuItem menuitem) {
    setState(() {
      orderItems.remove(menuitem);
      Fluttertoast.showToast(
        msg: 'Deleted ${menuitem.name}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getTables = Api().fetchTables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tables'),
      ),
      body: FutureBuilder<List<TableModel>>(
        future: getTables,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tables found.'));
          } else {
            final tables = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
                childAspectRatio: 3 / 2, // Aspect ratio of the items
              ),
              itemCount: tables.length,
              itemBuilder: (context, index) {
                final table = tables[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuitemsScreen(
                                orderItems: orderItems,
                                deleteOrderItem: deleteOrderItem,
                                tables: table,
                              )),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Table ${table.tableNumber}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text('Capacity: ${table.capacity}'),
                        Text('Location: ${table.location}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

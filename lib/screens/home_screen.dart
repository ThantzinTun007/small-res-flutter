import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_res/api/api.dart';
import 'package:small_res/models/menuItem.model.dart';
import 'package:small_res/screens/login_screen.dart';
import 'package:small_res/widgets/menuitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MenuItem>> getMenuItem;

  Future<void> signOut() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
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
            onPressed: () {},
            icon:const Icon(CupertinoIcons.cart),
          ),
          IconButton(
            onPressed: () {
              signOut();
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
              return MenuItems(menuItem: snapshot);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

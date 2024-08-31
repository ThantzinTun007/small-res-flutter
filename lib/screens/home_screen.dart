import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
      ),
      body: const Center(
        child: Text('Home screen'),
      ),
    );
  }
}

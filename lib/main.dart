import 'package:flutter/material.dart';
import 'package:small_res/res.dart';

void main() {
  runApp(const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurnat',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
      ),
      home: const Res()
    );
  }
}
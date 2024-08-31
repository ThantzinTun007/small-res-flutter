import 'package:flutter/material.dart';
import 'package:small_res/screens/home_screen.dart';
import 'package:small_res/screens/login_screen.dart';

class Res extends StatefulWidget {
  const Res({super.key});

  @override
  State<Res> createState() {
    return _ResState();
  }
}

class _ResState extends State<Res> {
  String activeScreen = 'login_screen';

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = const HomeScreen();

    return screenWidget;
  }
}

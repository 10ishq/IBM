import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;
import 'package:neon/neon.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'device.dart';
import 'predict.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CheckMate',
        theme: ThemeData(brightness: Brightness.dark),
        home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> widList = [deviceView(), prediction()];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          backgroundColor: Colors.black12.withOpacity(0),
          buttonBackgroundColor: Colors.redAccent,
          color: Colors.blue,
          items: [
            Icon(Icons.medical_services, color: Colors.black),
            Icon(Icons.web, color: Colors.black)
          ],
          onTap: (index) {
            if (index == 0) {
              pageIndex = 0;
            } else {
              pageIndex = 1;
            }
            setState(() {});
          },
        ),
        body: widList[pageIndex]);
  }
}
  
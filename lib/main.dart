import 'package:flutter/material.dart';
import 'package:mobile_app/main-map-screen.dart';
import 'package:mobile_app/details-screen.dart';
import 'package:mobile_app/yo-chart-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => MainMap(),
        '/details': (context) => Details(),
        '/details/test': (context) => YoChartScreen(),
      },
      initialRoute: '/',
    );
  }
}

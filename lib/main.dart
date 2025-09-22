import 'package:flutter/material.dart';
import 'package:flutter_project/pages/vehicle/vehicle_page.dart';

void main() {
  runApp(const ControlAccessApp());
}

class ControlAccessApp extends StatelessWidget {
  const ControlAccessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
      title: 'Control Access',
      debugShowCheckedModeBanner: false,
      home: VehiclePage(),
    );
  }
}

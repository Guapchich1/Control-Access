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
      title: 'Control Access',
      debugShowCheckedModeBanner: false,
      home: const VehiclePage(),
    );
  }
}

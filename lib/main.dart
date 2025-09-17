import 'package:flutter/material.dart';// подключаем библиотеку material
import 'package:flutter_project/Pages/vehicle/vehicle_page.dart';

void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Access',
      debugShowCheckedModeBanner: false,
      home: const VehiclePage(),
    );
  }
}



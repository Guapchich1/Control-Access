import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';
import 'package:flutter_project/pages/widgets/button_door.dart';

class FifthPage extends StatelessWidget {
  const FifthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Control Access',
          style: TextStyle(fontSize: fontsize18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Center(child: ButtonDoor(title: 'Открыть')),
    );
  }
}

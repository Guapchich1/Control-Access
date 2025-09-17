import 'package:flutter/material.dart';
import 'package:flutter_project/Dimensions.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
      body: Text('13'),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_project/Dimensions.dart';
import 'package:flutter_project/Pages/Widgets/Vhod6.dart';

class VhodVhodPage extends StatelessWidget {
  const VhodVhodPage({super.key});

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
        body: Center(
            child: AutorizButton6(title: 'Открыть')
          ),
        );
  }
}

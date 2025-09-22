import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';

class ButtonDoor extends StatelessWidget {
  final String title;
  const ButtonDoor({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Дверь открыта'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(width240, height100),
        foregroundColor: Colors.blue.shade600,
      ),
      child: Text(title),
    );
  }
}

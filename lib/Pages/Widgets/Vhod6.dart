import 'package:flutter/material.dart';

class AutorizButton6 extends StatelessWidget {
  final String title;
  const AutorizButton6({super.key, required this.title});

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
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange,
      ),
      child: Text(title),
    );
  }
}

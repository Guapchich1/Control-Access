import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';

class ButtonVhod extends StatelessWidget {
  final String title;
  final Widget nextPage;

  const ButtonVhod({super.key, required this.title, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(width120, height40),
        foregroundColor: Colors.blue.shade600,
      ),
      child: Text(title),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Dimensions.dart';

class AutorizButton extends StatelessWidget {
  final String title;
  final Widget nextPage;

  const AutorizButton({super.key, required this.title, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context, CupertinoPageRoute(builder: (context) => nextPage),
        );
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(width120, height40),
          backgroundColor: Colors.white,
          foregroundColor: Colors.orange
      ),
      child: Text(title),
    );
  }
}

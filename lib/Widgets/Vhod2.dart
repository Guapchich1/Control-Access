import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AutorizButton2 extends StatelessWidget {
  final String title;
  final Widget nextPage;
  const AutorizButton2({super.key, required this.title, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, CupertinoPageRoute(builder: (context) => nextPage),
        );
      },
      child: Text(
        title,
        style: TextStyle(
          color: Colors.orange,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

}
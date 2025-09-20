import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ButtonPervVhod extends StatelessWidget {
  final String title;
  final Widget nextPage;
  const ButtonPervVhod({
    super.key,
    required this.title,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => nextPage),
        );
      },
      child: Text(title, style: TextStyle(color: Colors.orange)),
    );
  }
}

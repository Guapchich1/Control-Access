import 'package:flutter/material.dart';

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
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Text(title, style: TextStyle(color: Colors.blue.shade600)),
    );
  }
}

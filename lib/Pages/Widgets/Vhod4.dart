import 'package:flutter/material.dart';

class AutorizButton4 extends StatelessWidget {
  final String title;
  final Widget nextPage;
  final GlobalKey<FormState> formKey;

  const AutorizButton4({
    super.key,
    required this.title,
    required this.nextPage,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Вы успешно зарегистрировались'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );

          // переход на новую страницу
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange,
      ),
      child: Text(title),
    );
  }
}
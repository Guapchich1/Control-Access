import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';

class ButtonRegistr extends StatelessWidget {
  final String title;
  final Widget nextPage;
  final GlobalKey<FormState> formKey;

  const ButtonRegistr({
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

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(width120, height40),
        foregroundColor: Colors.blue.shade600,
      ),
      child: Text(title),
    );
  }
}

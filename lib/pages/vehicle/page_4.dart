import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';
import 'package:flutter_project/pages/widgets/button_autorization4.dart';
import 'package:flutter_project/pages/vehicle/page_5.dart';

class FourthPage extends StatelessWidget {
  FourthPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Имя:', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите имя';
                  }
                  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    return 'Разрешены только буквы';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              const Text('Пароль:', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите пароль';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ButtonAutoriz(
                  title: 'Войти',
                  nextPage: FifthPage(),
                  formKey: _formKey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

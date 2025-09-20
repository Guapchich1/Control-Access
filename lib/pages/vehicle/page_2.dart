import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';
import 'package:flutter_project/pages/vehicle/page_3.dart';
import 'package:flutter_project/pages/widgets/button_proverka2.dart';

class SecondPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  SecondPage({super.key});
  final TextEditingController _nameController = TextEditingController();

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
              const Text('Первичный код:', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите код';
                  }
                  if (int.tryParse(value) != parol) {
                    return 'Неверный код';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ButtonProverka(
                  title: 'Проверить',
                  nextPage: ThirdPage(),
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

import 'package:flutter/material.dart';
import 'package:flutter_project/pages/vehicle/page_3.dart';
import 'package:flutter_project/pages/widgets/button_proverka2.dart';
import 'package:flutter_project/pages/widgets/helper/appbar_helper.dart';
import 'package:flutter_project/services/validation_service.dart';

class SecondPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  SecondPage({super.key});
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //выравнивание слева
            children: [
              const Text('Первичный код:', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                controller: _nameController,
                validator: ValidationService.validateCode,
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

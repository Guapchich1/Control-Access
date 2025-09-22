import 'package:flutter/material.dart';
import 'package:flutter_project/pages/vehicle/vehicle_page.dart';
import 'package:flutter_project/pages/widgets/button_registration3.dart';
import 'package:flutter_project/pages/widgets/helper/appbar_helper.dart';
import 'package:flutter_project/services/validation_service.dart';

class ThirdPage extends StatelessWidget {
  ThirdPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
                validator: ValidationService.validateName,
              ),
              const SizedBox(height: 20.0),
              const Text('Пароль:', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                controller: _passwordController,
                validator: ValidationService.validatePassword,
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ButtonRegistr(
                  title: 'Завершить регистрацию',
                  nextPage: VehiclePage(),
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

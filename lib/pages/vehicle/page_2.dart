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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                    const Text(
                      'Первичный код:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF7FFFD4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      validator: ValidationService.validateCode,
                      obscureText: true,
                      style: const TextStyle(
                        color: Color(0xFF7FFFD4),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF374151),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFF4A5568),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFF7FFFD4),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFFFF6B6B),
                            width: 1.5,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFFFF6B6B),
                            width: 2,
                          ),
                        ),
                        hintText: 'Введите первичный код',
                        hintStyle: TextStyle(
                          color: const Color(0xFFE2E8F0).withOpacity(0.6),
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.key,
                          color: Color(0xFF7FFFD4),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ButtonProverka(
                        title: 'Проверить',
                        nextPage: ThirdPage(code: _nameController.text.trim()),
                        formKey: _formKey,
                          codeController: _nameController
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

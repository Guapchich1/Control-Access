import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/pages/widgets/button_autorization4.dart';
import 'package:flutter_project/pages/vehicle/page_5.dart';
import 'package:flutter_project/pages/widgets/helper/appbar_helper.dart';
import 'package:flutter_project/services/validation_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FourthPage extends StatelessWidget {
  FourthPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Маска для телефона
  final maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Card(
            color: const Color(0xFF2D3748),
            elevation: 10,
            shadowColor: Colors.black.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Имя
                    const Text(
                      'Имя:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF7FFFD4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      validator: ValidationService.validateName,
                      style: const TextStyle(
                        color: Color(0xFF7FFFD4),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: _inputDecoration(
                        hint: 'Введите ваше имя',
                        icon: Icons.person,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Фамилия
                    const Text(
                      'Фамилия:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF7FFFD4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _surnameController,
                      validator: ValidationService.validateName,
                      style: const TextStyle(
                        color: Color(0xFF7FFFD4),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: _inputDecoration(
                        hint: 'Введите вашу фамилию',
                        icon: Icons.badge,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Телефон
                    const Text(
                      'Телефон:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF7FFFD4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [maskFormatter],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите номер телефона';
                        }
                        if (!maskFormatter.isFill()) {
                          return 'Введите полный номер';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Color(0xFF7FFFD4),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: _inputDecoration(
                        hint: '+7 (___) ___-__-__',
                        icon: Icons.phone,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Пароль
                    const Text(
                      'Пароль:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF7FFFD4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      validator: ValidationService.validatePassword,
                      obscureText: true,
                      style: const TextStyle(
                        color: Color(0xFF7FFFD4),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: _inputDecoration(
                        hint: 'Введите пароль',
                        icon: Icons.lock,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Кнопка
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
          ),
        ),
      ),
    );
  }

  // Оформление TextField
  InputDecoration _inputDecoration({required String hint, required IconData icon}) {
    return InputDecoration(
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
      hintText: hint,
      hintStyle: TextStyle(
        color: const Color(0xFFE2E8F0).withOpacity(0.6),
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF7FFFD4),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
    );
  }
}


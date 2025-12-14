import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/pages/widgets/button_autorization4.dart';
import 'package:flutter_project/pages/widgets/helper/appbar_helper.dart';
import 'package:flutter_project/services/validation_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
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

  bool _obscureText = true;

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                      obscureText: _obscureText,
                      style: const TextStyle(
                        color: Color(0xFF7FFFD4),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: _inputDecoration(
                        hint: 'Введите пароль',
                        icon: Icons.lock,
                      ).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xFF7FFFD4),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),

              const SizedBox(height: 24),

                    // Кнопка
                    Center(
                      child: ButtonAutoriz(
                        title: 'Войти',
                        nextPage: const Scaffold(),
                        formKey: _formKey,
                        passwordController: _passwordController,
                        phoneController: _phoneController,
                        nameController: _nameController,
                        surnameController: _surnameController,
                      ),
                    ),
                  ],
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


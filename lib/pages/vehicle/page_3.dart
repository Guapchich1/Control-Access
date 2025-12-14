import 'package:flutter/material.dart';
import 'package:flutter_project/pages/vehicle/vehicle_page.dart';
import 'package:flutter_project/pages/widgets/button_registration3.dart';
import 'package:flutter_project/pages/widgets/helper/appbar_helper.dart';
import 'package:flutter_project/services/validation_service.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key, required this.code});

  final String code;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
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
                        hintText: 'Введите пароль',
                        hintStyle: TextStyle(
                          color: const Color(0xFFE2E8F0).withOpacity(0.6),
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFF7FFFD4),
                        ),

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

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ButtonRegistr(
                        title: 'Завершить регистрацию',
                        nextPage: VehiclePage(),
                        formKey: _formKey,
                        code: widget.code,
                        passwordController: _passwordController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

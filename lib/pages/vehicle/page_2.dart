import 'package:flutter/material.dart';
import 'package:flutter_project/pages/vehicle/page_3.dart';
import 'package:flutter_project/pages/vehicle/vehicle_page.dart';
import 'package:flutter_project/pages/widgets/button_proverka2.dart';
import 'package:flutter_project/services/validation_service.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Контроль доступа',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF7FFFD4)),
        ),
        backgroundColor: const Color(0xFF1A1D23),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => VehiclePage()),
                  (route) => false,
              );
            },
          ),
      ),
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
                obscureText: _obscureText, // <-- используем состояние
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
                  hintText: 'Введите первичный код',
                  hintStyle: TextStyle(
                    color: const Color(0xFFE2E8F0).withOpacity(0.6),
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(
                    Icons.key,
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
                child: ButtonProverka(
                  title: 'Проверить',
                  nextPage: ThirdPage(code: _nameController.text.trim()),
                  formKey: _formKey,
                  codeController: _nameController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


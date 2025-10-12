import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';
import 'package:flutter_project/pages/widgets/helper/bluetooth_connection_mixin.dart';
import 'package:flutter_project/services/ID.dart';

class ButtonAutoriz extends StatelessWidget with BluetoothConnectionMixin {
  final String title;
  final Widget nextPage;
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController nameController;
  final TextEditingController surnameController;

  const ButtonAutoriz({
    super.key,
    required this.title,
    required this.nextPage,
    required this.formKey,
    required this.passwordController,
    required this.phoneController,
    required this.nameController,
    required this.surnameController
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF764ba2), // Фиолетовый
            Color(0xFF6B73FF), // Синий акцент
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B73FF).withOpacity(0.3),
            blurRadius: 9,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            final installId = await getOrCreateInstallId();
            final commandPayload = jsonEncode({
              "action": 'autoriz',
              "install_id": installId,
              "password": passwordController.text.trim(),
              "phone": phoneController.text.trim(),
              "name": nameController.text.trim(),
              "surname": surnameController.text.trim(),
            });
            executeWithConnection(
              context,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Вы успешно авторизовались'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 1),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage),
                );
              },
              command: commandPayload,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(width120, height40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white, // Мятно-зеленый цвет текста
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

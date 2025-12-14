import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';
import 'package:flutter_project/pages/widgets/helper/bluetooth_connection_mixin.dart';
import 'package:flutter_project/services/ID.dart';

class ButtonDoor1 extends StatelessWidget with BluetoothConnectionMixin {
  final String name;
  final String surname;
  final String title;
  const ButtonDoor1({super.key, required this.title, required this.name, required this.surname});

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
          final installId = await getOrCreateInstallId();

          final commandPayload = jsonEncode({
            "action": "Vhod 1 uroven",
            "install_id": installId,
            "name": name,
            "surname": surname
          });

          await checkConnectionAndNotify(
            context,
            commandPayload,
            "Вход в помещение первого уровня доступен",
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(width240, height100),
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

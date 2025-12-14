import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';
import 'package:flutter_project/pages/widgets/helper/bluetooth_connection_mixin.dart';

class ButtonPervVhod extends StatelessWidget with BluetoothConnectionMixin {
  final String title;
  final Widget nextPage;
  const ButtonPervVhod({
    super.key,
    required this.title,
    required this.nextPage,
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            await executeWithConnection(
              context,
                  () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage),
                );
              },
            );
          },
          child: Container(
            width: width240,
            height: height100,
            alignment: Alignment.center,
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
        ),
      ),
    );
  }
}

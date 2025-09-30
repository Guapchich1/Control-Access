import 'package:flutter/material.dart';

AppBar CustomAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: const Text(
      'Контроль доступа',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF7FFFD4)),
    ),
    backgroundColor: const Color(0xFF1A1D23),
    centerTitle: true,
  );
}
import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';

AppBar CustomAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: const Text(
      'Control Access',
      style: TextStyle(fontSize: fontsize18, fontWeight: FontWeight.w500),
    ),
    foregroundColor: Colors.blue.shade600,
    centerTitle: true,
  );
}
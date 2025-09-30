import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/pages/vehicle/vehicle_page.dart';
import 'package:flutter_project/services/permissions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestBluetoothPermissions(); // для разрешений
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // спрятать нижние кнопки
  runApp(const ControlAccessApp());
}

class ControlAccessApp extends StatelessWidget {
  const ControlAccessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: const Color(0xFF1A1D23), // Темный фон
      ),
      title: 'Control Access',
      debugShowCheckedModeBanner: false,
      home: VehiclePage(),
    );
  }
}

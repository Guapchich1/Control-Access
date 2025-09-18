import 'package:flutter/material.dart';
import 'package:flutter_project/Dimensions.dart';
import 'package:flutter_project/Pages/vehicle/Vhod_Page.dart';
import 'package:flutter_project/Pages/vehicle/PervVhod_page.dart';
import 'package:flutter_project/Pages/Widgets/Vhod.dart';
import 'package:flutter_project/Pages/Widgets/Vhod2.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Control Access',
            style: TextStyle(fontSize: fontsize18, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,       // чтобы колонка не растягивалась
            mainAxisAlignment: MainAxisAlignment.center, // центрируем по вертикали
            crossAxisAlignment: CrossAxisAlignment.center, // центрируем по горизонтали
            children: [AutorizButton(title: 'Вход', nextPage: VhodPage()),
              const SizedBox(height: 16), // отступ между кнопкой и текстом
              AutorizButton2(title: 'Первичный вход', nextPage: PervVhodPage())
            ],
          ),
        )
    );
  }
  }

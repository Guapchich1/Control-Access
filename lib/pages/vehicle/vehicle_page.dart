import 'package:flutter/material.dart';
import 'package:flutter_project/dimensions.dart';
import 'package:flutter_project/pages/vehicle/page_2.dart';
import 'package:flutter_project/pages/widgets/button_vhod1.dart';
import 'package:flutter_project/pages/widgets/button_pervvhod1.dart';
import 'package:flutter_project/pages/vehicle/page_4.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          mainAxisSize: MainAxisSize.min, // чтобы колонка не растягивалась
          mainAxisAlignment:
              MainAxisAlignment.center, // центрируем по вертикали
          crossAxisAlignment:
              CrossAxisAlignment.center, // центрируем по горизонтали
          children: [
            ButtonVhod(title: 'Вход', nextPage: FourthPage()),
            const SizedBox(height: 16), // отступ между кнопкой и текстом
            ButtonPervVhod(title: 'Первичный вход', nextPage: SecondPage()),
          ],
        ),
      ),
    );
  }
}

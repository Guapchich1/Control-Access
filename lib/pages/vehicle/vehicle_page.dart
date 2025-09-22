import 'package:flutter/material.dart';
import 'package:flutter_project/pages/vehicle/page_2.dart';
import 'package:flutter_project/pages/widgets/button_vhod1.dart';
import 'package:flutter_project/pages/widgets/button_pervvhod1.dart';
import 'package:flutter_project/pages/vehicle/page_4.dart';
import 'package:flutter_project/pages/widgets/helper/appbar_helper.dart';

class VehiclePage extends StatelessWidget {
  VehiclePage({super.key});
  final fourthPage = FourthPage();
  final secondPage = SecondPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // чтобы колонка не растягивалась
          mainAxisAlignment:
              MainAxisAlignment.center, // центрируем по вертикали
          crossAxisAlignment:
              CrossAxisAlignment.center, // центрируем по горизонтали
          children: [
            ButtonVhod(title: 'Вход', nextPage: FourthPage()),
            const SizedBox(height: 16),
            ButtonPervVhod(title: 'Первичный вход', nextPage: SecondPage()),
          ],
        ),
      ),
    );
  }
}

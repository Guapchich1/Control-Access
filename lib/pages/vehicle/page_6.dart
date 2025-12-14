import 'package:flutter/material.dart';
import 'package:flutter_project/pages/widgets/button_door2.dart';
import 'package:flutter_project/pages/widgets/helper/appbar_helper.dart';
import 'package:flutter_project/pages/widgets/button_door1.dart';

class SixthPage extends StatelessWidget {
  final String name;
  final String surname;
  const SixthPage({super.key, required this.name, required this.surname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: Center(child: Column(
          mainAxisSize: MainAxisSize.min, // чтобы колонка не растягивалась
          mainAxisAlignment:
          MainAxisAlignment.center, // центрируем по вертикали
          crossAxisAlignment:
          CrossAxisAlignment.center, // центрируем по горизонтали
          children: [
          ButtonDoor1(title: 'Вход первого уровня', name: name, surname: surname),
        const SizedBox(height: 24),
        ButtonDoor2(title: 'Вход второго уровня', name: name, surname: surname),
        ],
      ),
      ),
    );
  }
}
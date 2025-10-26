import 'package:flutter/material.dart';
import 'package:flutter_project/pages/widgets/button_door.dart';
import 'package:flutter_project/pages/widgets/helper/appbar_helper.dart';

class SeventhPage extends StatelessWidget {
  const SeventhPage({super.key});

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
          ButtonDoor(title: 'Вход первого уровня'),
          const SizedBox(height: 24),
          ButtonDoor(title: 'Вход второго уровня'),
          const SizedBox(height: 24),
          ButtonDoor(title: 'Вход третьего уровня'),
        ],
      ),
      ),
    );
  }
}
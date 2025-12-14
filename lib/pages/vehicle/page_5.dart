import 'package:flutter/material.dart';
import 'package:flutter_project/pages/widgets/button_door1.dart';
import 'package:flutter_project/pages/widgets/helper/appbar_helper.dart';

class FifthPage extends StatelessWidget {
  final String name;
  final String surname;
  const FifthPage({super.key, required this.name, required this.surname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: Center(child: ButtonDoor1(title: 'Открыть', name: name, surname: surname)),
    );
  }
}

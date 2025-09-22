import 'package:flutter/material.dart';
import 'package:flutter_project/pages/widgets/button_door.dart';
import 'package:flutter_project/pages/widgets/helper/appbar_helper.dart';

class FifthPage extends StatelessWidget {
  const FifthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: Center(child: ButtonDoor(title: 'Открыть')),
    );
  }
}

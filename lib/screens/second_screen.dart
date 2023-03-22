import 'package:flutter/material.dart';

class second_screen extends StatefulWidget {
  const second_screen({Key? key}) : super(key: key);

  @override
  State<second_screen> createState() => _second_screenState();
}

class _second_screenState extends State<second_screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
    );
  }
}

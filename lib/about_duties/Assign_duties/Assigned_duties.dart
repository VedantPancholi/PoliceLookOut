
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class assign_duties extends StatefulWidget {
  const assign_duties({Key? key}) : super(key: key);

  @override
  State<assign_duties> createState() => _assign_dutiesState();
}

class _assign_dutiesState extends State<assign_duties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 2,
        title: const Text(
          "Assign Duties",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade800,
      ),
      body: Center(
        child: Text("Assign Duties"),
      ),
    );
  }
}

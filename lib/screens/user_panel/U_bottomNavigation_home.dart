import 'package:flutter/material.dart';
import 'package:pro/screens/user_panel/u_history.dart';
import 'package:pro/screens/user_panel/u_view_scheduled_duties.dart';
import 'package:pro/widgets/pelatte.dart';

class u_bottomNavigation_home extends StatefulWidget {
  const u_bottomNavigation_home({Key? key}) : super(key: key);

  @override
  State<u_bottomNavigation_home> createState() => u_bottomNavigation_homeState();
}

class u_bottomNavigation_homeState extends State<u_bottomNavigation_home> {
  int _index = 0;
  final screens = [
    u_view_scheduled_duties(),
    u_history(),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        selectedFontSize: 18,
        backgroundColor: kSecondaryColor,
        unselectedItemColor: Colors.cyan,
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind_outlined), label: 'View Duties'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}

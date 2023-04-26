import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro/about_duties/Schedule_duties/schedule_duties.dart';

import '../../widgets/floating_speedDial.dart';
import '../Add_route/Add_route.dart';

class new_schedule_assign_basepage extends StatefulWidget {
  const new_schedule_assign_basepage({Key? key}) : super(key: key);

  @override
  State<new_schedule_assign_basepage> createState() =>
      _new_schedule_assign_basepageState();
}

class _new_schedule_assign_basepageState
    extends State<new_schedule_assign_basepage> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        children: const [
          Positioned(
            bottom: 65.0,
            right: 8.0,
            child: floating_speedDial(),)
        ],
      ),
      body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: Colors.white,
            inactiveColor: Colors.cyan.shade600,
            backgroundColor: Colors.cyan.shade800,
            height: size.height*0.08,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.schedule_rounded,
                ),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.route,
                ),
                label: 'Add Route',
              ),
            ],
          ),
            tabBuilder: (context, index) {
              switch (index) {
                case 0:
                  return CupertinoTabView(
                    builder: (context) {
                      return CupertinoPageScaffold(child: schedule_duties(),);
                    },
                  );
                case 1:
                  return CupertinoTabView(
                    builder: (context) {
                      return CupertinoPageScaffold(child: add_route());
                    },
                  );
              }
              return Container(
                child: const Text("Failed"),
              );
            }
        ),
    );
  }
}
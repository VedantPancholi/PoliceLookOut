import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pro/User/history.dart';
import 'package:pro/map.dart';

import '../User/add_users.dart';
class floating_speedDial extends StatelessWidget {
  const floating_speedDial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      // animatedIcon: AnimatedIcons.home_menu,
        backgroundColor: Colors.black87,
        icon: Icons.home,
        overlayColor: Colors.black87,
        overlayOpacity: 0.4,
        spaceBetweenChildren: 12,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.close),
            onTap: () => Navigator.pop(context),
            label: 'Home',
          ),
          SpeedDialChild(
            child: const Icon(Icons.person_outline_rounded),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return const add_user();
                })),
            label: 'User',
          ),
          SpeedDialChild(
            child: const Icon(Icons.location_on_outlined),
            label: 'Map',
            onTap: () {
              getLiveLocation();
              launchURL();
              // getLiveLocation();
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.history),
            label: 'History',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const history(title: "History");
              }),
            ),
          ),
        ]);
  }
}

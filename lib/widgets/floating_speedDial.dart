import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pro/screens/map_admin.dart';

import '../admin_panel_user/add_users.dart';
import '../admin_panel_user/history.dart';

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
            onTap:() => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return  map_admin();
              }),
            ),
          ),
          SpeedDialChild(
            child: const Icon(Icons.history),
            label: 'History',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return  history();
              }),
            ),
          ),
        ]);
  }
}

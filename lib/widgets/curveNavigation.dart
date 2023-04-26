// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:pro/screens/profileScreen.dart';
// import 'package:pro/screens/first_screen.dart';
// import 'package:pro/sensors.dart';
//
// import '../User/User_home.dart';
//
//
// class curveNavigation extends StatefulWidget {
//   const curveNavigation({Key? key}) : super(key: key);
//
//   @override
//   State<curveNavigation> createState() => _curveNavigationState();
// }
//
// class _curveNavigationState extends State<curveNavigation> {
//   final navigationkey = GlobalKey<CurvedNavigationBarState>();
//   final items = <Widget>[
//     Icon(
//       Icons.home,
//       size: 30,
//     ),
//     Icon(
//       Icons.search,
//       size: 30,
//     ),
//     Icon(
//       Icons.favorite,
//       size: 30,
//     ),
//     Icon(
//       Icons.notifications,
//       size: 30,
//     ),
//     Icon(
//       Icons.location_pin,
//       size: 30,
//     ),
//   ];
//   int index = 0;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(length: 3, child: Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('New Home Page',)),
//         leadingWidth: 45,
//         toolbarHeight: 50,
//         actions: [
//           IconButton(onPressed: (){}, icon: Icon(Icons.search)),
//           IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
//         ],
//         leading: Builder(builder: (context)=>IconButton(onPressed: (){
//           Scaffold.of(context).openDrawer();
//         }, icon: Icon(Icons.menu))),
//         bottom: const TabBar(
//           tabs: [
//             Tab(
//                 icon: Icon(Icons.notifications_active),
//                 child: Text('Notification')),
//             Tab(
//                 icon: Icon(Icons.schedule_outlined),
//                 child: Text('Schedule')),
//             Tab(
//                 icon: Icon(Icons.edit_location_alt_outlined),
//                 child: Text('Add Location')),
//           ],
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             UserAccountsDrawerHeader(
//               accountName: Text(
//                 'Vedant',
//                 style: TextStyle(fontSize: 14.0),
//               ),
//               accountEmail: Text('Vedantpancholi@gmail.com'),
//               currentAccountPicture: CircleAvatar(
//                 child: ClipOval(
//                   child: Image.asset(
//                     'assets/images/logo_of_p_later.jpg',
//                     fit: BoxFit.cover,
//                     width: 90,
//                     height: 90,
//                   ),
//                 ),
//               ),
//               decoration: const BoxDecoration(
//                   color: Colors.black,
//                   image: DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage(
//                         'assets/images/background_navigation_box.jpg'),
//                   )),
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.person_rounded,
//                 color: Colors.black,
//               ),
//               title: const Text(
//                 'Profile',
//                 style: TextStyle(
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (Context) => ProfileScreen()));
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.person_add,
//                 color: Colors.black,
//               ),
//               title: Text(
//                 'Add Users',
//                 style: TextStyle(
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (Context) => Users()));
//               },
//             ),
//             Divider(
//               height: 30.0,
//               color: Colors.black,
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.sensors,
//                 color: Colors.black,
//               ),
//               title: Text(
//                 'Sensors',
//                 style: TextStyle(
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (Context) => Sensor_info()));
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.list,
//                 color: Colors.black,
//               ),
//               title: Text(
//                 'List',
//                 style: TextStyle(
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               onTap: () {
//
//               },
//             ),
//           ],
//         ),
//       ),
//         bottomNavigationBar: Theme(
//           data: Theme.of(context).copyWith(
//             iconTheme: IconThemeData(color: Colors.white, size: 30.0),
//           ),
//           child: CurvedNavigationBar(
//             items: items,
//             height: 50,
//             index: index,
//             onTap: (index) {
//               setState(() {
//                 this.index = index;
//               }
//
//               );
//               if (this.index == 0) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => first_screen()));
//           } else if (this.index == 1) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => second_screen()));
//           } else if (this.index == 2) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => first_screen()));
//           } else if (this.index == 3) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => second_screen()));
//           } else {
//
//           }
//             } ,
//             key: navigationkey,
//             animationCurve: Curves.easeOut,
//             // animationDuration: Duration(microseconds: 450),
//             backgroundColor: Colors.transparent,
//             buttonBackgroundColor: Colors.black,
//             color: Colors.black,
//           ),
//         ),
//         body : TabBarView(
//           children: [
//             //screeens
//             first_screen(),
//             second_screen(),
//           ],
//         )
//     )
//     );
//   }
// }

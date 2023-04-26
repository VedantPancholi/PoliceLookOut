// import 'package:flutter/material.dart';
// import 'manage_user.dart';
// class dy_User_Info extends StatefulWidget {
//   const dy_User_Info({Key? key}) : super(key: key);
//
//   @override
//   State<dy_User_Info> createState() => _dy_User_InfoState();
// }
//
// class _dy_User_InfoState extends State<dy_User_Info> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     String? user_info = ModalRoute.of(context)?.settings.arguments as String?;
//     // String f_name = user_info["F_Name"];
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       appBar: AppBar(
//         backgroundColor: Colors.grey[850],
//         title: Text('User Information'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // Center(
//             //   child: CircleAvatar(
//             //     backgroundImage: AssetImage('assets/images/v_logo.jpg'),
//             //     radius: 40.0,
//             //   ),
//             // ),
//             // Divider(
//             //   height: 90.0,
//             //   color: Colors.grey[700],
//             // ),
//             Text(
//               user_info["F_Name"].toString(),
//               style: TextStyle(
//                 color: Colors.grey[200],
//                 letterSpacing: 2.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Row(
//               children: [
//                 Text(
//                   personal_info1.f_Name ?? "",
//                   style: TextStyle(
//                     color: Colors.amberAccent,
//                     letterSpacing: 2.0,
//                     fontSize: 25.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text("  "),
//                 Text(
//                   personal_info1.l_Name ?? "",
//                   style: const TextStyle(
//                     color: Colors.amberAccent,
//                     letterSpacing: 2.0,
//                     fontSize: 25.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30.0),
//             Text(
//               'Current total users',
//               style: TextStyle(
//                 color: Colors.grey[200],
//                 letterSpacing: 2.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               '7',
//               style: TextStyle(
//                 color: Colors.amberAccent,
//                 letterSpacing: 2.0,
//                 fontSize: 22.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 30.0),
//             Text(
//               'DOB',
//               style: TextStyle(
//                 color: Colors.grey[200],
//                 letterSpacing: 2.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               personal_info1.dOB ?? "",
//               style: const TextStyle(
//                 color: Colors.amberAccent,
//                 letterSpacing: 2.0,
//                 fontSize: 25.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 30.0),
//             Row(
//               children: [
//                 Icon(
//                   Icons.email,
//                   color: Colors.grey[400],
//                 ),
//                 SizedBox(width: 10.0),
//                 TextButton(
//                     onPressed: () {
//                       launch(
//                           'mailto:vedantpancholi0927@gmail.com?subject=FeedBack');
//                     },
//                     child: Text(
//                       personal_info1.email_Id ?? "",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                       ),
//                     )),
//               ],
//             ),
//             SizedBox(height: 30.0),
//             Row(
//               children: [
//                 Icon(
//                   Icons.call,
//                   color: Colors.grey[400],
//                 ),
//                 SizedBox(width: 10.0),
//                 Text(
//                   "+91",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                   ),
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       launch('tel:${personal_info1.contact_No ?? ""}');
//                     },
//                     child: Text(
//                       personal_info1.contact_No ?? "",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                       ),
//                     )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

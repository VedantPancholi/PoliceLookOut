import 'dart:io';
import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pro/User/add_users.dart';
import 'package:pro/User/history.dart';
import 'package:pro/screens/first_screen.dart';
import 'package:pro/screens/profileScreen.dart';
import 'map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final navigationkey = GlobalKey<CurvedNavigationBarState>();
  double value = 0;
  String? data;
  DateTime current_date_time = DateTime.now();
  final now = new DateTime.now();
  String? formatter;
  late bool _isLoading;
  var all_data;
  // final items = <Widget>[
  //   Icon(
  //     Icons.home,
  //     size: 30,
  //   ),
  //   Icon(
  //     Icons.search,
  //     size: 30,
  //   ),
  //   Icon(
  //     Icons.favorite,
  //     size: 30,
  //   ),
  //   Icon(
  //     Icons.notifications,
  //     size: 30,
  //   ),
  //   Icon(
  //     Icons.location_pin,
  //     size: 30,
  //   ),
  // ];
  // int index = 0;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://policelookout.000webhostapp.com/API/login_table_fetch_api.php"));

    if (response.statusCode == 200) {
      data = response.body;
      setState(() {
        all_data = jsonDecode(data!)['Login_Details'];
      });
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan.shade800,
                      Colors.cyan.shade800,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )),
            ),
            SafeArea(
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      DrawerHeader(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                              AssetImage("assets/images/v_logo.jpg"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Vedant Pancholi",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return ProfileScreen();
                                  }));
                                },
                                leading: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  "Profile",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ListTile(
                                onTap: () {},
                                leading: const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  "Settings",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ListTile(
                                onTap: () {},
                                leading: const Icon(
                                  Icons.feedback_outlined,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  "Feedback",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.of(context).pop(true);
                                },
                                leading: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  "Log out",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                )),
            TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: value),
                duration: const Duration(milliseconds: 300),
                builder: (_, double val, __) {
                  return (Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 200 * val)
                      ..rotateY((pi / 6) * val),
                    child: Scaffold(
// extendBodyBehindAppBar: true,
                      backgroundColor: Colors.white,


                      body:  first_screen(),


                      floatingActionButton: SpeedDial(
                        // animatedIcon: AnimatedIcons.home_menu,
                          backgroundColor: Colors.black87,
                          icon: Icons.home,
                          overlayColor: Colors.black87,
                          overlayOpacity: 0.4,
                          spaceBetweenChildren: 12,
                          children: [
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
                          ]),
                    ),
                  ));
                }),
            GestureDetector(
              onHorizontalDragUpdate: (e) {
                if (e.delta.dx > 0) {
                  setState(() {
                    value = 1;
                  });
                } else {
                  setState(() {
                    value = 0;
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Do you want to close the app?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No")),
            TextButton(
                onPressed: () {
                  exit(0);
                },
                child: const Text("Yes")),
          ],
        );
      },
    );
    return exitApp;
  }
}

class CardSkelton extends StatelessWidget {
  const CardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        skelton(
          height: 220,
          width: 390,
        ),
        SizedBox(
          height: 10,
        ),
        skelton(
          height: 220,
          width: 390,
        ),
        SizedBox(
          height: 10,
        ),
        skelton(
          height: 120,
          width: 390,
        ),
      ],
    );
  }
}

class skelton extends StatelessWidget {
  const skelton({Key? key, this.height, this.width}) : super(key: key);
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

//
// ListView.builder(
// shrinkWrap: true,
// physics: const NeverScrollableScrollPhysics(),
// itemCount: all_data == null ? 0 : all_data.length,
// itemBuilder: (context, int index) {
// return Card(
// shadowColor: Colors.grey[600],
// clipBehavior: Clip.antiAlias,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20),
// ),
// child: Stack(
// children: [
// Ink.image(
// image: const AssetImage(
// "assets/images/card_bg_map.jpg"),
// height: 240,
// fit: BoxFit.cover,
// child: InkWell(
// onTap: () {},
// ),
// ),
// Positioned(
// top: 26,
// left: 16,
// child: Row(
// children: [
// const Icon(
// Icons.person_pin,
// size: 30,
// ),
// const SizedBox(
// width: 6,
// ),
// Text(
// jsonDecode(data!)['Login_Details'][index]['F_Name'], style: const TextStyle(color: Colors.black, fontSize: 30), //     jsonDecode(data!)['Login_Details'][index]['F_Name'].toString(),
// ),
// ],
// ),
// ),
// Positioned(
// top: 74,
// left: 36,
// child: Column(
// children: [
// Row(
// children: const [
// Text(
// "Staring Location : ",
// style: TextStyle(
// color: Colors.black,
// fontSize: 20), //     jsonDecode(data!)['Login_Details'][index]['F_Name'].toString(),
// ),
// Text(
// "Star Bajar",
// style: TextStyle(
// color: Colors.black,
// fontSize: 20,
// fontWeight: FontWeight.bold), //     jsonDecode(data!)['Login_Details'][index]['F_Name'].toString(),
// ),
// ],
// ),
// Row(
// children: const [
// Text(
// "Destination Location : ",
// style: TextStyle(
// color: Colors.black,
// fontSize:
// 20), //     jsonDecode(data!)['Login_Details'][index]['F_Name'].toString(),
// ),
// Text(
// "Vastral",
// style: TextStyle(
// color: Colors.black,
// fontSize: 20,
// fontWeight: FontWeight.bold), //     jsonDecode(data!)['Login_Details'][index]['F_Name'].toString(),
// ),
// ],
// ),
// ],
// ),
// ),
// Positioned(
// top: 150,
// left: 100,
// child: Column(
// children: [
// Row(
// children: [
// const Text(
// "Date : ",
// style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
// ),
// Text(
// DateFormat.yMMMMd('en_US').format(now),
// style: const TextStyle(fontSize: 18),
// ),
// ],
// ),
// Row(
// children: [
// const Text(
// "Time : ",
// style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
// ),
// Text(
// DateFormat.jm().format(now),
// style: const TextStyle(fontSize: 18),
// ),
// ],
// ),
// ],
// ),
// ),
// ],
// ),
// );
// }),

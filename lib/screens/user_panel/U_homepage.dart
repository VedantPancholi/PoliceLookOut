import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pro/screens/get_map_location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/onBoarding_screen.dart';
import '../profileScreen.dart';
import 'U_bottomNavigation_home.dart';
import 'package:http/http.dart' as http;


class U_homepage extends StatefulWidget {
  const U_homepage({Key? key}) : super(key: key);

  @override
  State<U_homepage> createState() => _U_homepageState();
}

class _U_homepageState extends State<U_homepage> {
  late bool _isLoading;
  double value = 0;
  String userName = "";

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
    newFieldName();
  }



  newFieldName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString('name')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
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
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage("assets/images/v_logo.jpg"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              userName != null
                                  ? userName
                                  : "null",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
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
                                  Icons.feedback_outlined,
                                  color: Colors.white,
                                ),
                                title: const Text(
                                  "Feedback",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ListTile(
                                onTap: () async{
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.clear();
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => OnboardingScreen()), (Route<dynamic> route) => false);
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
                    child: const Scaffold(
                      // extendBodyBehindAppBar: true,
                      backgroundColor: Colors.white,

                      body: u_bottomNavigation_home(),

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
          backgroundColor: Colors.cyan.shade50,
          content: const Text("Do you want to close the app?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No")),
            TextButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
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

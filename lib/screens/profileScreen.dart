import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../others/user_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String dob = "";
  String userContact = "";
  String userEmail = "";
  String userCardValue = "";

  newFieldName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString('name')!;
      userEmail = sharedPreferences.getString('email')!;
      userContact = sharedPreferences.getString('contactUs')!;
      dob = sharedPreferences.getString('dob')!;
    });
  }

  @override
  void initState() {
    newFieldName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Profile Information'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [

          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Center(
                //   child: CircleAvatar(
                //     backgroundImage: AssetImage('assets/images/v_logo.jpg'),
                //     radius: 40.0,
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/images/profile_icon_lottie.json',
                      height: 175,
                      width: 175,
                    ),
                  ],
                ),
                Divider(
                  height: 90.0,
                  color: Colors.grey[700],
                ),
                Text(
                  'NAME',
                  style: TextStyle(
                    color: Colors.grey[200],
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.amberAccent,
                        letterSpacing: 2.0,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                // Text(
                //   'Current total users',
                //   style: TextStyle(
                //     color: Colors.grey[200],
                //     letterSpacing: 2.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 8.0),
                // Text(
                //   '7',
                //   style: TextStyle(
                //     color: Colors.amberAccent,
                //     letterSpacing: 2.0,
                //     fontSize: 22.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 30.0),
                Text(
                  'DOB',
                  style: TextStyle(
                    color: Colors.grey[200],
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  dob,
                  style: const TextStyle(
                    color: Colors.amberAccent,
                    letterSpacing: 2.0,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 10.0),
                    TextButton(
                        onPressed: () {
                          launch(
                              'mailto:vedantpancholi0927@gmail.com?subject=FeedBack');
                        },
                        child: Text(
                          userEmail,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "+91",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          launch('tel:${personal_info1.contact_No ?? ""}');
                        },
                        child: Text(
                          userContact,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

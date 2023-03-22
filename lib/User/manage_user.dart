import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pro/User/add_users.dart';
import 'package:pro/widgets/floating_speedDial.dart';
import 'package:http/http.dart' as http;

import '../map.dart';
import 'history.dart';

class manage_users extends StatefulWidget {
  const manage_users({Key? key}) : super(key: key);

  @override
  State<manage_users> createState() => _manage_usersState();
}

class _manage_usersState extends State<manage_users> {
  String all_User='';
  var user;
  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(milliseconds: 500));
  }
  Future<void> getUsers()async {
    final url  = Uri.parse("https://policelookout.000webhostapp.com/API/Admin_Show_User_me.php");
    final response = await http.post(url);
    if (response.statusCode == 200) {
      all_User = response.body;
      print(all_User);
      user = jsonDecode(response.body)["Users"];
      print(user[0]);
      }
    }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }
  var count = 7;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        title: const Text(
          "Manage User",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade800,
      ),
      body: LiquidPullToRefresh(
        color: Colors.cyan.shade800,
        onRefresh: _handleRefresh,
        animSpeedFactor: 1.0,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        child: ListView.builder(
            itemCount: count ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        trailing: IconButton(
                          onPressed: () {
                            delete_ShowDialog(context);
                          },
                          icon: Icon(Icons.delete_forever),
                        ),
                        title: Text(
                          "User 1",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          print("only pressed");
                        },
                        onLongPress: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.call,
                                size: 20,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.mail_outline,
                                size: 20,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.read_more_sharp,
                                size: 20,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: Stack(children: [
        Positioned(
          bottom: 15,
          left: 30,
          child: adduser_FloatingActionButton(context),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: floating_speedDial(),
        ),
      ]),
    );
  }

  Future<dynamic> delete_ShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete"),
        content: Text("Do you want to delete this user?"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No")),
          ElevatedButton(onPressed: () {}, child: Text("Yes")),
        ],
        elevation: 24.0,
        backgroundColor: Colors.white,
      ),
    );
  }

  FloatingActionButton adduser_FloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => add_user(),
            ));
      },
      label: Text("Add User"),
      backgroundColor: Colors.cyan.shade800,
      icon: Icon(Icons.person_add),
    );


  }
}



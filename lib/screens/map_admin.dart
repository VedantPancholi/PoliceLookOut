import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import '../widgets/floating_speedDial.dart';
import '../widgets/pelatte.dart';

class map_admin extends StatefulWidget {
  const map_admin({Key? key}) : super(key: key);

  @override
  State<map_admin> createState() => _map_adminState();
}

class _map_adminState extends State<map_admin> {

  List<dynamic> users = [];
  List<dynamic> founduser = [];
  bool isLoading = false;

  String fetch1 = '';
  String fetch2 = '';
  var Deleteduser;

  List<dynamic> forSearchUser = [];

  Future<void> _handleRefresh() async {
    getrecords();
    return await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> deleterecords(email) async {
    final url = Uri.parse(
        "https://policelookout.000webhostapp.com/API/Manage_User.php");
    final response = await http.post(url, body: {"Email_Id": email});
    if (!mounted) {
      return;
    }

    setState(() {

      fetch2 = response.body;
      Deleteduser = jsonDecode(response.body)["Users"];
      // print(fetch2);
      getrecords();
    });
  }

  @override
  initState() {
    super.initState();
    getrecords();
  }

  Future<void> getrecords() async {
    final url = Uri.parse(
        "https://policelookout.000webhostapp.com/API/Admin_Show_User_me.php");
    final response = await http.post(url);
    if (!mounted) {
      return;
    }
    setState(() {

      users = jsonDecode(response.body)["Users"];
      // print(users);
      founduser = users;

    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        title: const Text(
          "View Location",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kSecondaryColor,

      ),
      floatingActionButton: const floating_speedDial(),
      body: LiquidPullToRefresh(
        color: Colors.cyan.shade800,
        onRefresh: _handleRefresh,
        animSpeedFactor: 1.0,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        child: Column(
          children: [
            SizedBox(height: 20,),

            //search button
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val){
                  List<dynamic> results = [];
                  if (val.isEmpty) {
                    setState(() {
                      results = users;
                      founduser = results;
                    });
                    // print(founduser);
                  } else {
                    users.forEach((element) {
                      if (element['F_Name'].toLowerCase().contains(val)) {
                        results.add(element);
                      }
                    });
                    setState(() {
                      founduser = results;
                    });
                    print(founduser);
                  }
                } ,
                decoration: InputDecoration(
                  hintText: 'User name' ,
                  labelText: 'Search' , suffixIcon: Icon(Icons.search,color: kSecondaryColor,),
                  labelStyle: TextStyle(color: kSecondaryColor,fontWeight: FontWeight.bold,fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20,),

            Expanded(
              child: ListView.builder(
                  itemCount: founduser == null ? 0 : founduser.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ListTile(
                            trailing: IconButton(
                              onPressed: () {
                                // load... index wise get_map_location
                              },
                              icon: Icon(Icons.location_history,color: kSecondaryColor,size: 30,),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: kSecondaryColor,
                              child: Text((index+1).toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                              // Text(founduser[index]["F_Name"][0],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                            ),
                            title: Text(
                              "${founduser[index]["F_Name"]} ${founduser[index]["L_Name"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              // print(index);
                              print(founduser[index]['Login_Id']);
                            },
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

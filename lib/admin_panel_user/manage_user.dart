import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:pro/widgets/floating_speedDial.dart';
import 'package:http/http.dart' as http;
import 'package:pro/widgets/pelatte.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_users.dart';

class manage_users extends StatefulWidget {
  const manage_users({Key? key}) : super(key: key);

  @override
  State<manage_users> createState() => _manage_usersState();
}

class _manage_usersState extends State<manage_users> {
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


  // Future<void> getrecords() async {
  //
  //   final url = Uri.parse(
  //       "https://policelookout.000webhostapp.com/API/Admin_Show_User_me.php");
  //   final response = await http.post(url);
  //   if (!mounted) {
  //     return;
  //   }
  //
  //   setState(() {
  //     fetch1 = response.body;
  //     users = jsonDecode(response.body)["Users"];
  //     print(users);
  //
  //
  //      // forSearchUser = users.map((user) {
  //      //   return user['F_Name'] + " " + user['L_Name'];
  //      // }).toList();
  //
  //    // print(forSearchUser);
  //
  //   });
  // }

  // List<Map<dynamic,dynamic>> _foundUsers = [];
  @override
  initState() {
    super.initState();
    getrecords();
  }

  Future<void> getrecords() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        "https://policelookout.000webhostapp.com/API/Admin_Show_User_me.php");
    final response = await http.post(url);
    if (!mounted) {
      return;
    }

    setState(() {
      isLoading = false;
      users = jsonDecode(response.body)["Users"];
      print(users);

      founduser = users;
    });
  }

  // void _runFilter(String enteredKeyword){
  //   List<Map<dynamic,dynamic>> results = [];
  //   if(enteredKeyword.isEmpty){
  //     results = users;
  //   }
  //   else{
  //      users.forEach((element)
  //          {
  //            if (element['F_Name'].toLowerCase().contains(enteredKeyword))
  //              {
  //                results.add(element);
  //              }
  //          });
  //
  //     //  where((element){
  //     //  results += element.toLowerCase().contains("vedant");
  //     //  return results == null ?false:true;
  //     // });
  //   }
  //
  //   setState(() {
  //    _foundUsers = results;
  //    print(_foundUsers);
  //   });
  // }



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
        backgroundColor: kSecondaryColor,
      ),


      body:  LiquidPullToRefresh(
        color: Colors.cyan.shade800,
        onRefresh: _handleRefresh,
        animSpeedFactor: 1.0,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        child: Column(
          children: [
            SizedBox(height: 20,),
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
                     print(founduser);
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
              child: isLoading ? Center(child: CircularProgressIndicator(color:kSecondaryColor)) : ListView.builder(
                  itemCount: founduser == null ? 0 : founduser.length,
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
                                  var email = founduser[index]["Email_Id"].toString();
                                  delete_ShowDialog(context, email);
                                },
                                icon: Icon(Icons.delete_forever),
                              ),
                              title: Text(
                                "${founduser[index]["F_Name"]} ${founduser[index]["L_Name"]}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                print(index);
                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context)=> dy_User_Info(),
                                //   settings: RouteSettings(arguments: _foundUsers["Email_Id"]["F_Name"]["L_Name"]["Card_Value"]["Contact_No"]["DOB"]["Status"]),
                                // )
                                // );
                              },
                              onLongPress: () {},
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      launch(
                                          'tel:${founduser[index]["Contact_No"].toString() ?? ""}');
                                      ;
                                    },
                                    icon: Icon(
                                      Icons.call,
                                      size: 20,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      launch(
                                          'mailto: ${founduser[index]["Email_Id"].toString() ?? ""}');
                                    },
                                    icon: Icon(
                                      Icons.mail_outline,
                                      size: 20,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      print(founduser[index]);
                                      // do as history_showing and pass founduser as object use index to  like above
                                    },
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
          ],
        ),
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

  Future<dynamic> delete_ShowDialog(BuildContext context, var email) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete"),
        content: const Text("Are you sure! do you want to delete this user?"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No")),
          ElevatedButton(
              onPressed: () {
                if (email != null) {
                  deleterecords(email);
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.cyan.shade800,
                      // content: Text(jsonDecode(fetch1)["message"]),
                      content: Text("Successfully deleted"),
                    ),
                  );
                }
              },
              child: Text("Yes")),
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
//
// //to userlist
// class Userlist {
//   int? id;
//   String? f_name;
//   String? l_name;
//
//   Userlist({
//     this.id,
//     this.f_name,
//     this.l_name,
//   });
//
//   Userlist.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     f_name = json['f_name'];
//     l_name = json['l_name'];
//     // email = json['email'];
//     // address =
//     // json['address'] != null ? new Address.fromJson(json['address']) : null;
//     // phone = json['phone'];
//     // website = json['website'];
//     // company =
//     // json['company'] != null ? new Company.fromJson(json['company']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['f_name'] = this.f_name;
//     data['username'] = this.l_name;
//     //   data['email'] = this.email;
//     //   if (this.address != null) {
//     //     data['address'] = this.address?.toJson();
//     //   }
//     //   data['phone'] = this.phone;
//     //   data['website'] = this.website;
//     //   if (this.company != null) {
//     //     data['company'] = this.company?.toJson();
//     //   }
//     //   return data;
//     // }
//   }
// }
//
// class FetchUserList {
//   var data = [];
//   List<Userlist> results = [];
//   String urlList =
//       'https://policelookout.000webhostapp.com/API/Admin_Show_User_me.php';
//
//   Future<List<Userlist>> getuserList({String? query}) async {
//     var url = Uri.parse(urlList);
//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         data = json.decode(response.body);
//         results = data.map((e) => Userlist.fromJson(e)).toList();
//         if (query != null) {
//           results = results
//               .where((element) =>
//                   element.f_name!.toLowerCase().contains((query.toLowerCase())))
//               .toList();
//         }
//       } else {
//         print("fetch error");
//       }
//     } on Exception catch (e) {
//       print('error: $e');
//     }
//     return results;
//   }
// }

import 'dart:convert';
import 'dart:core';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../widgets/pelatte.dart';
bool isLoading = false;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: schedule_duties(),
  ));
}

class schedule_duties extends StatefulWidget {
  const schedule_duties({Key? key}) : super(key: key);

  @override
  State<schedule_duties> createState() => _schedule_dutiesState();
}

class _schedule_dutiesState extends State<schedule_duties> {
  TextEditingController _date = TextEditingController();
  //for userdropdown
  String? _selecteduser;
  String? showusertext = "Select User";
  var msg1;
  List<dynamic> userList = [];

  //for areadropdown
  String? _selectedarea = "1";
  String? showareatext = "Select Area";
  var msg2;
  List<dynamic> areaList = [];
  var jsonResponse;
  String? _selectedroute;
  String? showroutetext = "Select Route";
  var msg3;
  List<dynamic> routeList = [];

  @override
  void initState() {
    print("called init");
    getlist();
    super.initState();
  }

  void getlist() async {
    print("called getlist");
    userList = await getusers();
    areaList = await getarea();
  }

  Future<List<dynamic>> getusers() async {

    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        "https://policelookout.000webhostapp.com/API/Admin_Show_User_me.php");
    final response = await http.post(url);
    if (!mounted) {}

    setState(() {
      isLoading = false;
      msg1 = jsonDecode(response.body)["Users"];
      print(userList);
      print(msg1);
    });
    return msg1;
  }

  Future<List<dynamic>> getarea() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        "https://policelookout.000webhostapp.com/API/Admin_Area_names_ME.php");
    final response = await http.post(url);
    if (!mounted) {}

    setState(() {
      isLoading = false;
      msg2 = jsonDecode(response.body)["Areas"];
      print(areaList);
      print(msg2);
    });
    return msg2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            )
        ),
        toolbarHeight: 60,
        elevation: 3,
        title: const Text(
          "Schedule Duties",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kSecondaryColor,

      ),
      // floatingActionButton: floating_speedDial(),
      body: isLoading ? Center(child: CircularProgressIndicator(color:kSecondaryColor)) : SafeArea(
        child: Form(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  //user dropdown
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField(
                      key: UniqueKey(),
                      hint: Text(showusertext!),
                      items: userList.isNotEmpty
                          ? userList.map((each) {
                              return DropdownMenuItem(
                                key: UniqueKey(),
                                child: Text(each['F_Name']),
                                value: each['Login_Id'],
                                onTap: () {
                                  setState(() {
                                    showusertext = each['F_Name'];
                                  });
                                },
                              );
                            }).toList()
                          : [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(""),
                              )
                            ],
                      onChanged: (val) {
                        _selecteduser = val as String;
                        print("Selected user: ${_selecteduser}");
                        // print(val.runtimeType);
                      },
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: kSecondaryColor,
                      ),
                      // dropdownColor: Colors.cyan.shade50,
                      decoration: InputDecoration(
                        label: Text(
                          "User",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: kSecondaryColor),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  //area dropdown
                  DropdownButtonFormField(
                    key: UniqueKey(),
                    hint: Text(showareatext!),
                    items: areaList.isNotEmpty
                        ? areaList.map((each) {
                            return DropdownMenuItem(
                              key: UniqueKey(),
                              child: Text(each['Area_Name']),
                              value: each['Area_Id'],
                              onTap: () async {
                                setState(() {
                                  showareatext = each['Area_Name'];
                                });
                                final url = Uri.parse(
                                    "https://policelookout.000webhostapp.com/API/Admin_Route_Names_ME.php");
                                final response = await http.post(url,
                                    body: {'Area_Id': each['Area_Id']});
                                // print(response.body);

                                setState(() {
                                  msg3 = jsonDecode(response.body)["Routes"];
                                  routeList.clear();
                                  showroutetext = "Select Route";
                                  routeList = msg3;
                                  print(routeList);
                                });
                              },
                            );
                          }).toList()
                        : [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(""),
                            )
                          ],
                    onChanged: (val) {
                      setState(() {

                        _selectedarea = val as String;
                      });

                      print("Selected area: ${_selectedarea}");

                    },
                    icon: Icon(
                      Icons.arrow_drop_down_circle,
                      color: kSecondaryColor,
                    ),
                    // dropdownColor: Colors.cyan.shade50,
                    decoration: InputDecoration(
                      label: Text(
                        "Area",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: kSecondaryColor),
                      ),
                      prefixIcon: Icon(
                        Icons.maps_home_work,
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  // route dropdown
                  DropdownButtonFormField(
                      key: UniqueKey(),
                      hint: Text(showroutetext!),
                      items: routeList.isNotEmpty
                          ? routeList.map((each) {
                              return DropdownMenuItem(
                                key: UniqueKey(),
                                child: Text(each['Start_Stop_Name'] +
                                    "  -  " +
                                    each['Destination_Stop_Name']),
                                value: each['Route_Id'],
                                onTap: () {
                                  setState(() {
                                    showroutetext = each['Start_Stop_Name'] +
                                        "  -  " +
                                        each['Destination_Stop_Name'];
                                  });
                                },
                              );
                            }).toList()
                          : [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(""),
                              )
                            ],
                      onChanged: (val) {
                        _selectedroute = val as String;
                        print("Selected route: ${_selectedroute}");
                      },
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: kSecondaryColor,
                      ),
                      // dropdownColor: Colors.cyan.shade50,
                      decoration: InputDecoration(
                        label: Text(
                          "Route",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: kSecondaryColor),
                        ),
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: kSecondaryColor,
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  ),

                  //Date picker
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                    child: TextFormField(
                      controller: _date,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: kSecondaryColor,
                          size: 25,
                        ),
                        label: Text(
                          "Select Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: kSecondaryColor),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2030),
                          builder: (BuildContext context, Widget? child){
                            return Theme( data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: kSecondaryColor,
                                onPrimary: Colors.white,
                                surface:Color(0xFFF93822),
                                onSurface: Colors.black,
                              ),
                              dialogBackgroundColor:Colors.white,
                            ), child: child!);
                          },
                        );

                        if (pickeddate != null) {
                          setState(() {
                            _date.text =
                                DateFormat('yyyy-MM-dd').format(pickeddate);
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //Submit button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kSecondaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                // side: BorderSide(color: Colors.red)
                              ))),
                          onPressed: () async{
                            print(_selecteduser);
                            print(_selectedarea);
                            print(_selectedroute);
                            print(_date.text);

                            final url = Uri.parse(
                                "https://policelookout.000webhostapp.com/API/Admin_schedule_duties_ME.php");
                            final response = await http.post(url,body:{
                              'Login_Id':_selecteduser,
                              'Route_Id':_selectedroute,
                              'Reading_Time':_date.text,
                            });
                            print(response.body);


                            if (response.statusCode == 200) {
                              if (jsonDecode(response.body)['error'] == false) {
                                // jsonResponse['message'];
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.black,
                                    // content: Text(jsonDecode(fetch1)["message"]),
                                    content: Text(jsonDecode(response.body)['message'],style: TextStyle(color: Colors.white),),
                                  ),
                                );
                              }
                              else
                              {
                                // jsonResponse['message'];
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.black,
                                    // content: Text(jsonDecode(fetch1)["message"]),
                                    content: Text(jsonDecode(response.body)['message'],style: TextStyle(color: Colors.white),),
                                  ),
                                );
                              }

                            }
                            else
                            {
                              _selectedroute = "";
                              _selecteduser = "";
                              _selectedarea = "";
                              _date.clear();
                            }
                          },
                          child: Text("Schedule".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade50)),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

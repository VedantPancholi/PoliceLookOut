import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/pelatte.dart';

class u_history extends StatefulWidget {
  const u_history({Key? key}) : super(key: key);

  @override
  State<u_history> createState() => _u_historyState();
}

class _u_historyState extends State<u_history> {

  bool isLoading = false;
  bool isLoadingBottom = false;
  String? msg1;
  var msg2;
  String? msg3;
  var msg4;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            )
        ),
        title: Text("history"),
        backgroundColor: kSecondaryColor,
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                //select date
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, top: 20, right: 0, bottom: 2.5),
                  child: TextFormField(
                    controller: _date,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return " *Required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: kSecondaryColor,
                        size: 25,
                      ),
                      label: Text(
                        "Select Date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
                  height: 15,
                ),


                //go button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                        onPressed: () async {
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                          setState(() {
                            isLoading = true;
                          });
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            print(sharedPreferences.getString('email')!);
                             final url = Uri.parse(
                                 "https://policelookout.000webhostapp.com/API/History_me.php");
                             final response = await http.post(url, body: {
                                'Email_Id': sharedPreferences.getString('email')!,
                                'Date': _date.text
                             });

                             setState(() {
                               isLoading = false;
                               msg1 = response.body;
                               msg2 = jsonDecode(response.body);
                               print(response.body);
                             });

                            }
                        },
                        child: Text("Go".toUpperCase(),
                            style: TextStyle(
                                fontSize: 20, color: Colors.grey.shade50)),
                      )),
                ),

                Expanded(
                  child: isLoading ? Center(child: CircularProgressIndicator(color:kSecondaryColor)) : ListView.builder(
                      itemCount: msg2 == null ? 0 : msg2['history'].length,
                      itemBuilder: (context, index) {
                        return msg2['error'] == true
                            ? Text("No duties Found ")
                            : Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              elevation: 4,
                              child: Column(
                                children: [
                                  ListTile(
                                    horizontalTitleGap: 20.0,
                                    leading: CircleAvatar(
                                        backgroundColor: kSecondaryColor,
                                        child: Text(
                                          (index+1).toString(),
                                          style: TextStyle(
                                              color: Colors.white),
                                        )),
                                    trailing: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: kSecondaryColor,
                                    ),
                                    title: Text("Date : ${DateFormat("yyyy-mm-dd").format(DateTime.parse(msg2['history'][index]['Reading_Time']))}"),

                                    subtitle: Text("Schedule Duty : "+(index+1).toString()),
                                    onTap: () async {
                                      if(!isLoadingBottom){
                                        setState(() {
                                          isLoadingBottom = true;
                                        });
                                        final url1 = Uri.parse(
                                            "https://policelookout.000webhostapp.com/API/Route_Stopfetching_me.php");
                                        final response1 = await http.post(url1, body: {
                                          'Route_Id': msg2['history'][index]['Route_Id'],
                                        });

                                        setState(() {
                                          msg3 = response1.body;
                                          msg4 = jsonDecode(response1.body);
                                        });

                                        print(msg4);
                                        print(msg4['Route_info']['Start_Stop_Name']);

                                        print(msg4['Stop_Nodes'][0]['Stop_Name']);

                                        print("-------------");
                                        if(msg4['error'] == false)
                                        {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  height: size.height / 2.5,
                                                  color: Colors.cyan.shade50.withOpacity(0.2),
                                                  child:Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                                                        child: Text(
                                                          "Starting Location : ${msg4['Route_info']['Start_Stop_Name']}",style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: kSecondaryColor,
                                                        ),),
                                                      ),
                                                      Expanded(
                                                        child: ListView.builder(
                                                            itemCount : msg4['Stop_Nodes'].length,
                                                            itemBuilder: (context,index){
                                                              return ListTile(
                                                                leading: CircleAvatar(
                                                                  backgroundColor: kSecondaryColor,
                                                                  child: Text((index+1).toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                                title: Text("Stop location : ${msg4['Stop_Nodes'][index]['Stop_Name']}"),
                                                              );

                                                              // Text("Stop index :${msg4['Stop_Nodes'][index]['Stop_Name']}");
                                                            }),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                                                        child: Text(
                                                          "Destination Location : ${msg4['Route_info']['Destination_Stop_Name']}",style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: kSecondaryColor,
                                                        ),),
                                                      ),
                                                      // ListTile(
                                                      //   leading: new Icon(Icons.photo),
                                                      //   title: new Text('Photo'),
                                                      //   onTap: () {
                                                      //     Navigator.pop(context);
                                                      //   },
                                                      // ),

                                                    ],
                                                  ),
                                                );
                                              });
                                         await Future.delayed(const Duration(seconds: 3)).then((value) => isLoadingBottom = false);
                                        }
                                      }

                                    },
                                  ),
                                ],
                              ),
                            );
                      }),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

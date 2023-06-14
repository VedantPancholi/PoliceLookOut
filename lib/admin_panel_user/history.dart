import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pro/screens/expandable.dart';
import 'package:rive/rive.dart';
import '../widgets/floating_speedDial.dart';
import '../widgets/pelatte.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  String? msg1;
  var msg2;
  String? msg3;
  var msg4;
  bool isLoading = false;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _date = TextEditingController();
  TextEditingController _email = TextEditingController();

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
      floatingActionButton: floating_speedDial(),
      body: Stack(
        children: [
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: const SizedBox(),
              )),
          SafeArea(
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
                    e_mailTextfields3(_email),

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
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();

                                setState(() {
                                  isLoading = true;
                                });

                                final url = Uri.parse(
                                    "https://policelookout.000webhostapp.com/API/History_me.php");
                                final response = await http.post(url, body: {
                                  'Email_Id': _email.text,
                                  'Date': _date.text
                                });

                                setState(() {
                                  isLoading = false;
                                  msg1 = response.body;
                                  msg2 = jsonDecode(response.body);
                                });
                                print(response.body);
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
                                  borderRadius:
                                  BorderRadius.circular(20.0)),
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
                                    title: Text(
                                        "Date : ${DateFormat("yyyy-mm-dd").format(DateTime.parse(msg2['history'][index]['Reading_Time']))}"),
                                    subtitle: Text("Schedule Duty : "+(index+1).toString()),
                                    onTap: () async {

                                      final url1 = Uri.parse(
                                          "https://policelookout.000webhostapp.com/API/Route_Stopfetching_me.php");
                                      final response1 =
                                      await http.post(url1, body: {
                                        'Route_Id': msg2['history'][index]
                                        ['Route_Id'],
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
                                                child: Column(
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
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    // Expanded(
                    //   child: isLoading ? Center(child: CircularProgressIndicator(color:kSecondaryColor)) : ListView.builder(
                    //       itemCount: msg2 == null ? 0 : msg2['history'].length,
                    //       itemBuilder: (contex, index) {
                    //         return msg2['error'] == true
                    //             ? Column(
                    //           // mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Text("No duties Found ",style: TextStyle(fontSize: 30,color: kSecondaryColor,fontWeight: FontWeight.bold),),
                    //               ],
                    //             )
                    //             : Column(
                    //               children: [
                    //                 Card(
                    //                   shape: RoundedRectangleBorder(
                    //                               borderRadius:
                    //                               BorderRadius.circular(20.0)),
                    //                           elevation: 4,
                    //
                    //                   child: ExpandableNotifier(
                    //                       initialExpanded: false,
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.only(bottom: 0),
                    //                         child: Container(
                    //                           child: Column(
                    //                             children: <Widget>[
                    //                               ScrollOnExpand(
                    //                                 scrollOnExpand: true,
                    //                                 scrollOnCollapse: false,
                    //                                 child: ExpandablePanel(
                    //                                   theme:  ExpandableThemeData(
                    //                                       headerAlignment: ExpandablePanelHeaderAlignment.center,
                    //                                       tapBodyToCollapse: false,
                    //                                       iconColor: kSecondaryColor,
                    //                                       iconSize: 30,
                    //                                   ),
                    //                                   header: Padding(
                    //                                       padding: EdgeInsets.only(right: 16.0,top: 16,bottom: 16),
                    //                                       child: ListTile(
                    //                                         horizontalTitleGap: 10.0,
                    //                                         leading: CircleAvatar(
                    //                                             backgroundColor: kSecondaryColor,
                    //                                             child: Text(
                    //                                               "$index",
                    //                                               style: TextStyle(
                    //                                                   color: Colors.white),
                    //                                             )),
                    //
                    //                                         title: Text("Schedule Duty : $index"),
                    //                                         subtitle: Text(
                    //                                             "Schedule Time :${msg2['history'][index]['Reading_Time']}"),
                    //                                         onTap: () async {
                    //
                    //                                           final url1 = Uri.parse(
                    //                                               "https://policelookout.000webhostapp.com/API/Route_Stopfetching_me.php");
                    //                                           final response1 =
                    //                                           await http.post(url1, body: {
                    //                                             'Route_Id': msg2['history'][index]['Route_Id'],
                    //                                           });
                    //                                           print("-------------");
                    //                                           setState(() {
                    //                                             msg3 = response1.body;
                    //                                             msg4 = jsonDecode(response1.body);
                    //                                             print(msg3);
                    //
                    //
                    //
                    //                                             if(msg4['error'] == false)
                    //                                             {
                    //                                               showModalBottomSheet(
                    //                                                   context: context,
                    //                                                   builder: (context) {
                    //                                                     return Column(
                    //                                                       mainAxisSize: MainAxisSize.min,
                    //                                                       children: <Widget>[
                    //                                                         Text(
                    //                                                             "Starting Location :${msg4['Route_info']['Start_Stop_Name']}"),
                    //                                                         Expanded(
                    //                                                           child: ListView.builder(
                    //                                                             itemCount : msg4['Stop_Nodes'].length,
                    //                                                               itemBuilder: (context,index){
                    //                                                             return Text("Stop index :${msg4['Stop_Nodes'][index]['Stop_Name']}");
                    //                                                           }),
                    //                                                         ),
                    //                                                         Text(
                    //                                                             "Destination Location :${msg4['Route_info']['Destiantion_Stop_Name']}"),
                    //                                                         ListTile(
                    //                                                           leading: new Icon(Icons.photo),
                    //                                                           title: new Text('Photo'),
                    //                                                           onTap: () {
                    //                                                             Navigator.pop(context);
                    //                                                           },
                    //                                                         ),
                    //
                    //                                                       ],
                    //                                                     );
                    //                                                   });
                    //                                             }
                    //
                    //                                           });
                    //
                    //                                         },
                    //                                       ),),
                    //                                   collapsed: Container(),
                    //                                   expanded: Column(
                    //                                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                                     children: <Widget>[
                    //                                       Text(
                    //                                           "Schedule Time :${msg2['history'][index]['Reading_Time']}"),
                    //                                       SizedBox(height: 20,)
                    //                                     ],
                    //                                   ),
                    //                                   builder: (_, collapsed, expanded) {
                    //                                     return Padding(
                    //                                       padding: EdgeInsets.only(left: 10, right: 10),
                    //                                       child: Expandable(
                    //                                         collapsed: collapsed,
                    //                                         expanded: expanded,
                    //                                         theme: const ExpandableThemeData(crossFadePoint: 0),
                    //                                       ),
                    //                                     );
                    //                                   },
                    //                                 ),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       )),
                    //                 ),
                    //         //         Container(
                    //         //   height: size.height * 0.15,
                    //         //   child: Card(
                    //         //         shape: RoundedRectangleBorder(
                    //         //             borderRadius:
                    //         //             BorderRadius.circular(20.0)),
                    //         //         elevation: 4,
                    //         //         child: Column(
                    //         //           children: [
                    //         //             ListTile(
                    //         //               horizontalTitleGap: 20.0,
                    //         //               leading: CircleAvatar(
                    //         //                   backgroundColor: kSecondaryColor,
                    //         //                   child: Text(
                    //         //                     "$index",
                    //         //                     style: TextStyle(
                    //         //                         color: Colors.white),
                    //         //                   )),
                    //         //               trailing: Icon(
                    //         //                 Icons.arrow_forward_ios_outlined,
                    //         //                 color: kSecondaryColor,
                    //         //               ),
                    //         //               title: Text("Schedule Duty : $index"),
                    //         //               subtitle: Text(
                    //         //                   "Schedule Time :${msg2['history'][index]['Reading_Time']}"),
                    //         //               onTap: () async {
                    //         //                 final url1 = Uri.parse(
                    //         //                     "https://policelookout.000webhostapp.com/API/Route_Stopfetching_me.php");
                    //         //                 final response1 =
                    //         //                 await http.post(url1, body: {
                    //         //                   'Route_Id': msg2['history'][index]
                    //         //                   ['Route_Id'],
                    //         //                 });
                    //         //
                    //         //                 setState(() {
                    //         //                   msg3 = response1.body;
                    //         //                   msg4 = jsonDecode(response1.body);
                    //         //                 });
                    //         //
                    //         //                 print(msg4);
                    //         //                 print(msg4['Route_info']
                    //         //                 ['Start_Stop_Name']);
                    //         //
                    //         //                 print(msg4['Stop_Nodes'][0]
                    //         //                 ['Stop_Name']);
                    //         //
                    //         //                 print("-------------");
                    //         //               },
                    //         //             ),
                    //         //           ],
                    //         //         ),
                    //         //   ),
                    //         // ),
                    //               ],
                    //             );
                    //       }),
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 20.0),
                    //   child: SizedBox(
                    //       width: double.infinity,
                    //       height: 50.0,
                    //       child: ElevatedButton(
                    //         style: ButtonStyle(
                    //           // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    //             backgroundColor: MaterialStateProperty.all<Color>(
                    //                 kSecondaryColor),
                    //             shape: MaterialStateProperty.all<
                    //                 RoundedRectangleBorder>(
                    //                 RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(16.0),
                    //                   // side: BorderSide(color: Colors.red)
                    //                 ))),
                    //         onPressed: () async {
                    //           if (formkey.currentState!.validate()) {
                    //             formkey.currentState!.save();
                    //             var body = {
                    //               'Email_Id':_email.text,
                    //               'Date': _date.text
                    //             };
                    //
                    //             final url = Uri.parse(
                    //                 "https://policelookout.000webhostapp.com/API/History_me.php");
                    //             final response = await http.post(url,body: body);
                    //             msg1 = response.body;
                    //             msg2 = jsonDecode(response.body)["history"];
                    //
                    //             print(msg1);
                    //             print("------");
                    //             print(msg2);
                    //             print(msg2.runtimeType);
                    //             print(msg2.isEmpty);
                    //             print(msg2 == null?"true":"false");
                    //             print(msg2.length);
                    //             print("------");
                    //           }
                    //         },
                    //         child: Text("Go".toUpperCase(),
                    //             style: TextStyle(
                    //                 fontSize: 20, color: Colors.grey.shade50)),
                    //       )),
                    // ),

                    // Flexible(
                    //   child: ListView.builder(
                    //       itemCount: msg2 == null ? 0 : msg2.length,
                    //       itemBuilder: (context , index )
                    //   {
                    //     return ListTile(title: Text("ok"),);
                    //   }) ,
                    //
                    //
                    //   // ListView.builder(
                    //   //     itemCount: msg2 != null ? msg2.length:0,
                    //   //     itemBuilder: (context, index){
                    //   //   return ListTile(
                    //   //     title: Text("Schedule Duty : $index"),
                    //   //     subtitle: Text("Schedule Time :${msg2[index]['Reading_Time']}"),
                    //   //     onTap: ()async{
                    //   //       final url1 = Uri.parse(
                    //   //           "https://policelookout.000webhostapp.com/API/Route_Stopfetching_me.php");
                    //   //       final response1 = await http.post(url1,body: {'Route_Id':msg2[index]['Route_Id']});
                    //   //       msg3 = response1.body;
                    //   //       msg4 = jsonDecode(response1.body)['Route_info'];
                    //   //
                    //   //       print("------");
                    //   //
                    //   //       print(msg4['Start_Stop_Name']);
                    //   //       print(msg4['Destiantion_Stop_Name']);
                    //   //
                    //   //     },
                    //   //   );
                    //   // }),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget e_mailTextfields3(TextEditingController _email) => TextFormField(
      controller: _email,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kSecondaryColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        // enabledBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: kSecondaryColor)),
        prefixIcon: Icon(
          Icons.email_outlined,
          color: kSecondaryColor,
          size: 22,
        ),
        label: Text("E-mail"),
        labelStyle:
            TextStyle(color: kSecondaryColor, fontWeight: FontWeight.bold),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty ||
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,5}$').hasMatch(value)) {
          return "Enter correct e-mail";
        } else {
          return null;
        }
      },
    );

// class history_showing extends StatefulWidget {
//   var msg4;
//
//
//   history_showing({this.msg4});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _history_showing_State(msg4: msg4,msg5: msg5);
//   }
// }
//
// class _history_showing_State extends State<history_showing> {
//   var msg4;
//   var msg5;
//   _history_showing_State({this.msg4,this.msg5});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kSecondaryColor,
//         title: Text("Route Information"),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(" Starting Location :   ${msg4['Start_Stop_Name']}"),
//             Text(" Destination Location :   ${msg4['Destiantion_Stop_Name']}"),
//
//             // Text(msg4['Stop_Name']),
//             // Text(msg4['Stop_Name']),
//           ],
//         ),
//       ),
//     );
//   }
// }

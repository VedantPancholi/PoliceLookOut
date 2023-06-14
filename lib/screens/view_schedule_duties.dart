import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';


import '../widgets/pelatte.dart';


class view_schedule_duties extends StatefulWidget {
  String login;
  String Card_Value;
  view_schedule_duties({Key? key,required this.login,required this.Card_Value}) : super(key: key);

  @override
  State<view_schedule_duties> createState() => _view_schedule_dutiesState(login:login,Card_Value: Card_Value);
}

class _view_schedule_dutiesState extends State<view_schedule_duties> {
  String login;
  String Card_Value;

   _view_schedule_dutiesState({required this.login, required this.Card_Value});
  var msg1 = [];
  var checkerror;
  var msg2;
  String? msg3;
  var msg4;
  bool isLoading = false;


  @override
  void initState() {
    print("init called of schedule");
    getrecords();
    super.initState();
  }

  Future<void> _handleRefresh() async {
    getrecords();
    return await Future.delayed(const Duration(milliseconds: 500));
  }


  Future<void> getrecords() async{
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse("https://policelookout.000webhostapp.com/API/User_Admin_schedulefetching_me.php");
    final response = await http.post(url,body:{'Login_Id': login});
    print(response.body);
    setState(() {
      isLoading = false;
      msg1 = jsonDecode(response.body)['Schedule Duties'];
      checkerror = jsonDecode(response.body);
      // print(msg1);
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       bottom: Radius.circular(40),
        //     )
        // ),
        title: Text("View Duties"),

        backgroundColor: kSecondaryColor,
      ),
      body: LiquidPullToRefresh(
        color: Colors.cyan.shade800,
        onRefresh: _handleRefresh,
        animSpeedFactor: 1.0,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20.0),
              child: isLoading ? Center(child: CircularProgressIndicator(color:kSecondaryColor)) : ListView.builder(
                  itemCount: msg1.length,
                  itemBuilder: (context,index) {
                    return checkerror['error'] == true?
                    Center(child: Text("NO Duties Found")):
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20.0)),
                      elevation: 4,
                      child: ListTile(
                        leading : CircleAvatar(
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
                        title: Text("Date : ${DateFormat("yyyy-mm-dd").format(DateTime.parse(msg1[index]['Reading_Time']))}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("Starting Stop Name : "+msg1[index]['Route_info']['Start_Stop_Name']),
                            Text("Ending Stop Name : "+msg1[index]['Route_info']['Destination_Stop_Name']),
                          ],
                        ),
                        onTap: () async{
                          print(index);
                          print(msg1[index]['Route_Id']);
                          print(msg1[index]['Reading_Time'].runtimeType);


                          final nodechecking_Url = Uri.parse("https://policelookout.000webhostapp.com/API/Node_Checking_me.php");
                          final nodechecking_response = await http.post(nodechecking_Url,body: {
                            'Card_Value': Card_Value,
                            'Route_id': msg1[index]['Route_Id']
                          });

                          List<dynamic> nodecheck = jsonDecode(nodechecking_response.body)['Schedule Duties'];
                          if (nodecheck[0]['Route_id'] == null)
                            {
                              nodecheck.clear();
                            }

                          final url1 = Uri.parse(
                              "https://policelookout.000webhostapp.com/API/Route_Stopfetching_me.php");
                          final response1 =
                          await http.post(url1, body: {
                            'Route_Id': msg1[index]['Route_Id'],
                          });

                          setState(() {
                            // msg3 = response1.body;
                            msg4 = jsonDecode(response1.body);
                          });
                          // print(msg4);
                          // print(msg4['Route_info']['Start_Stop_Name']);
                          //
                          // print(msg4['Stop_Nodes'][0]['Stop_Name']);

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
                                                    backgroundColor: index <nodecheck.length? Colors.transparent : kSecondaryColor,
                                                    child: index <nodecheck.length? Lottie.asset('assets/images/done_animation.json',width: size.width*0.20,height: size.height*0.20,fit: BoxFit.fill) :Text((index+1).toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
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
                                      ],
                                    ),
                                  );



                                  //   Container(
                                  //   width: size.width,
                                  //   height: size.height*0.3,
                                  //   decoration: BoxDecoration(
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color: Colors.black.withOpacity(0.4),
                                  //         blurRadius: 40
                                  //       )
                                  //     ],
                                  //     gradient: LinearGradient(colors: [
                                  //       Colors.cyan.shade900,
                                  //       Colors.cyan.shade600,
                                  //     ])
                                  //   ),
                                  //   child: Column(
                                  //     mainAxisSize: MainAxisSize.min,
                                  //     children: <Widget>[
                                  //       Text(
                                  //           "Starting Location :${msg4['Route_info']['Start_Stop_Name']}"),
                                  //       Expanded(
                                  //         child: ListView.builder(
                                  //             itemCount : msg4['Stop_Nodes'].length,
                                  //             itemBuilder: (context,index){
                                  //               return Text("Stop index :${msg4['Stop_Nodes'][index]['Stop_Name']}");
                                  //             }),
                                  //       ),
                                  //       Text(
                                  //           "Destination Location :${msg4['Route_info']['Destination_Stop_Name']}"),
                                  //       ListTile(
                                  //         leading: new Icon(Icons.photo),
                                  //         title: new Text('Photo'),
                                  //         onTap: () {
                                  //           Navigator.pop(context);
                                  //         },
                                  //       ),
                                  //
                                  //     ],
                                  //   ),
                                  // );
                                });
                          }

                        },
                      ),
                    );
                  }),
            )
        ),
      ),
    );
  }
}
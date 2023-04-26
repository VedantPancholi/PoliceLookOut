import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/pelatte.dart';
import '../get_map_location.dart';

class u_view_scheduled_duties extends StatefulWidget {
  const u_view_scheduled_duties({Key? key}) : super(key: key);

  @override
  State<u_view_scheduled_duties> createState() => _u_view_scheduled_dutiesState();
}

class _u_view_scheduled_dutiesState extends State<u_view_scheduled_duties> {
  List<dynamic> msg1 = [];
  var msg2;
  String? msg3;
  var msg4;

  @override
  void initState() {
    getrecords();
    print("init called of schedule");
    sendLocation();
    super.initState();
  }

  void sendLocation() async {

    Position? pos =  await getLiveLocation();
    print(pos!.latitude);
    print(pos.longitude);
    final url =  Uri.parse('https://policelookout.000webhostapp.com/API/User_location_ME.php');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final res =  await http.post(url,body: {
      'Login_Id': sharedPreferences.getString('id')!,
      'Latitude': pos.latitude.toString(),
      'Longitude':pos.longitude.toString(),
    });
    print(res.body);

  }


  Future<void> getrecords()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url = Uri.parse("https://policelookout.000webhostapp.com/API/User_Admin_schedulefetching_me.php");
    final response = await http.post(url,body:{'Login_Id': sharedPreferences.getString('id')!});
    setState(() {
      msg1 = jsonDecode(response.body)['Schedule Duties'];
      print(msg1);
    });
  }

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
        title: Text("View Duties"),

        backgroundColor: kSecondaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20.0),
          child: ListView.builder(
              itemCount: msg1.length,
              itemBuilder: (context,index) {
            return Card(
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
                    Text("Starting Stop Name : "+msg1[index]['Route_info']['Start_Stop_Name']),
                    Text("Ending Stop Name : "+msg1[index]['Route_info']['Destiantion_Stop_Name']),
                  ],
                ),
                onTap: () async{
                  print(index);
                  print(msg1[index]['Reading_Time'].runtimeType);

                    final url1 = Uri.parse(
                        "https://policelookout.000webhostapp.com/API/Route_Stopfetching_me.php");
                    final response1 =
                        await http.post(url1, body: {
                      'Route_Id': msg1[index]['Route_Id'],
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
                              width: size.width,
                              height: size.height*0.3,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 40
                                  )
                                ],
                                gradient: LinearGradient(colors: [
                                  Colors.cyan.shade900,
                                  Colors.cyan.shade600,
                                ])
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                      "Starting Location :${msg4['Route_info']['Start_Stop_Name']}"),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount : msg4['Stop_Nodes'].length,
                                        itemBuilder: (context,index){
                                          return Text("Stop index :${msg4['Stop_Nodes'][index]['Stop_Name']}");
                                        }),
                                  ),
                                  Text(
                                      "Destination Location :${msg4['Route_info']['Destiantion_Stop_Name']}"),
                                  ListTile(
                                    leading: new Icon(Icons.photo),
                                    title: new Text('Photo'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),

                                ],
                              ),
                            );
                          });
                    }

                },
              ),
            );
          }),
        )
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/pelatte.dart';

class schedule_duties extends StatefulWidget {
  const schedule_duties({Key? key}) : super(key: key);

  @override
  State<schedule_duties> createState() => _schedule_dutiesState();
}

class _schedule_dutiesState extends State<schedule_duties>  {
  _schedule_dutiesState() {
    _selectedValUser = _userNameList[0];
    _selectedValArea = _areaNameList[0];
    _selectedValRoute = _routeNameList[0];
  }

  final _userNameList = ["Vedant", "Maharshi", "Jesal", "Parva"];
  final _areaNameList = [
    "SG Highway",
    "Science City Road",
    "Satellite",
    "Panjrapol"
  ];
  final _routeNameList = [
    "SG Highway",
    "Science City Road",
    "Satellite",
    "Panjrapol"
  ];
  String? _selectedValUser = "";
  String? _selectedValArea = "";
  String? _selectedValRoute = "";

  TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 2,
        title: const Text(
          "Schedule Duties",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kSecondaryColor,
      ),
      body: SafeArea(
          child: Column(
        children: [

          //User Dropdown
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: DropdownButtonFormField(
              value: _selectedValUser,
              items: _userNameList
                  .map(
                      // creating function which receive values
                      (item1) => DropdownMenuItem(
                            value: item1,
                            child: Text(item1),
                          ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedValUser = val as String;
                });
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
                  Icons.perm_identity,
                  color: kSecondaryColor,
                ),
              ),
            ),
          ),


          //Area Dropdown
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: DropdownButtonFormField(
              value: _selectedValArea!.isNotEmpty ? _selectedValArea : null,
              items: _areaNameList
                  .map(
                      // creating function which receive values
                      (item2) => DropdownMenuItem(
                            value: item2,
                            child: Text(item2),
                          ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedValArea = val as String;
                });
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
                  Icons.location_on_outlined,
                  color: kSecondaryColor,
                ),
              ),
            ),
          ),


          //Route Dropdown
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: DropdownButtonFormField(
              value: _selectedValRoute,
              items: _routeNameList
                  .map(
                      // creating function which receive values
                      (item3) => DropdownMenuItem(
                            value: item3,
                            child: Text(item3),
                          ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedValRoute = val as String;
                });
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
                  Icons.route,
                  color: kSecondaryColor,
                ),
              ),
            ),
          ),


          //Date picker
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
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
                    lastDate: DateTime(2030));

                if (pickeddate != null) {
                  setState(() {
                    _date.text = DateFormat('yyyy-MMM-dd').format(pickeddate);
                  });
                }
              },
            ),
          ),
          SizedBox(height: 30,),


          //Submit button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
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
                  onPressed: () {
                  },
                  child: Text("Schedule".toUpperCase(),
                      style: TextStyle(fontSize: 20,color: Colors.grey.shade50)),
                )),
          ),
        ],
      )),
    );
  }
}

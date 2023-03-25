import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro/widgets/pelatte.dart';

class assign_duties extends StatefulWidget {
  const assign_duties({Key? key}) : super(key: key);

  @override
  State<assign_duties> createState() => _assign_dutiesState();
}

class _assign_dutiesState extends State<assign_duties> {

  _assign_dutiesState(){
    _selectedValRoute = _routeNameList[0];
  }
  final _routeNameList = [
    "SG Highway",
    "Science City Road",
    "Satellite",
    "Panjrapol"
  ];
  String? _selectedValRoute = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 2,
          title: const Text(
            "Assign Duties",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan.shade800,
        ),
        body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: DropdownButtonFormField(
                    value: _selectedValRoute!.isNotEmpty ? _selectedValRoute : null,
                    items: _routeNameList
                        .map(
                            // creating function which receive values
                            (item1) => DropdownMenuItem(
                                  value: item1,
                                  child: Text(item1),
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
                        Icons.location_on_outlined,
                        color: kSecondaryColor,
                      ),
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Expanded(

                          child: f_name_TextFormField()),
                      SizedBox(width: 8.0,),
                      Expanded(

                          child: l_name_TextFormField()),
                    ],
                  ),
                ),

                //Submit button
                assign_btn(),
              ],
            )));
  }
}


Widget f_name_TextFormField() => TextFormField(
  showCursor: true,
  decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryColor,),
      borderRadius: BorderRadius.circular(20.0),
    ),

    // enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: kSecondaryColor)),
    prefixIcon: Icon(
      Icons.person_rounded,
      color: kSecondaryColor,
      size: 22,
    ),
    // label: Text("First Name"),
    // hintStyle: TextStyle(color: kSecondaryColor),
    labelText: "First Name",
    labelStyle: TextStyle(color: kSecondaryColor,fontSize: 18,fontWeight: FontWeight.bold),
  ),
  textInputAction: TextInputAction.next,
);


Widget l_name_TextFormField() => TextFormField(
  showCursor: true,
  decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryColor,),
      borderRadius: BorderRadius.circular(20.0),
    ),

    // enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: kSecondaryColor)),
    prefixIcon: Icon(
      Icons.person_rounded,
      color: kSecondaryColor,
      size: 22,
    ),
    labelText: "Last Name",
    labelStyle: TextStyle(color: kSecondaryColor,fontSize: 18,fontWeight: FontWeight.bold),
  ),
  textInputAction: TextInputAction.next,
);

Widget assign_btn() => Padding(
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
        child: Text("Assign".toUpperCase(),
            style: TextStyle(fontSize: 20,color: Colors.grey.shade50)),
      )),
);
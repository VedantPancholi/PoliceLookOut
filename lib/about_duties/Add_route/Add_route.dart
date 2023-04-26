import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pro/widgets/pelatte.dart';
import 'package:http/http.dart' as http;

import '../../screens/homepage.dart';

class add_route extends StatefulWidget {
  const add_route({Key? key}) : super(key: key);

  @override
  State<add_route> createState() => _add_routeState();
}

class _add_routeState extends State<add_route> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _routeName = TextEditingController();
  TextEditingController _areaName = TextEditingController();
  int _textfieldnumber = 1 ;
  List<TextEditingController> _formfields = [];
  int nos = 0;

  //final List<TextEditingController> _stop_route_name  = [];
  //
  // _addField(){
  //   setState(() {
  //     _stop_route_name.add(TextEditingController());
  //   });
  // }
  //
  // _removeField(i){
  //   setState(() {
  //     _stop_route_name.removeAt(i);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) { _addField();});
  }
  final _routeNameList = [
    "SG Highway",
    "Science City Road",
    "Satellite",
    "Panjrapol"
  ];
  // String? _selectedValRoute = "";
  // double _currentValueSlider = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(



        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              )
          ),
          title: const Text(
            "Add Route",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan.shade800,
        ),
        body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                      //   child: DropdownButtonFormField(
                      //     value: _selectedValRoute!.isNotEmpty ? _selectedValRoute : null,
                      //     items: _routeNameList
                      //         .map(
                      //             // creating function which receive values
                      //             (item1) => DropdownMenuItem(
                      //                   value: item1,
                      //                   child: Text(item1),
                      //                 ))
                      //         .toList(),
                      //     onChanged: (val) {
                      //       setState(() {
                      //         _selectedValRoute = val as String;
                      //       });
                      //     },
                      //     icon: Icon(
                      //       Icons.arrow_drop_down_circle,
                      //       color: kSecondaryColor,
                      //     ),
                      //     // dropdownColor: Colors.cyan.shade50,
                      //     decoration: InputDecoration(
                      //       label: Text(
                      //         "Route",
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 25,
                      //             color: kSecondaryColor),
                      //       ),
                      //       prefixIcon: Icon(
                      //         Icons.location_on_outlined,
                      //         color: kSecondaryColor,
                      //       ),
                      //         ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //           child: f_name_TextFormField()),
                      //       SizedBox(width: 8.0,),
                      //       Expanded(
                      //
                      //           child: l_name_TextFormField()),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 20,),
                      _route_name(_routeName),
                      const SizedBox(height: 20,),
                      _area_name(_areaName),
                      const SizedBox(height: 20,),
                      Text(
                        "Select stops",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColor,
                        ),
                      ),


                      Container(
                        width: size.width,
                        child: NumberPicker(
                          value: _textfieldnumber,
                          minValue: 0,
                          maxValue: 10,
                          step: 1,
                          itemHeight: 100,
                          axis: Axis.horizontal,
                          onChanged: (value){
                            _formfields = List.generate(value, (index) {
                              return TextEditingController();
                            });
                            setState(() {
                              _textfieldnumber = value;
                              print(_textfieldnumber);
                            });
                          },
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black26),
                          ),
                        ),
                      ),







                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     InkWell(
                      //       onTap: (){
                      //         _addField();
                      //       },
                      //       child: Icon(Icons.add_circle,color: kSecondaryColor,size: 40,),
                      //     ),
                      //   ],
                      // ),
                      // Column(
                      //   children: [
                      //     for(int i = 0 ; i<=5; i++)
                      //       Column(
                      //         children: [
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.end,
                      //             children: [
                      //               InkWell(
                      //                 onTap: (){
                      //                   _removeField(i);
                      //                 },
                      //                 child: Icon(Icons.cancel,color: kSecondaryColor,size: 40,),),
                      //             ],
                      //           ),
                      //           Expanded(child: Padding(
                      //             padding: EdgeInsets.all(10),
                      //             child: TextFormField(
                      //               keyboardType: TextInputType.text,
                      //               controller: _stop_route_name[i],
                      //               validator: (val){
                      //                 if(val!.isEmpty)
                      //                 {
                      //                   return " *Required";
                      //                 }
                      //                 return null;
                      //               },
                      //               decoration: InputDecoration(
                      //                   border: OutlineInputBorder(
                      //                       borderRadius: BorderRadius.circular(15)
                      //                   ),
                      //                   labelText: "Route name"
                      //               ),
                      //             ),
                      //           ))
                      //         ],
                      //       ),
                      //    const Divider(thickness: 3,),
                      //   ],
                      // ),



                      //add route button...
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
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                        // side: BorderSide(color: Colors.red)
                                      ))),
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                }
                              },
                              child: Text("Add Route".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey.shade50)),
                            )),
                      ),

                    ],
                  ),
                ),
              ),
                Expanded(
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _formfields.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: TextField(
                              controller: _formfields[index],

                            ));
                      }),
                ),
                TextButton(onPressed: (){
                  _formfields.forEach((element) {
                  print(element.text);
                });}, child: Text("abc"))
              ],

            )));
  }
}

Widget _route_name(TextEditingController _routeName) => TextFormField(
      controller: _routeName,
      showCursor: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kSecondaryColor,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(
          Icons.route_sharp,
          color: kSecondaryColor,
          size: 22,
        ),
        label: Text("Route Name"),
        labelStyle: TextStyle(
            color: kSecondaryColor, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val!.isEmpty) {
          return " *Required";
        }
        return null;
      },
    );

Widget _area_name(TextEditingController _areaName) => TextFormField(
      controller: _areaName,
      showCursor: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kSecondaryColor,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(
          Icons.maps_home_work,
          color: kSecondaryColor,
          size: 22,
        ),
        label: Text("Area Name"),
        labelStyle: TextStyle(
            color: kSecondaryColor, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val!.isEmpty) {
          return " *Required";
        }
        return null;
      },
    );



//
// Slider(
// value: _currentValueSlider,
// min: 0,
// max: 10,
// divisions: 10,
// label: _currentValueSlider.toString(),
// activeColor: kSecondaryColor,
// onChanged: (value) {
// setState(() {
// _currentValueSlider = value;
// });
// }),
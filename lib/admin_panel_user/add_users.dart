import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pro/widgets/floating_speedDial.dart';
import 'package:pro/widgets/pelatte.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';

class add_user extends StatefulWidget {
  const add_user({Key? key}) : super(key: key);

  @override
  State<add_user> createState() => _add_userState();
}

class _add_userState extends State<add_user> {
  var jsonResponse;
  // DateTime date = DateTime(2022,1,1);
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _cardValue = TextEditingController();
  TextEditingController _date = TextEditingController();
// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text("Add Users"),
        centerTitle: true,
      ),
      floatingActionButton: const floating_speedDial(),
      body: Stack(
        children: [
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: const SizedBox(),
              )),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: formkey,
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: f_nameTextfields(_fname)),
                              SizedBox(width: 8.0,),
                              Expanded(
                                  child: l_nameTextfields(_lname)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        e_mailTextfields3(_email),
                        const SizedBox(
                          height: 15,
                        ),
                        // Text("${date.year}/${date.month}/${date.day}"),
                        // ElevatedButton(
                        //     onPressed: ,
                        //     child: Text("Choose Text")
                        // ),
                        c_noTextfields4(_contact),
                        const SizedBox(
                          height: 15,
                        ),
                        passwordTextfields5(_pass),
                        const SizedBox(
                          height: 15,
                        ),

                        //date picker
                        Padding(
                          padding: const EdgeInsets.only(left: 0,top: 0,right: 0,bottom: 2.5),
                          child: TextFormField(
                            controller: _date,
                            validator: (val){
                              if(val!.isEmpty)
                                {
                                  return " *Required";
                                }
                              return null;
                            },
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              prefixIcon:  Icon(
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
                                  _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        card_value(_cardValue),
                        const SizedBox(
                          height: 150,
                        ),
                        SizedBox(
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
                                if (formkey.currentState!.validate()) {
                                   formkey.currentState!.save();
                                   final url = Uri.parse("https://policelookout.000webhostapp.com/API/Admin_Adduser_me.php");

                                   var body = {
                                     "Email_Id": _email.text,
                                     "Password": _pass.text,
                                     "F_Name": _fname.text,
                                     "L_Name": _lname.text,
                                     "Contact_No":_contact.text,
                                     "DOB": _date.text,
                                     "Card_Value": _cardValue.text
                                   };

                                   final response = await http.post(url,body: body);
                                   // print(response);

                                   if (response.statusCode == 200) {
                                     jsonResponse = jsonDecode(response.body);
                                     if (jsonResponse['error'] == false) {
                                       // jsonResponse['message'];
                                       ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
                                           backgroundColor: Colors.cyan.shade800,
                                           // content: Text(jsonDecode(fetch1)["message"]),
                                           content: Text(jsonResponse['message']),
                                         ),
                                       );
                                       Navigator.of(context).pop();
                                     }
                                     else
                                     {
                                       // jsonResponse['message'];
                                       ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
                                           backgroundColor: Colors.cyan.shade800,
                                           // content: Text(jsonDecode(fetch1)["message"]),
                                           content: Text(jsonResponse['message']),
                                         ),
                                       );
                                     }
                                   }

                                }
                              },
                              child: Text("Submit".toUpperCase(),
                                  style: const TextStyle(fontSize: 20)),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: floating_speedDial(),
    );
  }
}

Widget f_nameTextfields( TextEditingController _fname) => TextFormField(
  controller: _fname,
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
        label: Text("First Name"),
        labelStyle: TextStyle(color: kSecondaryColor,fontWeight: FontWeight.bold),
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[A-z a-z]+$').hasMatch(value)) {
          return "Enter correct name";
        } else {
          return null;
        }
      },
    );
Widget l_nameTextfields(TextEditingController _lname) => TextFormField(
      controller: _lname,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kSecondaryColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        // enabledBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: kSecondaryColor)),
        prefixIcon: Icon(
          Icons.person_rounded,
          color: kSecondaryColor,
          size: 22,
        ),
        label: Text("Last Name"),
        labelStyle: TextStyle(color: kSecondaryColor,fontWeight: FontWeight.bold),
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[A-z a-z]+$').hasMatch(value)) {
          return "Enter correct name";
        } else {
          return null;
        }
      },
    );
Widget e_mailTextfields3( TextEditingController _email) => TextFormField(
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
        labelStyle: TextStyle(color: kSecondaryColor,fontWeight: FontWeight.bold),
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
Widget c_noTextfields4( TextEditingController _contact) => TextFormField(
      controller: _contact,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kSecondaryColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        // enabledBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: kSecondaryColor)),
        prefixIcon: Icon(
          Icons.phone,
          color: kSecondaryColor,
          size: 22,
        ),
        label: const Text("Contact No."),
        labelStyle: TextStyle(color: kSecondaryColor,fontWeight: FontWeight.bold),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)) {
          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
          return "Enter correct number";
        } else {
          return null;
        }
      },
    );
Widget passwordTextfields5( TextEditingController _pass) => TextFormField(
  controller: _pass,
  decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryColor),
      borderRadius: BorderRadius.circular(20.0),
    ),
    // enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: kSecondaryColor)),
    prefixIcon: Icon(
      Icons.password,
      color: kSecondaryColor,
      size: 22,
    ),
    label: const Text("Password"),
    labelStyle: TextStyle(color: kSecondaryColor,fontWeight: FontWeight.bold),
  ),
  keyboardType: TextInputType.text,
  textInputAction: TextInputAction.next,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  validator: (value) {
    if (value!.isEmpty) {
      return "Enter correct Password";
    } else {
      return null;
    }
  },
);
Widget card_value( TextEditingController _cardValue) => TextFormField(
  controller: _cardValue,
  decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryColor),
      borderRadius: BorderRadius.circular(20.0),
    ),
    // enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: kSecondaryColor)),
    prefixIcon: Icon(
      Icons.credit_card,
      color: kSecondaryColor,
      size: 22,
    ),
    label: const Text("Card Value"),
    labelStyle: TextStyle(color: kSecondaryColor,fontWeight: FontWeight.bold),
  ),
  keyboardType: TextInputType.text,
  // inputFormatters: <TextInputFormatter>[
  //   FilteringTextInputFormatter.digitsOnly,
  // ],
  textInputAction: TextInputAction.next,
  validator: (val) {
    if(val!.isEmpty){
      return "*Required";
    }
    return null;
  },
);

// Widget buildTextfields() => Padding(
//       padding: EdgeInsets.all(25),
//       child: Container(
//         width: double.infinity,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               buildTextfields1(),
//               const SizedBox(
//                 height: 15,
//               ),
//               buildTextfields2(),
//               const SizedBox(
//                 height: 15,
//               ),
//               buildTextfields3(),
//               const SizedBox(
//                 height: 15,
//               ),
//               // Text("${date.year}/${date.month}/${date.day}"),
//               // ElevatedButton(
//               //     onPressed: ,
//               //     child: Text("Choose Text")
//               // ),
//               buildTextfields4(),
//               const SizedBox(
//                 height: 15,
//               ),
//               // buildTextfields5(),
//               // SizedBox(
//               //   height: 15,
//               // ),
//               const Text(
//                 'Forgot Password?',
//                 style: TextStyle(color: Colors.black87, fontSize: 12.0),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               SizedBox(
//                   width: double.infinity,
//                   height: 50.0,
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                         // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                             kSecondaryColor),
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16.0),
//                           // side: BorderSide(color: Colors.red)
//                         ))),
//                     onPressed: () {
//                       if(formkey.currenstate!.validate()){
//
//                       }
//                     },
//                     child: Text("Submit".toUpperCase(),
//                         style: const TextStyle(fontSize: 20)),
//                   )
//               ),
//             ],
//           ),
//         ),
//       ),
//     );


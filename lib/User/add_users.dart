import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro/widgets/floating_speedDial.dart';
import 'package:pro/widgets/pelatte.dart';

class add_user extends StatefulWidget {
  const add_user({Key? key}) : super(key: key);

  @override
  State<add_user> createState() => _add_userSate();
}

class _add_userSate extends State<add_user> {
  // DateTime date = DateTime(2022,1,1);
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text("Add Users"),
        centerTitle: true,
      ),
      body: Form(
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
                  buildTextfields1(),
                  const SizedBox(
                    height: 15,
                  ),
                  buildTextfields2(),
                  const SizedBox(
                    height: 15,
                  ),
                  buildTextfields3(),
                  const SizedBox(
                    height: 15,
                  ),
                  // Text("${date.year}/${date.month}/${date.day}"),
                  // ElevatedButton(
                  //     onPressed: ,
                  //     child: Text("Choose Text")
                  // ),
                  buildTextfields4(),
                  const SizedBox(
                    height: 15,
                  ),
                  // buildTextfields5(),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.black87, fontSize: 12.0),
                  ),
                  const SizedBox(
                    height: 350,
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
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            // formkey.currentState!.save();
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
      // floatingActionButton: floating_speedDial(),
    );
  }
}


Widget buildTextfields1() => TextFormField(
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
        label: Text("First Name"),
        hintStyle: TextStyle(color: kSecondaryColor),
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
Widget buildTextfields2() => TextFormField(
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
        hintStyle: TextStyle(color: kSecondaryColor),
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
Widget buildTextfields3() => TextFormField(
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
        hintStyle: TextStyle(color: kSecondaryColor),
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
Widget buildTextfields4() => TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kSecondaryColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        // enabledBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: kSecondaryColor)),
        prefixIcon: Icon(
          Icons.contact_phone,
          color: kSecondaryColor,
          size: 22,
        ),
        label: const Text("Contact No."),
        hintStyle: TextStyle(color: kSecondaryColor),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)) {
          return "Enter correct number";
        } else {
          return null;
        }
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
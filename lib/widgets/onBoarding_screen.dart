import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro/homepage.dart';
import 'package:rive/rive.dart';
import 'package:http/http.dart' as http;
// import '../screens/homeScreen.dart';
import 'package:pro/User/user_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var logindata;
  var data;
  bool validator1 = false;
  bool validator2 = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: const SizedBox(),
          )),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                      width: 270,
                      child: Text(
                        "Let's Route!",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            fontSize: 50,
                            fontFamily: "poppins"),
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    height: 76,
                    width: 340,
                    child: Text(
                      "You are using the 21st century's most advanced mobile application, you can increase productivity, manage tasks, and receive alerts.",
                      style: TextStyle(fontSize: 15, fontFamily: "poppins"),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.grey[600]?.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(16)),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "E-mail must not be empty";
                                    } else {
                                      if (val.contains('@')) {
                                        return null;
                                      } else {
                                        return "E-mail incorrect";
                                      }
                                    }
                                  },
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 15),
                                    border: InputBorder.none,
                                    hintText: 'Email or Number',
                                    hintStyle: GoogleFonts.cantarell(
                                        fontSize: 20,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400),
                                    prefixIcon: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Icon(
                                        Icons.email_outlined,
                                        color: Color.fromRGBO(34, 87, 126, 1),
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                  // validator: (val) =>
                                  //     val!.isEmpty || !val!.contains("@")
                                  //         ? "enter a valid eamil"
                                  //         : null,
                                  // autovalidate: true,
                                  // validator: (email) => email != null && !EmailInputElement.validate(email)
                                  //   ? 'Enter a valid name'
                                  //     : null,
                                  style: GoogleFonts.cantarell(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[600]?.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(16)),
                                child: TextFormField(
                                  validator: (val) =>
                                  val!.isEmpty ? "password must not be empty" : null,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 15),
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: GoogleFonts.cantarell(
                                        fontSize: 20,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400),
                                    prefixIcon: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Icon(
                                        Icons.lock,
                                        color: Color.fromRGBO(34, 87, 126, 1),
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                  style: GoogleFonts.cantarell(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 18.0),
                              ),
                              const SizedBox(
                                height: 70,
                              ),
                              Text(
                                validator1 == true
                                    ? "EMAIL OR PASSWORD CAN\'T BE NULL!"
                                    : "",
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                validator2 == true
                                    ? "PASSWORD LENGTH MUST BE MORE THAN 3 CHARACTERS"
                                    : "",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.deepOrange),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          // side: BorderSide(color: Colors.red)
                                        ))),
                                    onPressed: () async {
                                      // if (passwordController.text.length <= 3) {
                                      //   validator2 = true;
                                      //   setState(() {});
                                      // }
                                      // else{
                                      //   setState(() {});
                                      //   validator1 = false;
                                      // }
                                      if (formkey.currentState!.validate()) {
                                        // formkey.currentState!.save();
                                      }
                                      if ((nameController.text == null ||
                                              nameController.text == '') ||
                                          (passwordController.text == null ||
                                              passwordController.text == '')) {
                                        setState(() {});
                                        validator1 = true;
                                      } else {
                                        setState(() {});
                                        validator1 = false;
                                        final login_url = Uri.parse(
                                            "https://policelookout.000webhostapp.com/API/LOGIN_ME.php");
                                        final response = await http
                                            .post(login_url, body: {
                                          "Email_Id": nameController.text,
                                          "Password": passwordController.text
                                        });
                                        if (response.statusCode == 200) {
                                          logindata = jsonDecode(response.body);
                                          data = jsonDecode(response.body)['user'];
                                          print(data);
                                          // final personal_obj = personal_info.fromJson(data);
                                          // print(personal_obj.f_Name);
                                          personal_info1.getJson(data);
                                          if (logindata['error'] == false) {
                                            Navigator.push(
                                              context, MaterialPageRoute(
                                                builder: (context) {
                                                return HomePage();
                                              }),
                                            ); //pass personobj to basepage
                                          }
                                        } else {
                                          nameController.clear();
                                          passwordController.clear();
                                        }
                                      }
                                    },
                                    child: Text("Login".toUpperCase(),
                                        style: const TextStyle(fontSize: 20)),
                                  )),
                              const SizedBox(
                                height: 80,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30),
          //   child: Column(
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Container(
          //             decoration: BoxDecoration(
          //                 color: Colors.grey[600]?.withOpacity(0.5),
          //                 borderRadius: BorderRadius.circular(16)),
          //             child: TextField(
          //               decoration: InputDecoration(
          //                 contentPadding:
          //                 EdgeInsets.symmetric(vertical: 20),
          //                 border: InputBorder.none,
          //                 hintText: 'Email or Number',
          //                 hintStyle: GoogleFonts.cantarell(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w400),
          //                 prefixIcon: Padding(
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 15),
          //                   child: Icon(
          //                     Icons.email_outlined,
          //                     color: Colors.white,
          //                     size: 30.0,
          //                   ),
          //                 ),
          //               ),
          //               style: GoogleFonts.cantarell(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w400),
          //               textInputAction: TextInputAction.next,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Container(
          //             decoration: BoxDecoration(
          //                 color: Colors.grey[600]?.withOpacity(0.5),
          //                 borderRadius: BorderRadius.circular(16)),
          //             child: TextField(
          //               decoration: InputDecoration(
          //                 contentPadding:
          //                 EdgeInsets.symmetric(vertical: 20),
          //                 border: InputBorder.none,
          //                 hintText: 'Password',
          //                 hintStyle: GoogleFonts.cantarell(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w400),
          //                 prefixIcon: Padding(
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 15),
          //                   child: Icon(
          //                     Icons.lock,
          //                     color: Colors.white,
          //                     size: 30.0,
          //                   ),
          //                 ),
          //               ),
          //               style: GoogleFonts.cantarell(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w400),
          //               obscureText: true,
          //               keyboardType: TextInputType.visiblePassword,
          //               textInputAction: TextInputAction.done,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Text(
          //             'Forgot Password?',
          //             style: TextStyle(
          //                 color: Colors.grey[300], fontSize: 18.0),
          //           ),
          //           SizedBox(
          //             height: 70,
          //           ),
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Container(
          //               width: double.infinity,
          //               height: 50.0,
          //               child: ElevatedButton(
          //                 child: Text("Login".toUpperCase(),
          //                     style: TextStyle(fontSize: 20)),
          //                 style: ButtonStyle(
          //                   // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          //                     backgroundColor:
          //                     MaterialStateProperty.all<Color>(
          //                         Colors.red),
          //                     shape: MaterialStateProperty.all<
          //                         RoundedRectangleBorder>(
          //                         RoundedRectangleBorder(
          //                           borderRadius:
          //                           BorderRadius.circular(16.0),
          //                           // side: BorderSide(color: Colors.red)
          //                         ))),
          //                 onPressed: () {
          //                   Navigator.push(context, MaterialPageRoute(builder: (context)=> home_screen()));
          //                 },
          //               )),
          //           SizedBox(
          //             height: 80,
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class personal_info {
  String? login_Id;
  String? email_Id;
  String? role;
  String? f_Name;
  String? l_Name;
  String? contact_No;
  String? status;
  String? dOB;

  personal_info(
      {this.login_Id,
      this.email_Id,
      this.role,
      this.f_Name,
      this.l_Name,
      this.contact_No,
      this.status,
      this.dOB});

  factory personal_info.fromJson(Map<String, dynamic> parsedJson) {
    return personal_info(
      login_Id: parsedJson['Login_Id'].toString(),
      email_Id: parsedJson['Email_Id'].toString(),
      role: parsedJson['Role'].toString(),
      f_Name: parsedJson['F_Name'].toString(),
      l_Name: parsedJson['L_Name'].toString(),
      contact_No: parsedJson[' Contact_No'].toString(),
      status: parsedJson['Status'].toString(),
      dOB: parsedJson['DOB'].toString(),
    );
  }
}
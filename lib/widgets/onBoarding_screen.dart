import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro/screens/homepage.dart';
import 'package:rive/rive.dart';
import 'package:http/http.dart' as http;
import 'package:pro/others/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/user_panel/U_homepage.dart';
import 'ForgotpasswordPage.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: const SizedBox(),
          )),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(width: 270,
                      child: Text(
                        "Let's Route!",
                        style: TextStyle(fontWeight: FontWeight.w600, height: 1.2, fontSize: 50, fontFamily: "poppins"),
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
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
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty || RegExp(r"\s").hasMatch(val)) {
                                      return "Email must not be empty";
                                    } else {
                                      if (RegExp(r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}")
                                          .hasMatch(val)) {return null;}
                                      else {
                                        return "Enter a valid Email";
                                      }
                                    }
                                  },
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                    border: InputBorder.none,
                                    hintText: 'Example123@gmail.com',
                                    hintStyle: GoogleFonts.cantarell(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w400),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: Icon(Icons.email_outlined, color: Color.fromRGBO(34, 87, 126, 1), size: 30.0,
                                      ),
                                    ),
                                  ),
                                  style: GoogleFonts.cantarell(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty || RegExp(r"\s").hasMatch(val)) {
                                      return "Use Proper Password ";
                                    }
                                  },
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                    border: InputBorder.none,
                                    hintText: 'Password123',
                                    hintStyle: GoogleFonts.cantarell(
                                        fontSize: 20,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: Icon(Icons.lock, color: Color.fromRGBO(34, 87, 126, 1),
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                  style: GoogleFonts.cantarell(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              const SizedBox(height: 10,),

                              //forgot button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return forgot_password();
                                        }),
                                      );
                                    },
                                    autofocus: false,
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 70,),
                              Text(
                                validator1 == true
                                    ? "EMAIL or PASSWORD CAN\'T BE NULL!"
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
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0),

                                        ))),
                                    onPressed: () async {
                                      if (formkey.currentState!.validate()) {

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
                                          data =
                                              jsonDecode(response.body)['user'];
                                          print(data);
                                          // final personal_obj = personal_info.fromJson(data);
                                          // print(personal_obj.f_Name);
                                          personal_info1.getJson(data);
                                          if (logindata['error'] == false) {
                                            SharedPreferences setpreference = await SharedPreferences.getInstance();
                                            setpreference.setString('id', personal_info1.login_Id!);
                                            setpreference.setString('Role', personal_info1.role!);
                                            setpreference.setString('name', "${personal_info1.f_Name!} ${personal_info1.l_Name!}");
                                            setpreference.setString('contactUs', personal_info1.contact_No!);
                                            setpreference.setString('cardValue', personal_info1.card_Value!);
                                            setpreference.setString('dob', personal_info1.dOB!);
                                            setpreference.setString('email', personal_info1.email_Id!);

                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            if(prefs.getString('id') != null) {
                                              if(prefs.getString('Role') != null && prefs.getString('Role') == "1"){
                                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
                                              }else{
                                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => U_homepage()), (Route<dynamic> route) => false);
                                              }
                                            }else{
                                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                  builder: (BuildContext context) => OnboardingScreen()), (
                                                  Route<dynamic> route) => false);
                                            }

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
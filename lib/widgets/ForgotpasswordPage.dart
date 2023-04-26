import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:pro/widgets/pelatte.dart';
import '../others/OTP_gen_ver.dart';


class forgot_password extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return forgot_state();
  }
}

class forgot_state extends State<forgot_password> {
  TextEditingController forgot_email_controller = TextEditingController();
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                      // color: Colors.amber,
                    height: MediaQuery.of(context).size.height*0.46,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.red,
                          height: MediaQuery.of(context).size.height*0.36,
                          width: MediaQuery.of(context).size.width,
                          //  color: Colors.blue,
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.fromLTRB(5, 0, 50, 0),
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(
                                                Icons.arrow_back_ios,
                                                color: kSecondaryColor,
                                                size: 25,
                                              ))),
                                      Text("Forgot Password?",
                                          style: GoogleFonts.rowdies(
                                              fontSize: 27, color: Color(0xff373737)),textAlign: TextAlign.center,),
                                    ]),
                                SizedBox(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Text(
                                  "Enter the email address\nassociated with your account",
                                  style: GoogleFonts.rowdies(
                                      fontSize: 20, color: Color(0xff464646)),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                        ),
                      ],
                    )),
                Container(
                  // color: Colors.green,
                    height: MediaQuery.of(context).size.height*0.26,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            "We will send you an One Time Password\nOn your email account",
                            style: GoogleFonts.rowdies(
                                fontSize: 14,
                                letterSpacing: 1.0,
                                wordSpacing: 2.0,
                                fontWeight: FontWeight.w300,
                                color: Color(0xff666262)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          // color: Colors.grey,
                            margin: EdgeInsets.fromLTRB(15, 30, 15, 15),
                            child: Form(
                              key: formkey1,
                              child: TextFormField(
                                controller: forgot_email_controller,
                                validator: (val) {
                                  if (val!.isEmpty || RegExp(r"\s").hasMatch(val)) {
                                    return "Email must not be empty";
                                  } else {
                                    if (RegExp(
                                        r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}")
                                        .hasMatch(val)) {
                                      return null;
                                    } else {
                                      return "Enter a valid Email";
                                    }
                                  }
                                },
                                showCursor: true,
                                onChanged: (value) {},
                                autofocus: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration:  InputDecoration(
                                  hintText: "Example@gmail.com",
                                  prefixIcon: Icon(Icons.email,color: kSecondaryColor,),
                                  label: Text(
                                    " Email",
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                                ),
                              ),
                            )),
                        Container(
                          // color: Colors.grey,
                          margin: EdgeInsets.only(top: 15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kSecondaryColor,

                              fixedSize:
                              Size(MediaQuery.of(context).size.width - 35, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // <-- Radius
                              ),

                            ),
                            child: Text(
                              'GET OTP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1),
                            ),
                            onPressed: () async {
                              // forgot_email_controller.text = "pmaharshi233@gmail.com";
                              final user_email = forgot_email_controller.text;
                              String message = OTPgenerator();
                              if (formkey1.currentState!.validate()) {
                                formkey1.currentState!.save();
                                const service_id = "service_ushv3c4";
                                const template_id = "template_q2kybm8";
                                const user_id = "m4ixs60E5evsH8g_c";
                                final url = Uri.parse(
                                    "https://api.emailjs.com/api/v1.0/email/send");

                                String body = jsonEncode({
                                  "service_id": "service_ushv3c4",
                                  "template_id": "template_q2kybm8",
                                  "user_id": "m4ixs60E5evsH8g_c",
                                  "accessToken": "MMBmpdEvk4cjaF1TIsdrZ",
                                  "template_params": {
                                    "from_user_name": "PoliceLookout",
                                    "user_email": user_email,
                                    "message": message
                                  }
                                });

                                final response = await http.post(url,
                                    headers: {
                                      'origin': 'http://localhost',
                                      'Content-Type': 'application/json'
                                    },
                                    body: body);
                                print(response.body);
                                if (response.body == "OK") {
                                  Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) {
                                        return otp_verify(
                                            email: forgot_email_controller.text,
                                            message: message);
                                      }),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}

class otp_verify extends StatefulWidget {
  String email;
  String message;
  otp_verify({required this.email, required this.message});

  @override
  State<StatefulWidget> createState() {
    return otp_state(email: email, message: message);
  }
}

class otp_state extends State<otp_verify> {
  String email;
  String message;
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  TextEditingController first_digit = TextEditingController();
  TextEditingController second_digit = TextEditingController();
  TextEditingController third_digit = TextEditingController();
  TextEditingController forth_digit = TextEditingController();

  otp_state({required this.email, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(20, 25, 20, 20),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: kSecondaryColor,
                    size: 27,
                  ))),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              "Verification code",
              style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              "We have sent the code verification to\n ${email}",
              style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 1.0,
                  wordSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20, 25, 20, 5),
              child: Form(
                key: formkey1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        controller: first_digit,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        showCursor: false,
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        controller: second_digit,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.length < 1) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        autofocus: false,
                        decoration: const InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Color(0xcfda0808)),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        showCursor: false,
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        controller: third_digit,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.length < 1) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        autofocus: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        showCursor: false,
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      width: 64,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        controller: forth_digit,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.length < 1) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        autofocus: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        showCursor: false,
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code ? ",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 1.0,
                          wordSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]),
                    ),
                    TextButton(
                      onPressed: () async {
                        const service_id = "service_ushv3c4";
                        const template_id = "template_q2kybm8";
                        const user_id = "m4ixs60E5evsH8g_c";
                        message = OTPgenerator();
                        final url = Uri.parse(
                            "https://api.emailjs.com/api/v1.0/email/send");

                        String body = jsonEncode({
                          "service_id": "service_ushv3c4",
                          "template_id": "template_q2kybm8",
                          "user_id": "m4ixs60E5evsH8g_c",
                          "accessToken": "MMBmpdEvk4cjaF1TIsdrZ",
                          "template_params": {
                            "from_user_name": "PoliceLookout",
                            "user_email": email,
                            "message": message
                          }
                        });

                        final response = await http.post(url,
                            headers: {
                              'origin': 'http://localhost',
                              'Content-Type': 'application/json'
                            },
                            body: body);
                        print(response.body);
                      },
                      autofocus: false,
                      child: Text(
                        "RESEND OTP",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ])),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kSecondaryColor,
                      fixedSize:
                      Size(MediaQuery.of(context).size.width - 35, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // <-- Radius
                      ),
                    ),
                    child: const Text(
                      'Confirmed',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 0.7),
                    ),
                    onPressed: () {
                      if (formkey1.currentState!.validate()) {
                        formkey1.currentState!.save();
                        String messagecmpTO = "";
                        messagecmpTO += first_digit.text.toString();
                        messagecmpTO += second_digit.text.toString();
                        messagecmpTO += third_digit.text.toString();
                        messagecmpTO += forth_digit.text.toString();
                        if (otp_compare(message, messagecmpTO)) {

                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) {
                                return change_password(
                                  //splash screen
                                  email: email,
                                );
                              }),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class change_password extends StatefulWidget {
  String email;

  change_password({required this.email});

  @override
  State<StatefulWidget> createState() {
    return change_state(email: email);
  }
}

class change_state extends State<change_password> {
  TextEditingController change_pass_controller = TextEditingController();
  TextEditingController change_pass_repeat_controller = TextEditingController();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  String email;
  change_state({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                margin: EdgeInsets.fromLTRB(20, 25, 20, 20),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: kSecondaryColor,
                      size: 27,
                    ))),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                "Reset Password",
                style: TextStyle(
                    fontSize: 27, letterSpacing: 1.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                "Strong password includes numbers,letters, and panctuation marks.",
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800]),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(15, 30, 15, 15),
                child: Form(
                  key: formkey2,
                  child: Column(children: [
                    TextFormField(
                      controller: change_pass_controller,
                      validator: (val) {
                        if (val!.isEmpty || RegExp(r"\s").hasMatch(val)) {
                          return "Password must not be empty";
                        } else {
                          return null;
                        }
                      },
                      showCursor: true,
                      onChanged: (value) {},
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text(
                          "  Enter new password",
                          style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      width: MediaQuery.of(context).size.width,
                    ),
                    TextFormField(

                      controller: change_pass_repeat_controller,
                      validator: (val) {
                        if (val!.isEmpty || RegExp(r"\s").hasMatch(val)) {
                          return "Password must not be empty";
                        } else {
                          if (val == change_pass_controller.text) {
                            return null;
                          } else {
                            return "Password must be same";
                          }
                          return null;
                        }
                      },
                      showCursor: true,
                      onChanged: (value) {},
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text(
                          "  Confirmed password",
                          style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                    SizedBox(height: 45, width: MediaQuery.of(context).size.width),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kSecondaryColor,
                              fixedSize:
                              Size(MediaQuery.of(context).size.width - 45, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            child: const Text(
                              'Change Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  letterSpacing: 2),
                            ),
                            onPressed: () async {
                              if (formkey2.currentState!.validate()) {
                                formkey2.currentState!.save();

                                final url = Uri.parse(
                                    "https://policelookout.000webhostapp.com/API/Change_Password_ME.php");

                                String body = jsonEncode({
                                  "change_email": email,
                                  "change_password": change_pass_controller.text
                                });

                                final response = await http.post(url, body: body);
                                print(response.body);
                              }
                            }))
                  ]),
                )),
          ]),
        ));
  }
}

class verify_lottie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
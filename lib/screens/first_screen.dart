import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro/about_duties/home/new_schedule_assign_basepage.dart';
import 'package:flutter/src/painting/gradient.dart' as prefix;
import 'package:pro/screens/map_admin.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../admin_panel_user/history.dart';
import '../admin_panel_user/manage_user.dart';
import '../others/user_data.dart';
import '../widgets/pelatte.dart';

class first_screen extends StatefulWidget {
  const first_screen({Key? key}) : super(key: key);

  @override
  State<first_screen> createState() => _first_screenState();
}

class _first_screenState extends State<first_screen> {



  String userName = "";

  newFieldName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString('name')!;
    });
  }

  @override
  void initState() {
    newFieldName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          // Positioned.fill(
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          //       child: const SizedBox(),
          //     )),
          Container(
            height: size.height*.35,
            decoration: BoxDecoration(
              gradient: prefix.LinearGradient(
                colors: [
                  Colors.cyan.shade700.withOpacity(0.4),
                  Colors.cyan.shade500.withOpacity(0.4),
                  Colors.cyan.shade200.withOpacity(0.4),
                ],
                begin: AlignmentDirectional.topCenter,
                end: Alignment.bottomCenter,

              ),

              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70),
              )
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment : Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade600,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(child: Image.asset("assets/images/PL.png")),
                    ),
                  ),
                  Text(
                    "PoliceLookOut",
                    style: GoogleFonts.keaniaOne(
                        fontSize: 50,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40,),
                  Text(
                    "Welcome Home,",
                    style: GoogleFonts.robotoMono(
                        fontSize: 22,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    userName,
                    style: GoogleFonts.robotoMono(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 110,),

                  Expanded(
                    child: GridView.count(
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow:  [
                              BoxShadow(color: Colors.black26,offset: Offset( 3,4.0),blurRadius:5,spreadRadius: 2),
                            ]
                          ),
                          child: InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const map_admin(),));
                              // getLiveLocation();
                              // launchURL();
                            },
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 5,
                                  left: 5,
                                  child: Text(
                                    "View \nLocation",
                                    style: homeText,
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 5,
                                  child: Image.asset("assets/images/location_2.png",width: 60,height: 60,),)
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26,offset: Offset( 3,4.0),blurRadius:5,spreadRadius: 2),
                              ]
                            ),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, PageTransition(child: const history(), type: PageTransitionType.leftToRight));
                              },
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    left: 5,
                                    child: Text(
                                      "History",
                                      style: homeText,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 5,
                                    child: Image.asset("assets/images/history.png",width: 50,height: 50,),)
                                ],
                              ),
                            )
                          ),
                        ),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26,offset: Offset( 3,4.0),blurRadius:5,spreadRadius: 2),
                              ]
                            ),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const new_schedule_assign_basepage(),));
                              },
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    left: 5,
                                    child: Text(
                                      "Schedule \nDuties",
                                      style: homeText,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 5,
                                    child: Image.asset("assets/images/duties.png",width: 50,height: 50,),)
                                ],
                              ),
                            )
                          ),
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.black26,offset: Offset( 3,4.0),blurRadius:5,spreadRadius: 2)
                              ]
                            ),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> manage_users(),));
                              },
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    left: 5,
                                    child: Text(
                                      "Manage \nUser",
                                      style: homeText,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 5,
                                    child: Image.asset("assets/images/manage_user.png",width: 50,height: 50,),)
                                ],
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          

        ],
      ),
    );
  }
}










//
// class Body extends StatelessWidget {
//   const Body({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // provide total length of screen
//     Size size = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: header(size: size),
//     );
//   }
// }
//
// class header extends StatelessWidget {
//   const header({
//     Key? key,
//     required this.size,
//   }) : super(key: key);
//
//   final Size size;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//
//     );
//
//     //   Container(
//     //   height: size.height*0.3,
//     //   child: Stack(
//     //     children: [
//     //       Container(
//     //         padding: EdgeInsets.only(left: 25,right: 20),
//     //         height: size.height*0.2+17,
//     //         decoration: BoxDecoration(
//     //           borderRadius: BorderRadius.only(
//     //             bottomLeft: Radius.circular(40),
//     //             bottomRight: Radius.circular(40),
//     //           ),
//     //           color: kPrimaryColor,
//     //         ),
//     //         child: Row(
//     //           crossAxisAlignment: CrossAxisAlignment.start,
//     //           children: [
//     //             Column(
//     //               crossAxisAlignment: CrossAxisAlignment.start,
//     //               children: [
//     //                 SizedBox(height: 17,),
//     //                 Text(
//     //                   "PoliceLookOut",
//     //                   style: GoogleFonts.keaniaOne(
//     //                       fontSize: 40,
//     //                       color: Colors.black87,
//     //                       fontWeight: FontWeight.bold),
//     //                 ),
//     //                 SizedBox(height: 12,),
//     //                 Text("Welcome Home,",style: GoogleFonts.robotoMono(
//     //                     fontSize: 15,
//     //                     color: Colors.black87,
//     //                     fontWeight: FontWeight.w600),),
//     //                 Text(
//     //                   personal_info1.f_Name ?? "" ,
//     //                   style: GoogleFonts.robotoMono(
//     //                       fontSize: 25,
//     //                       color: Colors.black,
//     //                       fontWeight: FontWeight.w600),
//     //                 ),
//     //               ],
//     //             ),
//     //
//     //           ],
//     //         ),
//     //       ),
//     //
//     //     ],
//     //   ),
//     // );
//   }
// }

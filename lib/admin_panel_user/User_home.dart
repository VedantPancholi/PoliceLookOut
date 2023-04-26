import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


import 'add_users.dart';
import 'history.dart';
import 'manage_user.dart';

class Users extends StatefulWidget {
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final items = const [
    Icon(Icons.add, size: 30,color: Colors.white,),
    Icon(Icons.manage_accounts_outlined, size: 30,color: Colors.white,),
    Icon(Icons.history, size: 30,color: Colors.white,),
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(

        items: items,
        index: index,
        onTap: (selctedIndex){
          setState(() {
            index = selctedIndex;
          });
        },
        height: 60,
        buttonBackgroundColor: Color.fromRGBO(0, 66, 90,1),
        color: Color.fromRGBO(0, 66, 90,1),
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 400),
        // animationCurve: ,
      ),
      body: Container(
          color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: index)
      ),
    );
  }
}
Widget getSelectedWidget({required int index}){
  Widget widget;
  switch(index){
    case 0:
      widget = add_user();
      break;
    case 1:
      widget = manage_users();
      break;
    default:
      widget = history();
      break;
  }
  return widget;
}

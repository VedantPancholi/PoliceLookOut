import 'dart:async';
import 'dart:core';

import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

String? _url;

Future<Position?> getLiveLocation() async {
  try {
     Position? position = await Geolocator.getCurrentPosition();
     return position;
   // print("position :- ${position}");
    //print("Live Location :- ${position.latitude}, ${position.longitude}");




   // print(
      //  "Map Url :- https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}");
  } catch (error) {
  //  print("Error :-  ${error.toString()}");
  }
}

void launchURL(Uri _url) async {
  // const url = "https://www.google.com/maps/search/?api=1&query=23.0187396,72.5240466";

  if (await canLaunchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Could not launch $_url';
  }
}

openmap(String latitude , String longitude)
{
  try{
    Uri _url = Uri.parse("https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}");
    launchUrl(_url);
  }
  catch($error)
  {

  }

}

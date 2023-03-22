import 'dart:async';
import 'dart:core';

import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

String? _url;

void getLiveLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition();
    print("position :- ${position}");
    print("Live Location :- ${position.latitude}, ${position.longitude}");
    Timer _timer = Timer(const Duration(seconds: 10), () {
      getLiveLocation();
    });

    _url =
        "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}"
            .toString();

    print(
        "Map Url :- https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}");
  } catch (error) {
    print("Error :-  ${error.toString()}");
  }
}

void launchURL() async {
  // const url = "https://www.google.com/maps/search/?api=1&query=23.0187396,72.5240466";
  final uri = Uri.parse(_url!);


  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $_url';
  }
}

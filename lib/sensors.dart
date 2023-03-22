import 'package:flutter/material.dart';

class Sensor_info extends StatefulWidget {
  const Sensor_info({Key? key}) : super(key: key);

  @override
  State<Sensor_info> createState() => _Sensor_infoState();
}

class _Sensor_infoState extends State<Sensor_info> {
  double screenWidth = 0;
  double screenHeight = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sensor Information'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // const Text(
                //   'Sensor Information',
                //   style: TextStyle(
                //       fontSize: 30.0,
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold),
                // ),
                // Container(
                //   color: Colors.black,
                //   width: screenWidth,
                //   height: 1,
                //   margin: EdgeInsets.symmetric(vertical: 20),
                // ),
                SizedBox(
                  height: 10.0,
                ),
                item(
                    "assets/images/rfid.jpg",
                    "RFID sensor",
                    "Radio-frequency identification uses electromagnetic fields to automatically identify and track tags attached to objects.",
                    "Radio-frequency identification uses electromagnetic fields to automatically identify and track tags attached to objects. An RFID system consists of a tiny radio transponder, a radio receiver and transmitter. When triggered by an electromagnetic interrogation pulse from a nearby RFID reader device, the tag transmits digital data, usually an identifying inventory number, back to the reader. This number can be used to track inventory goods."),
                item(
                    "assets/images/ir.jpeg",
                    "IR sensor",
                    "A passive infrared sensor (PIR sensor) is an electronic sensor that measures infrared (IR) light radiating from objects in its field of view. ",
                    "A passive infrared sensor (PIR sensor) is an electronic sensor that measures infrared (IR) light radiating from objects in its field of view . They are most often used in PIR-based motion detectors. PIR sensors are commonly used in security alarms and automatic lighting applications PIR sensors detect general movement, but do not give information on who or what moved. For that purpose, an imaging IR sensor is required  PIR sensors are commonly called simply \"PIR\", or sometimes \"PID\", for \"passive infrared detector\" The term passive refers to the fact that PIR devices do not radiate energy for detection purposes. They work entirely by detecting infrared radiation (radiant heat) emitted by or reflected from objects."),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.home),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget item(String asset, String title, String desc, String fullDesc) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DetailScreen(asset: asset, tag: title, fullDesc: fullDesc)));
      },
      child: Container(
        height: screenHeight / 3.8,
        width: screenWidth,
        margin: EdgeInsets.only(bottom: screenWidth / 20),
        child: Row(
          children: [
            Hero(
              tag: title,
              child: Container(
                width: screenWidth / 2.5,
                height: screenHeight / 4.5,
                margin: EdgeInsets.only(right: screenWidth / 22),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    asset,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          desc,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {Key? key,
      required this.asset,
      required this.tag,
      required this.fullDesc})
      : super(key: key);
  final String asset;
  final String tag;
  final String fullDesc;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double screenWidth = 0;
  double screenHeight = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.tag,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                child: SizedBox(
                  height: screenHeight / 2.5,
                  width: screenWidth,
                  child: Image.asset(
                    widget.asset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 20,
                vertical: 20,
              ),
              child: Text(
                widget.tag,
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 20,
              ),
              child: Text(
                widget.fullDesc,
                style: TextStyle(
                    fontSize: 19.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

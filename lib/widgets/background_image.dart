import 'package:flutter/material.dart';
class background_image extends StatefulWidget {
  const background_image({Key? key}) : super(key: key);

  @override
  State<background_image> createState() => _background_imageState();
}
class _background_imageState extends State<background_image> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.black, Colors.black12],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ).createShader(bounds),
              blendMode: BlendMode.darken,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/backgroung_cover.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                    )),
              ),
            ),
          ),
        ]
    );
  }
}


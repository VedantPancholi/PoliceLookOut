import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pro/widgets/onBoarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFFEEF1F8),
      primarySwatch: Colors.blue,
      fontFamily: "Intel",
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(height: 0),
        border: defaultInputBorder,
        enabledBorder: defaultInputBorder,
        focusedBorder: defaultInputBorder,
        errorBorder: defaultInputBorder,
      ),
    ),
    home: const SplashScreen(),
  ));
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/images/location_1.json'),
      backgroundColor: Colors.blue.shade50,
      splashIconSize: 450,
      // splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(microseconds: 2500),
      nextScreen: const OnboardingScreen(),
    );
  }
}

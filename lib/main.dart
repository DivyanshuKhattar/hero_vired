import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hero_vired/CommonClasses/common_function.dart';
import 'package:hero_vired/Resources/color_picker.dart';
import 'package:hero_vired/Screens/Dashboard/dashboard_screen.dart';
import 'package:hero_vired/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());

  /// set portrait orientation for mobile app permanently
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  /// for white color app bar
  CommonFunction.lightStatusBarColor(whiteColor);
}

/// constant base url for all api
String baseUrl = "https://fakestoreapi.com/";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor primaryGreen = MaterialColor(
      0xFF417a4f,
      <int, Color>{
        50: greenColor,
        100: greenColor,
        200: greenColor,
        300: greenColor,
        400: greenColor,
        500: greenColor,
        600: greenColor,
        700: greenColor,
        800: greenColor,
        900: greenColor,
      },
    );
    return GetMaterialApp(
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        );
      },
      title: 'Hero Vired',
      theme: ThemeData(
        primarySwatch: primaryGreen,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        "/dashboard": (BuildContext context) => const DashboardScreen(),
      },
    );
  }
}

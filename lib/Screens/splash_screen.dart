import 'package:flutter/material.dart';
import 'package:hero_vired/Resources/color_picker.dart';
import 'package:hero_vired/Screens/Dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;

  @override
  void initState() {
    navigateUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// show splash screen for 2 secs and then move to dashboard page
  Future navigateUser() async{
    Future.delayed(const Duration(milliseconds: 2000), (){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const DashboardScreen()),
        ModalRoute.withName('/dashboard'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Image.asset(
          'assets/hero_vired.jpg',
          fit: BoxFit.fill,
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import '../constants/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void navigateToHomeScreen()
  {
    Routemaster.of(context).push("/HomeScreen");
  }
  @override
  void initState() {
    super.initState();
    // Navigate after 5 seconds
    Future.delayed(Duration(seconds: 3), () {
      navigateToHomeScreen();
      // Replace with your home screen route

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Center(child: Image.asset(Constants.background)),
            Padding(
              padding: const EdgeInsets.only(bottom: 100,left: 20,right: 20),
              child: Align(alignment:Alignment.bottomLeft,child: Image.asset(Constants.college)),
            ),
          ],
        ),
      ),

    );

  }
}
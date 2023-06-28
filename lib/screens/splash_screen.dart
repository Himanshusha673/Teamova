import 'dart:async';
import 'package:flutter/material.dart';
import 'package:team_builder/screens/mainScreen.dart';
// Replace with the appropriate screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Image.asset(
                'images/TeamovaHeaderStrip.png'), // Replace 'assets/logo.png' with your logo image path
          ),
        ),
      ),
    );
  }
}

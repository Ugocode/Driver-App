import 'dart:async';

import 'package:drivers_app/Authentication/registration_screen.dart';
// import 'package:drivers_app/Screens/bottom_navigation.dart';
// import 'package:drivers_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 6), () async {
      //to send user to home screen

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RegistrationScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'Assets/images/logo.png',
                height: 180,
                width: 220,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Flash Ryder for Drivers',
                style: GoogleFonts.getFont('Pacifico',
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.white)),
              )
            ],
          )),
        ),
      ),
    );
  }
}

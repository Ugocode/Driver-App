import 'package:drivers_app/Global/global.dart';
import 'package:drivers_app/Screens/splash_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: const Text(""),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: (() {
          fireAuth.signOut();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MySplashScreen()),
              (Route<dynamic> route) => false);
        }),
        child: const Text('SignOut'),
      )),
    );
  }
}

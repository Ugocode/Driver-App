import 'package:drivers_app/Authentication/login_screen.dart';
import 'package:drivers_app/Global/global.dart';
import 'package:drivers_app/Widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'car_registration.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  //to save the driver information to firebase datasbase we:
  saveDriverInfoNow() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return const ProgressDialog(
          message: "Processing, Please wait...",
        );
      }),
    );

    final User? firebaseUser = (await fireAuth
            .createUserWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
            .catchError((eMsg) {
      Navigator.pop(context);
      //show the error message
      Fluttertoast.showToast(msg: "⚠️ Error: \n$eMsg");
    }))
        .user;

    //to save the credentials to firebase database:
    if (firebaseUser != null) {
      //save to firestore
      Map driversMap = {
        "driverID": firebaseUser.uid,
        "diverName": _nameTextEditingController.text.trim(),
        "driverEmail": _emailTextEditingController.text.trim(),
        "driverPhone": _phoneTextEditingController.text.trim(),
      };
      //get the databse ref:
      // driversRef.child("drivers");
      driversRef.child(firebaseUser.uid).set(driversMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created!");
      // go to register your car:
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const CarRegistrationScreen()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "⚠️ Account has Not been created..");
    }
  }

//to validate  our form before saving data:
  validatForm() {
    if (_nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(
          msg: "⚠️ Name must be at least 3 characters long",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red);
    } else if (!_emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(
          msg: "⚠️ Email is badly formatted",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red);
    } else if (_passwordTextEditingController.text.length < 5) {
      Fluttertoast.showToast(
          msg: "⚠️ Password is too short",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red);
    } else if (_phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "⚠️ Phone number is required",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red);
    } else {
      //save the data to firesore
      saveDriverInfoNow();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset('Assets/images/drive.png'),
            const Text(
              'Register as a Driver',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.pink),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.name,
                  controller: _nameTextEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailTextEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: _phoneTextEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _passwordTextEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                validatForm();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const CarRegistrationScreen(),
                //   ),
                // );
              },
              child: const Text(
                'Create Account',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Already have an account?  Login'),
            )
          ],
        ),
      ),
    );
  }
}

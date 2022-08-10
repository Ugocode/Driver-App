import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'Assets/images/car.png',
            height: 250,
            width: 350,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Login as a Driver',
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
            onPressed: () {},
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      )),
    );
  }
}

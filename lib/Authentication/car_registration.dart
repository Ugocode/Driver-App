import 'package:flutter/material.dart';

class CarRegistrationScreen extends StatefulWidget {
  const CarRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<CarRegistrationScreen> createState() => _CarRegistrationScreenState();
}

class _CarRegistrationScreenState extends State<CarRegistrationScreen> {
  final TextEditingController _carModelTextEditingController =
      TextEditingController();
  final TextEditingController _carNumberTextEditingController =
      TextEditingController();
  final TextEditingController _carColorTextEditingController =
      TextEditingController();
  final TextEditingController _carNameTextEditingController =
      TextEditingController();

  List<String> carTypesList = ['Uber-x', 'Uber-go', 'bike'];
  String? selectedCarType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset('Assets/images/CarRR.png'),
              const Text(
                'Register Your Car',
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
                    keyboardType: TextInputType.text,
                    controller: _carModelTextEditingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Car Model',
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _carNumberTextEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Car Plate Number',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _carColorTextEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Car Color',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _carNameTextEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Car Name',
                  ),
                ),
              ),
              //make a drop down button:
              DropdownButton(
                  iconSize: 40,
                  iconEnabledColor: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.white54,
                  hint: const Text('Select a car type'),
                  value: selectedCarType,
                  items: carTypesList.map((car) {
                    return DropdownMenuItem(
                      value: car,
                      child: Text(car),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCarType = newValue.toString();
                    });
                  }),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const CarRegistrationScreen(),
                  //   ),
                  // );
                },
                child: const Text(
                  'Submit Now',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //     builder: (context) => const LoginScreen(),
              //     //   ),
              //     // );
              //   },
              //   child: const Text('Already have an account?  Login'),
              // )
            ],
          ),
        ));
  }
}

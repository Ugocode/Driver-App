import 'package:drivers_app/Screens/earning_screen.dart';
import 'package:drivers_app/Screens/home_screen.dart';
import 'package:drivers_app/Screens/profile_screen.dart';
import 'package:drivers_app/Screens/ratings_screen.dart';
import 'package:flutter/material.dart';

class MyBottomNavigatorPage extends StatefulWidget {
  const MyBottomNavigatorPage({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigatorPage> createState() => _MyBottomNavigatorPageState();
}

class _MyBottomNavigatorPageState extends State<MyBottomNavigatorPage> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    EarningsPage(),
    RattingsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        elevation: 50,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Earn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Rating',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[800],
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}

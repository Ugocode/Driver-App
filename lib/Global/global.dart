//import 'package:drivers_app/Models/users_model.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

final FirebaseAuth fireAuth = FirebaseAuth.instance;

DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");

final DatabaseReference usersRef =
    FirebaseDatabase.instance.ref().child("users");

User? currentFirebaseUser;
//UserModel? userModelCurrentInfo;

//strem substrcription
StreamSubscription<Position>? streamSubscriptionPosition;

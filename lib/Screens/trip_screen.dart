import 'dart:async';

import 'package:drivers_app/Models/user_ride_request_info.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Services/blacktheme_googlemap.dart';

class NewTripScreen extends StatefulWidget {
  UserRideRequestInformation? userRideRequestDetails;
  NewTripScreen({super.key, this.userRideRequestDetails});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  GoogleMapController? newTripGoogleMapController;

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  String? buttonTitle = "Arrived";
  Color? buttonColor = Colors.green;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Google map
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (controller) {
              _controllerGoogleMap.complete(controller);
              newTripGoogleMapController = controller;

              //black theme google map:
              blackThemeGoogleMap(newTripGoogleMapController);
            },
          ),
          //ui for online and off line driver:
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white30,
                      blurRadius: 18,
                      spreadRadius: .5,
                      offset: Offset(0.6, 0.6),
                    )
                  ]),
              child: Column(children: [
                //duration
                const Text(
                  "18 min",
                  style: TextStyle(
                      color: Colors.lightGreenAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 18,
                ),
                //user name - icon
                Row(
                  children: [
                    Text(
                      widget.userRideRequestDetails!.userName!,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreenAccent),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.phone_android),
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                //user pickup location with icon

                Row(
                  children: [
                    Image.asset(
                      'Assets/images/origin.png',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        widget.userRideRequestDetails!.originAddress!,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),

                //user Dropoff location with icon
                const SizedBox(
                  height: 20,
                ),

                //destination location
                Row(
                  children: [
                    Image.asset(
                      'Assets/images/destination.png',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        widget.userRideRequestDetails!.destinationAddress!,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: buttonColor!),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.directions_car,
                      color: Colors.white,
                      size: 25,
                    ),
                    label: Text(
                      buttonTitle!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ))
              ]),
            ),
          )
        ],
      ),
    );
  }
}

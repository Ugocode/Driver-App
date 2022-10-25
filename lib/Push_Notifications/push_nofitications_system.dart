import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:drivers_app/Global/global.dart';
import 'package:drivers_app/Models/user_ride_request_info.dart';
import 'package:drivers_app/Push_Notifications/notification_dialog_box.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async {
    //1. Terminted state
    //when the app is completely closed
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {}
    });

/////////////////////////////////////////////////////////////////////////////
    //2. Forground state
    //when the app is opned and in use:
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      print(
          "this is the remote message => \n ${remoteMessage!.data["rideRequestId"]}");

      //deisplay the ride request information = user information who requested the ride
      readUserRideRequestInformation(
          (remoteMessage.data["rideRequestId"]), context);
    });

/////////////////////////////////////////////////////////////////////////////
    //3. Background state
    //for when the app is in the background;
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      //desplay the ride request information = user information who requested the ride
      print(
          "this is the remote message => \n ${remoteMessage!.data["rideRequestId"]}");

      //deisplay the ride request information = user information who requested the ride
      readUserRideRequestInformation(
          remoteMessage.data["rideRequestId"], context);
    });
  }

//reide request function:
  readUserRideRequestInformation(
      String userRideRequestId, BuildContext context) {
    FirebaseDatabase.instance
        .ref()
        .child("All Ride Requests")
        .child(userRideRequestId)
        .once()
        .then((snapData) {
      if (snapData.snapshot.value != null) {
        audioPlayer.open(Audio("music/music_notification.mp3"));
        audioPlayer.play();

        double originLat = double.parse(
            (snapData.snapshot.value! as Map)["origin"]["latitude"].toString());
        double originLng = double.parse(
            (snapData.snapshot.value! as Map)["origin"]["longitude"]
                .toString());

        String originAddress =
            (snapData.snapshot.value! as Map)["originAddress"];

        //for destionation:
        double destinationLat = double.parse(
            (snapData.snapshot.value! as Map)["destination"]["latitude"]
                .toString());
        double destinationLng = double.parse(
            (snapData.snapshot.value! as Map)["destination"]["longitude"]
                .toString());

        String destinationAddress =
            (snapData.snapshot.value! as Map)["destinationAddress"];

        String userName = (snapData.snapshot.value! as Map)["userName"];
        String userPhone = (snapData.snapshot.value! as Map)["userPhone"];

        //create an instance to get the above attributes and values:
        UserRideRequestInformation userRideRequestDetails =
            UserRideRequestInformation();

        userRideRequestDetails.originLatLng = LatLng(originLat, originLng);
        userRideRequestDetails.originAddress = originAddress;

        userRideRequestDetails.destinationAddress = destinationAddress;
        userRideRequestDetails.destinationLatLng =
            LatLng(destinationLat, destinationLng);

        userRideRequestDetails.userName = userName;
        userRideRequestDetails.userPhone = userPhone;

        showDialog(
            context: context,
            builder: ((context) {
              return NotificationDialogBox(
                userRideRequestDetails: userRideRequestDetails,
              );
            }));
      } else {
        Fluttertoast.showToast(msg: "This RideRequest id do not exist");
      }
    });
  }

  //to generate token:
  Future generateAndGetToken() async {
    //get the registration token and apply:
    String? registrationToken = await messaging.getToken();

    print("FCM Registration token ::: $registrationToken");
    FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("token")
        .set(registrationToken);

    //now we subscribe to topics so our messagies can go to the users or drivers

    messaging.subscribeToTopic("allDrivers");
    messaging.subscribeToTopic("allUsers");
  }
}

import 'package:drivers_app/Global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging() async {
    //1. Terminted state
    //when the app is completely closed
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //deisplay the ride request information = user information who requested the ride
      }
    });

/////////////////////////////////////////////////////////////////////////////
    //2. Forground state
    //when the app is opned and in use:
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {});

/////////////////////////////////////////////////////////////////////////////
    //3. Background state
    //for when the app is in the background;
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      //desplay the ride request information = user information who requested the ride
    });
  }

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

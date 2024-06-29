import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:task_app/main.dart';
import 'package:task_app/old/notifcation_screen.dart';

class FirebaseNotifications {
  //create instance
  final _firebaseMessaging = FirebaseMessaging.instance;
  //initilaize notifications
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print("Token: $token");
    handleBackgraoundNotification();
  }
  //handle notifications when recieved
  void handleMessage(RemoteMessage? message) {
    if (message==null) return;
    navigatorKey.currentState!.pushNamed(NotifcationScreen.routeName, arguments: message);

  }

  //handle notifications when app is terminated
  Future handleBackgraoundNotification() async{
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    }
}
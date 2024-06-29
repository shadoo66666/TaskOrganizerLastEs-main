import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app/core/constants/app_strings.dart';
import 'package:task_app/feature/auth/screens/splash_screen.dart';
import 'package:task_app/core/services/local_notification_service.dart';
import 'package:task_app/feature/auth/screens/login_page.dart';
import 'package:task_app/old/notifcation_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await Future.wait([
    LocalNotificationService.init(),
  ]);
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        // theme: ThemeData.dark().copyWith(
        //   primaryColor: Colors.grey.shade900, // Set primary dark color
        // ),
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        home: SplashScreen(),
        routes: {
          '/notifications':(context) => const NotifcationScreen(),
              '/login': (context) => LoginPage(),

        },
      ),
    );
  }
}

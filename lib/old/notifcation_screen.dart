import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotifcationScreen extends StatelessWidget {
  static const String routeName = '/notifications';
  const NotifcationScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Column(children: [
        Text(message.notification!.title.toString()),
        Text(message.notification!.body.toString()),
        Text(message.data.toString()),
        
      ],),
    );
  }
}
import 'package:Lets_Change/widgets/notificaton_card.dart';
import 'package:flutter/material.dart';




class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: ListView(

          children: [NotificationCard()]),
    );
  }
}

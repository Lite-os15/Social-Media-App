import 'package:Lets_Change/widgets/post_card.dart';
import 'package:Lets_Change/Admin_Dashboard/admin_profile_screen.dart';
import 'package:Lets_Change/screens/notification_screen.dart';
import 'package:Lets_Change/screens/profile_screen.dart';
import 'package:Lets_Change/widgets/notificaton_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:AdminProfileScreen(),
      // ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),


    );
  }
}

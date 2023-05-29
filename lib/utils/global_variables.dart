

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/screens/activity_screen.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/camera_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/screens/graph_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';

const webScreenSize=600;
List<Widget> homeScreenItems = [
 FeedScreen(),
 SearchScreen(),
  const ActivityScreen(),
  const GraphScreen(),
 const Text('notifications'),
 //  ProfileScreen(
 //   uid: FirebaseAuth.instance.currentUser!.uid,
 // ),
];

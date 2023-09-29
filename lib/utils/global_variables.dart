

import 'package:Lets_Change/screens/activity_screen.dart';
import 'package:Lets_Change/screens/feed_screen.dart';
import 'package:Lets_Change/screens/graph_screen.dart';
import 'package:Lets_Change/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


const webScreenSize=600;
List<Widget> homeScreenItems = [
 const FeedScreen(),
 const SearchScreen(),
  const ActivityScreen(),
  const GraphScreen(),
 const Text('notifications'),
 //  ProfileScreen(
 //   uid: FirebaseAuth.instance.currentUser!.uid,
 // ),
];

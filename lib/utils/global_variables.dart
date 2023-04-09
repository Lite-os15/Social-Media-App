

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/home_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';

const webScreenSize=600;
List<Widget> homeScreenItems = [
const HomeScreen(),
const SearchScreen(),
const AddPostScreen(),
const Text('notifications'),
  //ProfileScreen(
   // uid: FirebaseAuth.instance.currentUser!.uid,
//  ),
];
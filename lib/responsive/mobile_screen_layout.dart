import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:instagram_clone/models/location.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/screens/activity_screen.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/camera_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/screens/graph_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/utils/colour.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:provider/provider.dart';


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

  //final GlobalKey<NavigatorState> navigatorKey;
  int _page = 0;
  late PageController pageController;

  int currentTab =0;
  final List screens = [
    SearchScreen(),
    ActivityScreen(),
    GraphScreen(),
    Location(),
    // ProfileScreen(),
    FeedScreen(),

  ];
  final List<GButton> bottomNavItems = [
    GButton(
      icon: Icons.home,
    ),
    GButton(
      icon: Icons.search,

    ),
    GButton(
      icon: Icons.notifications,

    ),
    GButton(
      icon: Icons.auto_graph,

    ),
    GButton(
      icon: Icons.perm_identity,

    ),
  ];
// for tabs animation
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = MobileScreenLayout();
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
    _page =page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CameraScreen(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(

              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:2, vertical:0),
            child: GNav(
              tabs: bottomNavItems,iconSize: 30,

              selectedIndex: _page,
              onTabChange: (index) {
                setState(() {
                  _page = index;
                });
                pageController.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );

  }

}

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:instagram_clone/models/location.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/screens/activity_screen.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/camera_screen.dart';
import 'package:instagram_clone/screens/graph_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:provider/provider.dart';


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
 // int index = 0;
  late PageController pageController;

  int currentTab =0;
  final List screens = [
    GraphScreen(),
    ActivityScreen(),
    SearchScreen(),
    Location(),

  ]; // for tabs animation
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

  // void onPageChanged(int page) {
  //   setState(() {
  //    int index=0;
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          //children: homeScreenItems,

      ),
      // appBar:
      // AppBar(backgroundColor: Colors.green,
      //   title: Text("Let's change"),
      //
      // ),



      bottomNavigationBar: GNav(iconSize:30,

        tabs: [//GestureDetector(onVerticalDragDown: ,)
         GButton(icon: Icons.home_outlined,


        ),
        GButton(icon: Icons.search,
          onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        ),
        ),
        GButton(icon: Icons.local_activity_outlined,
          onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ActivityScreen()
            ,
          ),
        ),
        ),

        GButton(icon: Icons.auto_graph,
          onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const GraphScreen(),
          ),
        ),
        ),
        GButton(icon: Icons.location_on_outlined,
        onPressed:() => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Location(),
          ),
        ) ,)
      ],
      backgroundColor: Colors.greenAccent,),
      floatingActionButton: FloatingActionButton(
        onPressed:  () => Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const CameraScreen(),
      ),
    ),
        child: Icon(Icons.add),
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );

  }

}

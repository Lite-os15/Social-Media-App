import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:instagram_clone/screens/activity_screen.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/graph_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/utils/global_variables.dart';

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
    AddPostScreen(),
    SearchScreen()
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
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(

      ),
      appBar: AppBar(backgroundColor: Colors.green,
        title: Text("Let's change")
      ),
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
        )
      ],
      backgroundColor: Colors.greenAccent,),
      floatingActionButton: FloatingActionButton(onPressed:  () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddPostScreen(),
      ),
    ),
        child: Icon(Icons.add),
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );

  }

}

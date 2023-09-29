import 'package:flutter/material.dart';


import '../screens/activity_screen.dart';
import '../screens/camera_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/graph_screen.dart';
import '../screens/search_screen.dart';
import '../widgets/floating_button.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  final List<Widget> screens = [
    const FeedScreen(),
    const SearchScreen(),
    const ActivityScreen(),
    const GraphScreen(),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line to prevent resizing

      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (int page) {
          setState(() {
            _page = page;
          });
        },
        children: screens,
      ),
      floatingActionButton:
      FloatingActionButton(
        clipBehavior: Clip.none,

        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CameraScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        elevation: 10,

        height: MediaQuery.of(context).size.height *0.07,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                setState(() {
                  _page = 0;
                });
                pageController.jumpToPage(_page);
              },
            ),
            IconButton(
              icon: const Icon(Icons.search,),
              onPressed: () {
                setState(() {
                  _page = 1;
                });
                pageController.jumpToPage(_page);
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                setState(() {
                  _page = 2;
                });
                pageController.jumpToPage(_page);
              },
            ),
            IconButton(
              icon: const Icon(Icons.auto_graph),
              onPressed: () {
                setState(() {
                  _page = 3;
                });
                pageController.jumpToPage(_page);
              },
            ),

          ],
        ),
      ),
    );
  }
}

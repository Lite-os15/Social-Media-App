
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colour.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  final int _page = 0;
  late PageController pageController; // for tabs animation

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
     int _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }
  

 


  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return  Scaffold(
      body: PageView(
        //children: ,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: webBackgroundColor,
          items: const [
            BottomNavigationBarItem(
                icon:Icon(Icons.home_outlined,
                //    color: _page == 0 ? primaryColor : secondaryColor
                ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.search,
              //    color:  _page == 1 ? primaryColor : secondaryColor
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.add_circle_outline_sharp,
              //    color:  _page == 2 ? primaryColor : secondaryColor
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.favorite,
                //  color:  _page == 3 ? primaryColor : secondaryColor
                   ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.person,
             //     color:  _page == 4 ? primaryColor : secondaryColor
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
          ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );

  }
}

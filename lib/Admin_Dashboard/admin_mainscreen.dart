//
import 'package:Lets_Change/Admin_Dashboard/dashboard.dart';
import 'package:Lets_Change/Admin_Dashboard/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin_sidemenu.dart';



class MainScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MainScreen({super.key, required this.navigatorKey});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            //We want SideMenu if it is desktop
            if(Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: AdminSideMenu(navigatorKey: _navigatorKey,),
              ),
            Expanded(
                flex: 5,
                child:
                Navigator(
                  key: _navigatorKey,
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (context) => Dashboard(),
                    );
                  },
                ),
            ),

          ],
        ),
      ),

    );
  }
}


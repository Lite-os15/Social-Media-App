import 'package:Lets_Change/Admin_Dashboard/dashboard.dart';
import 'package:Lets_Change/screens/admin_profile_screen.dart';
import 'package:Lets_Change/screens/group_screen.dart';
import 'package:Lets_Change/screens/map_screen.dart';
import 'package:Lets_Change/widgets/muncipal_leaderboard_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AdminSideMenu extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  AdminSideMenu({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                "Let's Change",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          ListTile(
            title: Text("Dashboard"),
            leading: Icon(Icons.dashboard_outlined),
            onTap: () {
              navigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            },
          ),
          ListTile(
            title: Text("Leaderboard"),
            leading: Icon(CupertinoIcons.list_bullet_indent),
            onTap: () {
              navigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => Leaderboard()),
              );
            },
          ),
          ListTile(
            title: Text("Profile"),
            leading: Icon(CupertinoIcons.profile_circled),
            onTap: () {
              navigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => AdminProfileScreen()),
              );
            },
          ),
          ListTile(
            title: Text("Members"),
            leading: Icon(CupertinoIcons.group_solid),
            onTap: () {
              navigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => GroupScreen()),
              );
            },
          ),
          ListTile(
            title: Text("Notification"),
            leading: Icon(Icons.notification_add),
            onTap: () {
              navigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => MapScreen()),
              );
            },
          ),
          ListTile(
            title: Text("Settings"),
            leading: Icon(Icons.settings),
            onTap: () {},
          ),
          ListTile(
            title: Text("Contact us"),
            leading: Icon(CupertinoIcons.info),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
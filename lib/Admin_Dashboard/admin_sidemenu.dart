import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminSideMenu extends StatelessWidget {
  const AdminSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child:Center(
              child: Text(
                "Let's Change",
                style: TextStyle(fontWeight: FontWeight.w500
                  ,fontSize: 25,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          ListTile(
            title: Text("Dashboard"),
            leading:Icon(Icons.dashboard_outlined),
            onTap: () {},
          ),
          ListTile(
            title: Text("Leaderboard"),
            leading: Icon(CupertinoIcons.list_bullet_indent),
            onTap: () {},
          ),
          ListTile(
            title: Text("Profile"),
            leading: Icon(CupertinoIcons.profile_circled),
            onTap: () {},
          ),
          ListTile(
            title: Text("Members"),
            leading: Icon(CupertinoIcons.group_solid),
            onTap: () {},
          ),
          ListTile(
            title: Text("Notification"),
            leading: Icon(Icons.notification_add),
            onTap: () {},
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

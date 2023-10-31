import 'package:Lets_Change/screens/notification_screen.dart';
import 'package:Lets_Change/screens/side_menu.dart';
import 'package:Lets_Change/widgets/following_issue_tab.dart';
import 'package:Lets_Change/widgets/nearby_issues_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/old_post_card.dart';
import 'map_screen.dart';

class FeedScreen extends StatefulWidget {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with TickerProviderStateMixin {
  // @override
  // void initState() {
  //   tabController = TabController(
  //     vsync: this,
  //     length: 2,
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: false,
        title: const Text('Lets Change'),
        //color: primaryColor,
        //height: 32,
        actions: [
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationScreen())),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.notifications),
              )),
          InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MapScreen())),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.map_rounded),
              )),
        ],
      ),

      drawer: Drawer(
          child: SideMenu(
        uid: FirebaseAuth.instance.currentUser!.uid,
      )),

      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(
                child: Text(
                  'Nearby Issues',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Friends Issues',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ]),
            Expanded(
                child: TabBarView(
              children: [
                NearbyIssuesTab(),
                FollowingIssueTab(),
              ],
            ))
          ],
        ),
      ),

      // StreamBuilder(
      //   stream: FirebaseFirestore.instance.
      //   collection('posts').
      //   orderBy(
      //     'datePublished',
      //     descending: true)
      //       .snapshots(),
      //   builder: (context,
      //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     return ListView.builder(
      //       itemCount: snapshot.data!.docs.length,
      //       itemBuilder: (ctx, index) => Container(
      //         // margin: EdgeInsets.symmetric(
      //         //   // horizontal: width > webScreenSize ? width * 0.3 : 0,
      //         //   // vertical: width > webScreenSize ? 15 : 0,
      //         // ),
      //         child: PostCard(
      //           snap: snapshot.data!.docs[index].data(),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      //   ],
      // ),
    );
  }
}

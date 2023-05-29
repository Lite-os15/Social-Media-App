import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/screens/map_screen.dart';
import 'package:instagram_clone/utils/colour.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/widgets/post_card.dart';
import 'package:instagram_clone/screens/side_menu.dart';


class FeedScreen extends StatelessWidget {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(


        appBar:
        AppBar(
          backgroundColor: Colors.green,
          centerTitle: false,
          title: Text('Lets Change'),
            //color: primaryColor,
            //height: 32,
          actions: [
            InkWell(onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MapScreen())),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.map_rounded),
                )
            )
          ],
        ),

    drawer:Drawer(
            child: SideMenu(uid: FirebaseAuth.instance.currentUser!.uid,)
        ),








    body: StreamBuilder(
      stream: FirebaseFirestore.instance.
      collection('posts').
      orderBy(
        'datePublished',
        descending: true)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (ctx, index) => Container(
            // margin: EdgeInsets.symmetric(
            //   // horizontal: width > webScreenSize ? width * 0.3 : 0,
            //   // vertical: width > webScreenSize ? 15 : 0,
            // ),
            child: PostCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          ),
        );
      },
    ),

    );


  }
}

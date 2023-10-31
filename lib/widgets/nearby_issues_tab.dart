import 'package:Lets_Change/screens/Issue_solve_screen.dart';
import 'package:Lets_Change/widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

import 'old_post_card.dart';

class NearbyIssuesTab extends StatefulWidget {
  const NearbyIssuesTab({super.key});

  @override
  State<NearbyIssuesTab> createState() => _NearbyIssuesTabState();

}

class _NearbyIssuesTabState extends State<NearbyIssuesTab> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();


  Future<void> _refreshData() async{
    StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => Container(
                child: PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              ),
            );
          } else {
            // Display a message when there is no data.
            return Center(child: Text('                Congrats!!!! \n'
                'There are no More Further Issues'));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Container(
                  child: PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            } else {
              // Display a message when there is no data.
              return Center(
                child: Text('Congrats!!!! There are no More Further Issues'),
              );
            }
          },
        ),
      ),
    );
      // StreamBuilder(
      //     stream: FirebaseFirestore.instance
      //         .collection('posts')
      //         .orderBy('datePublished', descending: true)
      //         .snapshots(),
      //     builder: (context,
      //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //
      //       if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      //         return ListView.builder(
      //           itemCount: snapshot.data!.docs.length,
      //           itemBuilder: (ctx, index) => Container(
      //             child: PostCard(
      //               snap: snapshot.data!.docs[index].data(),
      //             ),
      //           ),
      //         );
      //       } else {
      //         // Display a message when there is no data.
      //         return Center(child: Text('                Congrats!!!! \n'
      //             'There are no More Further Issues'));
      //       }
      //     }),

  }
}

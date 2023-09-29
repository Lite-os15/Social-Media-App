import 'package:Lets_Change/widgets/post_card.dart';
import 'package:Lets_Change/widgets/old_post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class FollowingIssueTab extends StatefulWidget {
  const FollowingIssueTab({super.key});

  @override
  State<FollowingIssueTab> createState() => _FollowingIssueTabState();
}

class _FollowingIssueTabState extends State<FollowingIssueTab> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

              child: OldPostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}

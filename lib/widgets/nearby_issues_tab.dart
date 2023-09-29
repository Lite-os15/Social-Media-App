import 'package:Lets_Change/widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'old_post_card.dart';



class NearbyIssuesTab extends StatefulWidget {
  const NearbyIssuesTab({super.key});

  @override
  State<NearbyIssuesTab> createState() => _NearbyIssuesTabState();
}

class _NearbyIssuesTabState extends State<NearbyIssuesTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


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

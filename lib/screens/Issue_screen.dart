import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';



class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {


  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('datePublished')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              final posts = snapshot.data?.docs ?? [];
              return StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Image.network(
                    post['postUrl'] as String,
                    fit: BoxFit.cover,
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.count(
                  index % 7 == 0 ? 1 : 1,
                  index % 7 == 0 ? 2 : 1,
                ),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              );
            },
          ),
        )
    );
  }
}

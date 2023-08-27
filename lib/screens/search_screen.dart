import 'package:Lets_Change/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(labelText: 'Search for a user...'),
            onFieldSubmitted: (String value) {
              setState(() {
                isShowUsers = true;
              });
              debugPrint(value);
            },
          ),
        ),
      ),
      body: isShowUsers
          ? FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('username', isGreaterThanOrEqualTo: searchController.text)
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
          final users = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      uid: user['uid'] as String,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user['photoUrl'] as String),
                    radius: 16,
                  ),
                  title: Text(user['username'] as String),
                ),
              );
            },
          );
        },
      )
          : FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('posts').orderBy('datePublished').get(),
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
    );
  }
}

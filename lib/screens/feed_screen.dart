import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/colour.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/widgets/post_card.dart';


class FeedScreen extends StatelessWidget {
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
            IconButton(onPressed: (){}, icon:const Icon(Icons.message_outlined))
          ],
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
            margin: EdgeInsets.symmetric(
              // horizontal: width > webScreenSize ? width * 0.3 : 0,
              // vertical: width > webScreenSize ? 15 : 0,
            ),
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

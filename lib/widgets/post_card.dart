import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colour.dart';



class PostCard extends StatelessWidget {
  const PostCard({Key? key, required Map<String, dynamic> snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ),
          )
        ],
      ),
    );
  }
}

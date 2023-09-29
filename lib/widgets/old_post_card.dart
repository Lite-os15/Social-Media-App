import 'package:Lets_Change/models/user.dart';
import 'package:Lets_Change/providers/user_provider.dart';
import 'package:Lets_Change/utils/utils.dart';
import 'package:Lets_Change/widgets/like_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../resources/firestore_methods.dart';
import '../screens/comments_screen.dart';

class OldPostCard extends StatefulWidget {
  final snap;

  const OldPostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<OldPostCard> createState() => _OldPostCardState();
}

class _OldPostCardState extends State<OldPostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    getComments();
    super.initState();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    // setState(() {
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserProvider>(context).getUser;
    return Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
        // color: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),

                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      //adding profile image to the postcard
                      backgroundImage: NetworkImage(
                        widget.snap['profImage'] ?? 'Error ',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.snap['username'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.snap['address'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shrinkWrap: true,
                              children: [
                                const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ]
                                  .map(
                                    (e) => InkWell(
                                      onTap: () async {
                                        // showDialogBox(context);
                                        if (FirebaseAuth.instance.currentUser !=
                                            null) {
                                          FireStoreMethods()
                                              .deletePost(widget.snap['postId']);
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.more_vert))
                ],
              ),
            ),


            //DESCRIPTION OF POST
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 15),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: widget.snap['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      TextSpan(
                        text: widget.snap['description'],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //IMAGE SECTION
            GestureDetector(
              onDoubleTap: () async {
                await FireStoreMethods().likePost(widget.snap['postId'],
                    widget.snap['uid'], widget.snap['likes']);
                setState(() {
                  isLikeAnimating = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    child: Image.network(
                      widget.snap['postUrl'] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),



            //LIKE COMMENT SECTION
            Row(
              children: <Widget>[
                LikeAnimation(
                  isAnimating: widget.snap['likes'].contains(user?.uid),
                  smallLike: true,
                  child: IconButton(
                    onPressed: () async {
                      await FireStoreMethods().likePost(
                          widget.snap['postId'].toString(),
                          widget.snap['uid'],
                          widget.snap['likes']);
                    },
                    icon: widget.snap['likes'].contains(user?.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border_outlined,
                          ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      snap: widget.snap,
                    ),
                  )),
                  icon: const Icon(
                    Icons.comment_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                  ),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ))
              ],
            ),



            // DESCRIPTON AND NUMBER OF COMMENTS
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text('${widget.snap['likes'].length} likes',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        snap: widget.snap,
                      ),
                    )),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'View all $commentLen comments',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style:
                          const TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // decoration: BoxDecoration(
        //   boxShadow:
        // ),
      ),
    );
  }


  void showDialogBox(BuildContext context){
    AlertDialog(
      title: const Center(child: Text('Do you want to Delete?')),
      // titlePadding: EdgeInsetsGeometry.infinity,
      elevation: 15,
      actionsAlignment: MainAxisAlignment.spaceBetween,

      actions: [
        ElevatedButton(
            onPressed: () {},
            child: const Text('Yes')
        ),
        ElevatedButton(onPressed: (){},
            child: const Text('No')),
      ],
    );

  }


}

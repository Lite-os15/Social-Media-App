import 'package:Lets_Change/models/user.dart';
import 'package:Lets_Change/providers/user_provider.dart';
import 'package:Lets_Change/resources/firestore_methods.dart';
import 'package:Lets_Change/screens/Issue_solve_screen.dart';
import 'package:Lets_Change/screens/comments_screen.dart';
import 'package:Lets_Change/screens/reply_post_screen.dart';
import 'package:Lets_Change/utils/utils.dart';
import 'package:Lets_Change/widgets/like_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String buttonText = "Pending";
  Color buttonColor = Colors.orangeAccent;

  bool isLikeAnimating = false;
  int commentLen = 0;

  void changeButtonState() {
    setState(() {
      buttonText = (buttonText == "Pending")
          ? "Accepted"
          : (buttonText == "Accepted")
              ? "Rejected"
              : (buttonText == "Rejected")
                  ? "In Progress"
                  : (buttonText == "In Progress")
                      ? "Completed"
                      : "Pending";

      buttonColor = (buttonText == "Pending")
          ? Colors.orangeAccent
          : (buttonText == "Accepted")
              ? Colors.greenAccent
              : (buttonText == "Rejected")
                  ? Colors.redAccent
                  : (buttonText == "In Progress")
                      ? Colors.yellow
                      : Colors.lightBlueAccent;
    });
  }

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
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.greenAccent,
                Colors.lightBlueAccent
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: CupertinoColors.systemGrey2,
                      backgroundImage: NetworkImage(widget.snap['profImage'] ??
                          'https://www.pngitem.com/pimgs/m/504-5040528_empty-profile-picture-png-transparent-png.png'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.snap['address'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        _showDeleteDialog(context);
                        // CupertinoAlertDialog(
                        //
                        //   title: Text('Delete'),
                        //       actions: [
                        //         const Text(
                        //           'Delete',
                        //           style: TextStyle(
                        //             color: Colors.black,
                        //           ),
                        //         )
                        //       ]
                        //           .map(
                        //             (e) => InkWell(
                        //           onTap: () async {
                        //             // showDialogBox(context);
                        //             if (FirebaseAuth.instance.currentUser !=
                        //                 true) {
                        //               FireStoreMethods()
                        //                   .deletePost(widget.snap['postId']);
                        //               Navigator.of(context).pop();
                        //             }
                        //           },
                        //
                        //         ),
                        //       )
                        //           .toList(),
                        //
                        //
                        // );
                      },
                      icon: const Icon(Icons.more_vert))
                ],
              ),
              Divider(
                thickness: 5,
              ),
              // RichText(
              //   text: TextSpan(children: <TextSpan>[
              //     TextSpan(text: 'UserName '),
              //     TextSpan(
              //         text:
              //             "Life has got all those twists and turns. You've got to hold on tight and off you go.",
              //         style: TextStyle()),
              //   ]),
              // ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                child: Text(widget.snap['description']),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    NetworkImage(widget.snap['postUrl'] ?? ''),
                              ),
                              color: Colors.grey.shade300),
                          height: 300,
                          width: MediaQuery.of(context).size.width * 0.85,
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isLikeAnimating ? 1 : 0,
                          child: LikeAnimation(
                            isAnimating: isLikeAnimating,
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            onEnd: () {
                              setState(() {
                                isLikeAnimating = false;
                              });
                            },
                            child: const Icon(
                              Icons.energy_savings_leaf,
                              color: Colors.greenAccent,
                              size: 100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Like Share and Comment button
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            LikeAnimation(
                              isAnimating:
                                  widget.snap['likes'].contains(user?.uid),
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
                                        Icons.energy_savings_leaf,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        Icons.energy_savings_leaf_outlined,
                                      ),
                              ),
                            ),
                            Text('${widget.snap['likes'].length} ',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                          mainAxisSize: MainAxisSize.min,
                        ),
                        // SizedBox(width: 40,),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CommentsScreen(
                                  snap: widget.snap,
                                ),
                              )),
                              icon: const Icon(
                                Icons.comment_outlined,
                              ),
                            ),
                            Text('$commentLen')
                          ],
                        ),
                        // SizedBox(width: 40,),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                              ),
                            ),
                            Text('Share')
                          ],
                        ),
                      ],
                    ),
                  ),
                  //TODO:This onTap function is temporary till backend is not connected at user side
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: MaterialButton(
                      onPressed: changeButtonState,
                      child: Text(buttonText),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minWidth: double.infinity,
                      color: buttonColor,
                    ),
                  ),

                  Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Divider(
                    thickness: 3,
                    height: 0,
                  ),

                  TextButton(
                    child: Text(
                      'Mark as Solved',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ReplyPostScreen(snap: widget.snap,))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Delete Content"),
          content: Text("Are you sure you want to delete this content?"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("Delete"),
              isDestructiveAction: true,
              onPressed: () async {
                // showDialogBox(context);
                if (FirebaseAuth.instance.currentUser != null) {
                  FireStoreMethods().deletePost(widget.snap['postId']);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

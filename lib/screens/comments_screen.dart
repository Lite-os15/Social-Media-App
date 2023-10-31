
import 'package:Lets_Change/providers/user_provider.dart';
import 'package:Lets_Change/resources/firestore_methods.dart';
import 'package:Lets_Change/widgets/comment_card.dart';
import 'package:Lets_Change/widgets/like_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserProvider>(context).getUser;



    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),

      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height*10,
          child: Column(
            children: [

              // Card at the top

              // TreeView(
              //
              //   indent: 15,
              //   nodes: [
              //     TreeNode(
              //       content:  Expanded(
              //         child: Card(
              //           margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              //           shape: RoundedRectangleBorder(
              //               side: BorderSide(color: Colors.grey.withOpacity(0.5)),
              //               borderRadius: BorderRadius.circular(25)
              //           ),
              //           elevation: 15,
              //           // You can change the color here
              //           child: Column(
              //             children: [
              //               Container(
              //                 padding: const EdgeInsets.symmetric(
              //                   vertical: 4,
              //                   horizontal: 16,
              //                 ).copyWith(right: 0),
              //                 child: Row(
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.all(0),
              //
              //                       child: CircleAvatar(
              //                         radius: 25,
              //                         backgroundColor: Colors.grey,
              //                         //adding profile image to the postcard
              //                         backgroundImage: NetworkImage(
              //                           widget.snap['profImage'] ?? 'Error ',
              //                         ),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: Padding(
              //                         padding: const EdgeInsets.only(
              //                           left: 10,
              //                         ),
              //                         child: Column(
              //                           mainAxisSize: MainAxisSize.min,
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           children: [
              //                             Text(
              //                               widget.snap['username'],
              //                               style: const TextStyle(fontWeight: FontWeight.bold),
              //                             ),
              //                             Text(
              //                               widget.snap['address'],
              //                               style: const TextStyle(fontWeight: FontWeight.bold),
              //                             )
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                     IconButton(
              //                         onPressed: () {
              //                           showDialog(
              //                             context: context,
              //                             builder: (context) => Dialog(
              //                               child: ListView(
              //                                 padding: const EdgeInsets.symmetric(
              //                                   vertical: 16,
              //                                 ),
              //                                 shrinkWrap: true,
              //                                 children: [
              //                                   const Text(
              //                                     'Delete',
              //                                     style: TextStyle(
              //                                       color: Colors.black,
              //                                     ),
              //                                   )
              //                                 ]
              //                                     .map(
              //                                       (e) => InkWell(
              //                                     onTap: () async {
              //                                       // showDialogBox(context);
              //                                       if (FirebaseAuth.instance.currentUser !=
              //                                           null) {
              //                                         FireStoreMethods()
              //                                             .deletePost(widget.snap['postId']);
              //                                         Navigator.of(context).pop();
              //                                       }
              //                                     },
              //                                     child: Container(
              //                                       padding: const EdgeInsets.symmetric(
              //                                           vertical: 12, horizontal: 16),
              //                                     ),
              //                                   ),
              //                                 )
              //                                     .toList(),
              //                               ),
              //                             ),
              //                           );
              //                         },
              //                         icon: const Icon(Icons.more_vert))
              //                   ],
              //                 ),
              //               ),
              //
              //
              //               //DESCRIPTION OF POST
              //               Padding(
              //                 padding: const EdgeInsets.only(left: 20, bottom: 15),
              //                 child: Container(
              //                   width: double.infinity,
              //                   padding: const EdgeInsets.only(
              //                     top: 8,
              //                   ),
              //                   child: RichText(
              //                     text: TextSpan(
              //                       style: const TextStyle(color: Colors.black),
              //                       children: [
              //                         TextSpan(
              //                           text: widget.snap['username'],
              //                           style: const TextStyle(fontWeight: FontWeight.bold),
              //                         ),
              //
              //                         TextSpan(
              //                           text: widget.snap['description'],
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               //IMAGE SECTION
              //               GestureDetector(
              //                 onDoubleTap: () async {
              //                   await FireStoreMethods().likePost(widget.snap['postId'],
              //                       widget.snap['uid'], widget.snap['likes']);
              //                   setState(() {
              //                     isLikeAnimating = true;
              //                   });
              //                 },
              //                 child: Stack(
              //                   alignment: Alignment.center,
              //                   children: [
              //                     SizedBox(
              //                       height: MediaQuery.of(context).size.height * 0.39,
              //                       width: double.infinity,
              //                       child: Image.network(
              //                         widget.snap['postUrl'] ?? '',
              //                         fit: BoxFit.cover,
              //                       ),
              //                     ),
              //                     AnimatedOpacity(
              //                       duration: const Duration(milliseconds: 200),
              //                       opacity: isLikeAnimating ? 1 : 0,
              //                       child: LikeAnimation(
              //                         isAnimating: isLikeAnimating,
              //                         duration: const Duration(
              //                           milliseconds: 400,
              //                         ),
              //                         onEnd: () {
              //                           setState(() {
              //                             isLikeAnimating = false;
              //                           });
              //                         },
              //                         child: const Icon(
              //                           Icons.favorite,
              //                           color: Colors.white,
              //                           size: 100,
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //
              //
              //
              //               //LIKE COMMENT SECTION
              //               Row(
              //                 children: <Widget>[
              //                   LikeAnimation(
              //                     isAnimating: widget.snap['likes'].contains(user?.uid),
              //                     smallLike: true,
              //                     child: IconButton(
              //                       onPressed: () async {
              //                         await FireStoreMethods().likePost(
              //                             widget.snap['postId'].toString(),
              //                             widget.snap['uid'],
              //                             widget.snap['likes']);
              //                       },
              //                       icon: widget.snap['likes'].contains(user?.uid)
              //                           ? const Icon(
              //                         Icons.favorite,
              //                         color: Colors.red,
              //                       )
              //                           : const Icon(
              //                         Icons.favorite_border_outlined,
              //                       ),
              //                     ),
              //                   ),
              //                   IconButton(
              //                     onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              //                       builder: (context) => CommentsScreen(
              //                         snap: widget.snap,
              //                       ),
              //                     )),
              //                     icon: const Icon(
              //                       Icons.comment_outlined,
              //                     ),
              //                   ),
              //                   IconButton(
              //                     onPressed: () {},
              //                     icon: const Icon(
              //                       Icons.share,
              //                     ),
              //                   ),
              //                   Expanded(
              //                       child: Align(
              //                         alignment: Alignment.bottomRight,
              //                         child: IconButton(
              //                           icon: const Icon(Icons.bookmark_border),
              //                           onPressed: () {},
              //                         ),
              //                       ))
              //                 ],
              //               ),
              //
              //
              //
              //               // DESCRIPTON AND NUMBER OF COMMENTS
              //               Container(
              //                 padding: const EdgeInsets.symmetric(
              //                   horizontal: 16,
              //                 ),
              //                 child: Column(
              //                   mainAxisSize: MainAxisSize.min,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     DefaultTextStyle(
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .titleSmall!
              //                           .copyWith(fontWeight: FontWeight.w800),
              //                       child: Text('${widget.snap['likes'].length} likes',
              //                           style: Theme.of(context).textTheme.bodyMedium),
              //                     ),
              //                     Container(
              //                       width: double.infinity,
              //                       padding: const EdgeInsets.only(
              //                         top: 8,
              //                       ),
              //                     ),
              //                     InkWell(
              //                       onTap: () => Navigator.of(context).push(MaterialPageRoute(
              //                         builder: (context) => CommentsScreen(
              //                           snap: widget.snap,
              //                         ),
              //                       )),
              //                       child: Container(
              //                         padding: const EdgeInsets.symmetric(vertical: 4),
              //                         child: Text(
              //                           'View all $commentLen comments',
              //                           style: const TextStyle(
              //                             fontSize: 16,
              //                             color: Colors.blueGrey,
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                     Container(
              //                       padding: const EdgeInsets.symmetric(vertical: 4),
              //                       child: Text(
              //                         DateFormat.yMMMd()
              //                             .format(widget.snap['datePublished'].toDate()),
              //                         style:
              //                         const TextStyle(fontSize: 16, color: Colors.blueGrey),
              //                       ),
              //                     ),
              //                     // ElevatedButton(onPressed: (){_issuesolvedreply(context);}, child: Text('Issue Solved'),style: ButtonStyle(),)
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //
              //         ),
              //       ),
              //       children: [
              //         TreeNode(
              //           content:
              //              Expanded(
              //                child: Card(
              //                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              //                  shape: RoundedRectangleBorder(
              //                      side: BorderSide(color: Colors.grey.withOpacity(0.5)),
              //                      borderRadius: BorderRadius.circular(25)
              //                  ),
              //                  elevation: 15,
              //                  // You can change the color here
              //                  child: Column(
              //                    children: [
              //                     ListTile(
              //                       leading: CircleAvatar(),
              //                       title: Text('Username'),
              //                       subtitle: Text('Location'),
              //                       trailing: Text('Muncipal Corporation'),
              //                     ),
              //                      Divider(height: 1,thickness: 5,),
              //
              //
              //                      //DESCRIPTION OF POST
              //                      RichText(
              //                        text: TextSpan(
              //                          style: const TextStyle(color: Colors.black),
              //                          children: [
              //                            TextSpan(
              //                              text: widget.snap['description'],
              //                            ),
              //                          ],
              //                        ),
              //                      ),
              //                      //IMAGE SECTION
              //                      GestureDetector(
              //                        onDoubleTap: () async {
              //                          await FireStoreMethods().likePost(widget.snap['postId'],
              //                              widget.snap['uid'], widget.snap['likes']);
              //                          setState(() {
              //                            isLikeAnimating = true;
              //                          });
              //                        },
              //                        child: Stack(
              //                          alignment: Alignment.center,
              //                          children: [
              //                            SizedBox(
              //                              height: MediaQuery.of(context).size.height * 0.39,
              //                              width: double.infinity,
              //                              child: Image.network(
              //                                 'https://cleanmanagement.com/wp-content/uploads/2022/02/CleanManagementEnvironmentalGroup-106513-Waste-Cleanup-Essential-Image1.jpg',
              //                                fit: BoxFit.cover,
              //                              ),
              //                            ),
              //                            AnimatedOpacity(
              //                              duration: const Duration(milliseconds: 200),
              //                              opacity: isLikeAnimating ? 1 : 0,
              //                              child: LikeAnimation(
              //                                isAnimating: isLikeAnimating,
              //                                duration: const Duration(
              //                                  milliseconds: 400,
              //                                ),
              //                                onEnd: () {
              //                                  setState(() {
              //                                    isLikeAnimating = false;
              //                                  });
              //                                },
              //                                child: const Icon(
              //                                  Icons.favorite,
              //                                  color: Colors.white,
              //                                  size: 100,
              //                                ),
              //                              ),
              //                            ),
              //                          ],
              //                        ),
              //                      ),
              //
              //
              //
              //                      //LIKE COMMENT SECTION
              //                      Row(
              //                        children: <Widget>[
              //                          LikeAnimation(
              //                            isAnimating: widget.snap['likes'].contains(user?.uid),
              //                            smallLike: true,
              //                            child: IconButton(
              //                              onPressed: () async {
              //                                await FireStoreMethods().likePost(
              //                                    widget.snap['postId'].toString(),
              //                                    widget.snap['uid'],
              //                                    widget.snap['likes']);
              //                              },
              //                              icon: widget.snap['likes'].contains(user?.uid)
              //                                  ? const Icon(
              //                                Icons.favorite,
              //                                color: Colors.red,
              //                              )
              //                                  : const Icon(
              //                                Icons.favorite_border_outlined,
              //                              ),
              //                            ),
              //                          ),
              //                          IconButton(
              //                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              //                              builder: (context) => CommentsScreen(
              //                                snap: widget.snap,
              //                              ),
              //                            )),
              //                            icon: const Icon(
              //                              Icons.comment_outlined,
              //                            ),
              //                          ),
              //                          IconButton(
              //                            onPressed: () {},
              //                            icon: const Icon(
              //                              Icons.share,
              //                            ),
              //                          ),
              //
              //                        ],
              //                      ),
              //
              //
              //
              //                      // DESCRIPTON AND NUMBER OF COMMENTS
              //                      Container(
              //                        padding: const EdgeInsets.symmetric(
              //                          horizontal: 16,
              //                        ),
              //                        child: Column(
              //                          mainAxisSize: MainAxisSize.min,
              //                          crossAxisAlignment: CrossAxisAlignment.start,
              //                          children: [
              //                            DefaultTextStyle(
              //                              style: Theme.of(context)
              //                                  .textTheme
              //                                  .titleSmall!
              //                                  .copyWith(fontWeight: FontWeight.w800),
              //                              child: Text('${widget.snap['likes'].length} likes',
              //                                  style: Theme.of(context).textTheme.bodyMedium),
              //                            ),
              //                            Container(
              //                              width: double.infinity,
              //                              padding: const EdgeInsets.only(
              //                                top: 8,
              //                              ),
              //                            ),
              //                            // InkWell(
              //                            //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
              //                            //     builder: (context) => CommentsScreen(
              //                            //       snap: widget.snap,
              //                            //     ),
              //                            //   )),
              //                            //   child: Container(
              //                            //     padding: const EdgeInsets.symmetric(vertical: 4),
              //                            //     child: Text(
              //                            //       'View all $commentLen comments',
              //                            //       style: const TextStyle(
              //                            //         fontSize: 16,
              //                            //         color: Colors.blueGrey,
              //                            //       ),
              //                            //     ),
              //                            //   ),
              //                            // ),
              //                            Container(
              //                              padding: const EdgeInsets.symmetric(vertical: 4),
              //                              child: Text(
              //                                DateFormat.yMMMd()
              //                                    .format(widget.snap['datePublished'].toDate()),
              //                                style:
              //                                const TextStyle(fontSize: 16, color: Colors.blueGrey),
              //                              ),
              //                            ),
              //                            // ElevatedButton(onPressed: (){_issuesolvedreply(context);}, child: Text('Issue Solved'),style: ButtonStyle(),)
              //                          ],
              //                        ),
              //                      ),
              //                    ],
              //                  ),
              //
              //                ),
              //              ),
              //         )
              //       ]
              //     ),
              //   ],
              //
              // ),

              // StreamBuilder and ListView.builder below the card
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(widget.snap['postId'])
                      .collection('comments')
                      .orderBy('datePublished', descending: true)
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
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) => Container(
                          child: CommentCard(
                            snap: snapshot.data!.docs[index],
                          )),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: kToolbarHeight,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.only(left: 10, right: 8, bottom: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  user!.photoUrl,
                ),
                radius: 22,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Comment as ${user.username}',
                    border: InputBorder.none,
                    iconColor: Colors.black,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await FireStoreMethods().postComment(
                  widget.snap['postId'],
                  _commentController.text,
                  user.uid,
                  user.username,
                  user.photoUrl,
                );
                setState(() {
                  _commentController.text = "";
                });
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.cyanAccent),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }





}

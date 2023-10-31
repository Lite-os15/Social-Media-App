
import 'package:Lets_Change/screens/Issue_screen.dart';
import 'package:Lets_Change/widgets/post_card.dart';
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
              decoration:
                  const InputDecoration(labelText: 'Search for a user...'),
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
                    .where('username',
                        isGreaterThanOrEqualTo: searchController.text)
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
                            backgroundImage:
                                NetworkImage(user['photoUrl'] as String),
                            radius: 16,
                          ),
                          title: Text(user['username'] as String),
                        ),
                      );
                    },
                  );
                },
              )
            :

                SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children: <Widget>[
                          InkWell(
                            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>IssueScreen())),
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.redAccent,
                                gradient: LinearGradient(
                                  colors: [Colors.red, Colors.purpleAccent.shade200],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                  borderRadius:
                                      BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(10),bottomRight:Radius.circular(10) ,bottomLeft: Radius.circular(10))),
                              padding: const EdgeInsets.all(8),
                              child:  Text("Waste",style: TextStyle(
                                fontSize: 20,fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                          // InkWell(
                          //
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         // color: Colors.lightBlueAccent,
                          //         gradient: LinearGradient(
                          //           colors: [Colors.lightBlueAccent, Colors.blue.shade200],
                          //           begin: Alignment.topLeft,
                          //           end: Alignment.bottomRight,
                          //         ),
                          //         borderRadius:
                          //         BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(10),bottomRight:Radius.circular(10) ,bottomLeft: Radius.circular(10))),
                          //     padding: const EdgeInsets.all(8),
                          //     child: const Text("Potholes",style: TextStyle(
                          //         fontSize: 20,fontWeight: FontWeight.bold
                          //     ),),
                          //
                          //   ),
                          // ),
                          // InkWell(
                          //
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         // color: Colors.amberAccent,
                          //       gradient: LinearGradient(
                          //         colors: [Colors.amber, Colors.orange.shade200
                          //         ],
                          //         begin: Alignment.topLeft,
                          //         end: Alignment.bottomRight,
                          //       ),
                          //         borderRadius:
                          //         BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(10),bottomRight:Radius.circular(10) ,bottomLeft: Radius.circular(10))),
                          //     padding: const EdgeInsets.all(8),
                          //     child: const Text("Street Lights",style: TextStyle(
                          //         fontSize: 20,fontWeight: FontWeight.bold
                          //     ),),
                          //
                          //   ),
                          // ),
                          // InkWell(
                          //
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         // color: Colors.lightGreenAccent,
                          //         gradient: LinearGradient(
                          //           colors: [Colors.lightGreenAccent, Colors.tealAccent],
                          //           begin: Alignment.topLeft,
                          //           end: Alignment.bottomRight,
                          //         ),
                          //         borderRadius:
                          //         BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(10),bottomRight:Radius.circular(10) ,bottomLeft: Radius.circular(10))),
                          //     padding: const EdgeInsets.all(8),
                          //     child: const Text("Sewage",style: TextStyle(
                          //         fontSize: 20,fontWeight: FontWeight.bold
                          //     ),),
                          //
                          //   ),
                          // ),
                          // InkWell(
                          //
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //
                          //         // color: Colors.indigoAccent,
                          //       gradient: LinearGradient(
                          //         colors: [Colors.indigoAccent, Colors.indigo.shade200],
                          //         begin: Alignment.topLeft,
                          //         end: Alignment.bottomRight,
                          //       ) ,
                          //         borderRadius:
                          //         BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(10),bottomRight:Radius.circular(10) ,bottomLeft: Radius.circular(10))),
                          //     padding: const EdgeInsets.all(8),
                          //     child: const Text("Air Pollution",style: TextStyle(
                          //         fontSize: 20,fontWeight: FontWeight.bold
                          //     ),),
                          //
                          //   ),
                          // ),
                          // InkWell(
                          //
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         // color: Colors.teal,
                          //       gradient: LinearGradient(
                          //         colors: [Colors.tealAccent, Colors.teal.shade200],
                          //         begin: Alignment.topLeft,
                          //         end: Alignment.bottomRight,
                          //       ),
                          //         borderRadius:
                          //         BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(10),bottomRight:Radius.circular(10) ,bottomLeft: Radius.circular(10))),
                          //     padding: const EdgeInsets.all(8),
                          //     child: const Text("Tree Plantation",style: TextStyle(
                          //         fontSize: 20,fontWeight: FontWeight.bold
                          //     ),),
                          //
                          //   ),
                          // ),
                        ],
                      ),


                    ],
                  ),
                ),
        );
  }



}

import 'package:flutter/material.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(onPressed: (){}, icon: Icon(Icons.account_circle_outlined))
      //   ],
      //   title: Text('This is mobile'),
      // ),

      body: Text('This is mobile'),
    );
  }
}

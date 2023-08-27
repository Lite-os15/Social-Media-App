import 'package:Lets_Change/widgets/2nd_tab.dart';
import 'package:Lets_Change/widgets/3rd_tab.dart';
import 'package:flutter/material.dart';

import '../widgets/1st_tab.dart';


class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(

        ),

        body: Column(
          children: [
            TabBar(
              tabs: [
              Tab(
                child: Text('Your Muncipal Corporation',style: TextStyle(color: Colors.black),),
              ),
              Tab(
                child: Text('Your Vote',style: TextStyle(color: Colors.black),),
              ),
              Tab(
                child: Text('Leaderboard',style: TextStyle(color: Colors.black),),
              ),
            ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FirstTab(),
                  SecondTab(),
                  ThirdTab(),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/1st_tab.dart';
import 'package:instagram_clone/widgets/2nd_tab.dart';
import 'package:instagram_clone/widgets/3rd_tab.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
            TabBar(tabs: [
              Tab(
                icon: Icon(Icons.home, color: Colors.black,),
              ),
              Tab(
                icon: Icon(Icons.home, color: Colors.black,),
              ),
              Tab(
                icon: Icon(Icons.home, color: Colors.black,),
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

import 'package:Lets_Change/widgets/your_vote_tab.dart';
import 'package:Lets_Change/widgets/muncipal_leaderboard_tab.dart';
import 'package:flutter/material.dart';

import '../widgets/muncipal_tab.dart';

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
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: TabBar(
                  // labelColor: Colors.greenAccent,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // Creates border
                      color: Colors.greenAccent),
                  tabs: const [
                    Tab(
                      child: Text(
                        'Your Muncipal Corporation',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Your Vote',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Leaderboard',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
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
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SecondTab extends StatefulWidget {
  const SecondTab({super.key});

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.green,
      child: Center(
        child: Text('2nd TAB'),
      ),
    );

  }
}

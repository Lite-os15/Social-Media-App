import 'package:flutter/material.dart';

class ThirdTab extends StatefulWidget {
  const ThirdTab({super.key});

  @override
  State<ThirdTab> createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.green,
      child: Center(
        child: Text('3rd TAB'),
      ),
    );

  }
}

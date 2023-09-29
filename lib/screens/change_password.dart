import 'dart:io';

import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'Create a New Passsword',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '- You can change your password every 30 days.\n'
              '- Note :- If password is changed now you will not \n'
              ' able to change it for next 30 days',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Recent Password'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'New Password'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Confirm Password'),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Confirm',
                style: TextStyle(fontSize: 18),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minWidth: double.infinity,
              color: Colors.blue,
            )
          ],
        ),
      ),
    ));
  }
}

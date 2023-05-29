import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';

import 'package:intl/intl.dart';

import '../models/user.dart';
import '../resources/auth_methods.dart';
import '../resources/storage_methods.dart';
import '../responsive/responsive_screen_layout.dart';
import '../responsive/web_screen_layout.dart';

class IntroScreen extends StatefulWidget {

  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  TextEditingController _date = TextEditingController();
  bool _isLoading = false;

  void userDOB() async {
    if (_date.text.isNotEmpty) {
      // Call the userDOB method from AuthMethods and pass the dob value
      String result = await AuthMethods().userDOB(dob: _date.text);
      if (result == "success") {
        // Navigate to the desired screen after successful operation
        Navigator.of(context).pop(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      } else {
        // Show an error message or handle the error case
        // You can display an error toast or dialog to inform the user about the error
      }
    } else {
      // Show an error message or handle the empty field case
      // You can display an error toast or dialog to inform the user about the empty field
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(

          image: DecorationImage(
            image :NetworkImage(
                'https://images.unsplash.com/photo-1684399026406-da824e064d46?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE0fDZzTVZqVExTa2VRfHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=1000&q=60'),
            fit: BoxFit.fill
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Aligns children in the center vertically
          children: [
            Container(margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height *0.1),
              child: Text(
                'Enter Your Birth Date',
                style:
                TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold
              ),),
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  DateTime? pickdate = await
                  showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));

                  if (pickdate != null){
                    setState(() {
                      _date.text = DateFormat('dd MMMM yyyy').format(pickdate);
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _date,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Date',
                      labelStyle: (TextStyle(color: Colors.white)
                      )

                    ),
                    enabled: false, // Prevents direct editing of the text field
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                userDOB();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    ),
                  ),
                );
              },

              //() {Navigator.of(context).pop(MaterialPageRoute(builder: (context) => FeedScreen()));},
              child: Text("Let's change"),
            ),
          ],
        ),
      ),
    );
  }
}


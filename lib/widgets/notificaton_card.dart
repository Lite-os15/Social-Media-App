import 'package:flutter/material.dart';



class NotificationCard extends StatefulWidget {
  final snap;
  const NotificationCard({super.key, required this.snap});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {



  String buttonText = "Pending";
  Color buttonColor = Colors.orangeAccent;

  void changeButtonState() {
    setState(() {
      buttonText = (buttonText == "Pending")
          ? "Accepted"
          : (buttonText == "Accepted")
          ? "Rejected"
          : (buttonText == "Rejected")
          ? "In Progress"
          : (buttonText == "In Progress")
          ? "Completed"
          : "Pending";

      buttonColor = (buttonText == "Pending")
          ? Colors.orangeAccent
          : (buttonText == "Accepted")
          ? Colors.greenAccent
          : (buttonText == "Rejected")
          ? Colors.redAccent
          : (buttonText == "In Progress")
          ? Colors.yellow
          : Colors.lightBlueAccent;
    });
  }





  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var latitude = widget.snap['lat'];
    var longitude = widget.snap['long'];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(elevation: 15,
        // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // Set the clip behavior of the card
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // Define the child widgets of the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
            Image.network(
              widget.snap['postUrl'],
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Add a container with padding that contains the card's title, text, and buttons
            Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Display the card's title using a font size of 24 and a dark grey color
                  Text(
                    widget.snap['address'],
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                    ),
                  ),

                Text("$longitude,$latitude"),
                  // Add a space between the title and the text
                  Container(height: 10),
                  // Display the card's text using a font size of 15 and a light grey color
                  Text(
                    widget.snap['description'],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  // Add a row with two buttons spaced apart and aligned to the right side of the card
                  Row(
                    children: <Widget>[
                      // Add a spacer to push the buttons to the right side of the card
                      const Spacer(),
                      // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                      Chip(
                        label: Text(
                            "MARK AS SOLVED",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                      ),
                      SizedBox(width: 10,),

                      //TODO:This onTap function is temporary till backend is not connected at user side

                      InkWell(onTap: changeButtonState,
                        child: Chip(backgroundColor: buttonColor,
                          label: Text(
                              buttonText,
                              style: TextStyle(color: Colors.black),
                            ),


                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Add a small space between the card and the next widget
            Container(height: 5),
          ],
        ),
      ),
    );
  }
}

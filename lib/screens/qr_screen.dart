import 'package:Lets_Change/screens/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  String data = "Your QR Code Data"; // Provide your data here

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
                // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> QrScanner())),
                child: Icon(Icons.qr_code_scanner))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),

          //TODO: ADD a QRScannar
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.yellowAccent,
                  Colors.greenAccent,
                  Colors.lightBlueAccent,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.0, 0.5, 1.0], // Gradient stops, adjust as needed
              ),

              // color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: QrImageView(
                    embeddedImage: const NetworkImage('https://images.unsplash.com/photo-1692648545854-75939d9f9fc1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80'),
                    embeddedImageStyle: QrEmbeddedImageStyle(size: Size.square(30)),
                    data: data, // TODO: UserProfile Link, name, muncipal corp.,
                    version: QrVersions.auto,
                    backgroundColor: Colors.white,

                    size: 200.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

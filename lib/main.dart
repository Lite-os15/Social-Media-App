import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_screen_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';

import 'package:instagram_clone/utils/colour.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb){
     await Firebase.initializeApp(
       options: const FirebaseOptions(
           apiKey: 'AIzaSyAnlSS_sbAYbTeWHhkDdH8jRAJmAHxBrIk',
           appId: '1:103900823975:web:4997d1b8e21dea4db7b682',
           messagingSenderId: '103900823975',
           projectId: 'instagram-clone-35eb4',
           storageBucket: 'instagram-clone-35eb4.appspot.com'
       ),
     );
  }else{
    await Firebase.initializeApp();
 }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),

     // home:  const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout()),

      home: SignUpScreen(),
    );
  }
}

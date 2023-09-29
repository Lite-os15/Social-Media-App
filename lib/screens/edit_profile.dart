import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final double coverHeight = MediaQuery.of(context).size.height * 0.2;
    final double profileHeight = MediaQuery.of(context).size.height * 0.06;
    const double avatarRadius = 45;


    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: false,
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: coverHeight,

                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1682685797736-dabb341dc7de?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: coverHeight - avatarRadius,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Container(
                      height: avatarRadius *2,
                      width: avatarRadius *2,
                      decoration: BoxDecoration(
                          color: Colors.grey,

                          image: DecorationImage(fit: BoxFit.cover,
                              image: NetworkImage('https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=')
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color:Colors.black,width: 3
                          )
                      ),
                      // radius: avatarRadius,
                      // backgroundColor: Colors.grey.shade800,
                      // backgroundImage: NetworkImage(
                      //   userData['photoUrl'] ?? 'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=',
                      // ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: profileHeight,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child:
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.green, Colors.white],
                ),

                  boxShadow: [BoxShadow(
                    color: Colors.grey,
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      15.0, // Move to right 10  horizontally
                      15.0, // Move to bottom 10 Vertically
                    ),
                  )
                  ]
                ),
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                child:
                Column(
                  children: [

                    TextField(autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'UserName',
                        label:Text('Enter UserName'),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      readOnly: true,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'DOB',
                        label:Text('Date of Birth'),
                      ),
                    ),
                    SizedBox(height: 30),

                    TextField(autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Muncipality',
                        label:Text('Your Muncipal Corporation'),
                      ),
                    ),
                    SizedBox(height: 30),

                    TextField(autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        label:Text('Description'),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )
                      ),
                      maxLines: 5,
                    ),

                    SizedBox(height: 40,),

                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child:Text('Save Changes')
                    ),
                  ],
                ),





              ),
            ),




          ],
        ),
      ),
    );
  }
}

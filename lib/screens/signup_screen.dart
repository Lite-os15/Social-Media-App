import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/utils.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:instagram_clone/utils/colour.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

   selectImage() async {
      Uint8List im = await pickImage(ImageSource.gallery);
      setState(() {
        _image =im;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Flexible(child: Container(),flex: 2),
              //svg image
              // Image.asset('assets/images/button1.png',color: primaryColor,height: 64,),

              //Circular widget to show the profile
               Stack(
                 children: [
                _image != null
                 ? CircleAvatar(
                   radius: 64,
                   backgroundImage: MemoryImage(_image!),
                   backgroundColor: Colors.red,
                 )

                        :const CircleAvatar(
                         radius: 64,
                          backgroundImage: NetworkImage(
                                    'https://i.stack.imgur.com/l60Hf.png'),
                                backgroundColor: Colors.red,
                           ),
                   Positioned(bottom: -10,
                       left: 80,
                       child: IconButton(onPressed: (){},
                         icon:const Icon(Icons.add_a_photo)
                         ,)
                   ),
                 ],
               ),
              const SizedBox(height: 24,
              ),

              //text field input for username
              TextFieldInput(textEditingController: _usernameController,
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),

              //text field input for email
              TextFieldInput(textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),

              //text field input for password
              TextFieldInput(textEditingController: _passwordController,
                hintText: 'Enter your Password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(textEditingController: _bioController,
                hintText: 'Enter bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              //button login
              InkWell(
                onTap: ()  async {
                  String res = await AuthMethod().signUpUser(
                      email: _emailController.text,
                      password: _passwordController.text,
                      username: _usernameController.text,
                      bio: _bioController.text,
                    file: _image!,

                  );
                  print(res);
                },
                child: Container(
                  child: const Text('Sign up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(),flex: 2),
              //Transitioning to signin
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Already User?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},

                    child: Container(
                      child: const Text("Log in.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:Lets_Change/screens/login_screen.dart';
import 'package:Lets_Change/screens/user_details_screen.dart';
import 'package:Lets_Change/utils/colour.dart';
import 'package:Lets_Change/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class SignUpScreen extends StatefulWidget {


  const SignUpScreen({Key? key, }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }




  void signUpUser() async {

    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds


    // if string returned is sucess, user has been created



      setState(() {
        _isLoading = false;
      });

      //navigate to the home screen
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => IntroScreen(
        email: _emailController.text,
        password: _passwordController.text,
        bio: _bioController.text,
        username: _usernameController.text,
        imageFile: _image!,

      )));


    }


  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // decoration:const BoxDecoration(
          //   image: DecorationImage(fit: BoxFit.cover,
          //     image: NetworkImage(
          //       'https://images.unsplash.com/photo-1684399026406-da824e064d46?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE0fDZzTVZqVExTa2VRfHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=1000&q=60'
          //     ),
          //   ),
          // ),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const SizedBox(height: 64,),
                // Flexible(child: Container(),flex: 2),
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
                                  backgroundColor: Colors.white,
                             ),
                     Positioned(bottom: -10,
                         left: 80,
                         child:
                         IconButton(
                           onPressed: selectImage ,
                           icon:const Icon(Icons.add_a_photo)

                           ,)
                     ),
                   ],
                 ),
                const SizedBox(height: 24,
                ),
                Form(child: Column(
                  key: _formKey,
                  children: [
                    TextFormField(controller: _usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your username',
                      ),
                      validator: (value) {
                      if(value == null)
                        {
                          return 'please enter username';
                        }
                      return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //text field input for email
                    TextFormField(controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Enter email'
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //text field input for password
                    TextFormField(controller: _passwordController,
                      obscureText: true,

                      decoration: const InputDecoration(

                          label: Text('Enter Password'),
                        hintText: 'Atleast 6 character',

                      ),
                       //validator: ,
                    ),
                  ],
                ),),

                //text field input for username

                const SizedBox(
                  height: 20,
                ),
                TextFormField(controller: _bioController,
                  decoration:const InputDecoration(

                    labelText: 'Enter bio',

                  )

                ),
                const SizedBox(
                  height: 24,
                ),


                InkWell(
                  child:
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: blueColor,
                    ),
                    child: !_isLoading
                        ? const Text(
                      'Sign up',
                    )
                        : const CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                  onTap: () {
                    if (_image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please add your profile Picture")));
                    } else if (_usernameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _bioController.text.isNotEmpty)
                    {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => IntroScreen(
                            email: _emailController.text,
                            password: _passwordController.text,
                            bio: _bioController.text,
                            username: _usernameController.text,
                            imageFile: _image!,

                          ),
                        ),
                      );
                    }

                    // if (_image == null) {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //       content: Text("Please select an Image")));
                    // } else if (_usernameController.text.isNotEmpty &&
                    //     _emailController.text.isNotEmpty &&
                    //     _passwordController.text.isNotEmpty &&
                    //     _bioController.text.isNotEmpty) {
                    //   signUpUser();
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //       content: Text("Fields can't be empty")));
                    // }
                  }
                ),

               // button login
               //  ElevatedButton(onPressed: () {
               //    String result = signUpUser();
               //
               //    if(result == 'success'){
               //      // Navigator.push(context, MaterialPageRoute(builder: (context) => FeedScreen()));
               //    }
               //  }, child: Text('Sign up')),

                const SizedBox(
                  height: 8,
                ),
                // Flexible(child: Container(),flex: 2),
                //Transitioning to signin
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text("Already User?"),
                    ),

                    InkWell(
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),

                      child: const Text("Log in.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty<bool>('_isLoading', _isLoading));
  // }
}

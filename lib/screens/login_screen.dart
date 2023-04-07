import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colour.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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

              const SizedBox(height: 64,
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
              //button login
              InkWell(
                onTap: () {},
                child: Container(
                child: const Text('Log in'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                ),
                  color: Colors.blue,),
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
                      child: const Text("New User?"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),

                    GestureDetector(
                     onTap: () {},

                     child: Container(
                     child: const Text("Sign up.",
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

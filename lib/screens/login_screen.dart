
import 'package:Lets_Change/resources/auth_methods.dart';
import 'package:Lets_Change/responsive/mobile_screen_layout.dart';
import 'package:Lets_Change/responsive/responsive_screen_layout.dart';
import 'package:Lets_Change/responsive/web_screen_layout.dart';
import 'package:Lets_Change/screens/signup_screen.dart';
import 'package:Lets_Change/utils/colour.dart';
import 'package:Lets_Change/utils/utils.dart';
import 'package:Lets_Change/widgets/text_field_input.dart';
import 'package:flutter/material.dart';



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

    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password:_passwordController.text,
    );
    if(res == "success"){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }else{
       setState(() {
         _isLoading = false;
       });
      // ignore: use_build_context_synchronously
      showSnackBar(res, context );
    }
    // setState(() {
    //   _isLoading = false;
    // });

  }

  void navigateToSignup(){
    Navigator.of(context ).push(MaterialPageRoute(builder: (context) => const SignUpScreen(),
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(fit: BoxFit.fill ,
              image: NetworkImage(
              'https://images.unsplash.com/photo-1439853949127-fa647821eba0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'
              ),
            ),

          ),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                SizedBox(height: MediaQuery.of(context).size.height *0.2 ,),
                const Text("Let's Change",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,

                ),),
                const SizedBox(height: 120,),
                // Flexible(child: Container(),flex: 2),
                //svg image
                // Image.asset('assets/images/button1.png',color: primaryColor,height: 64,),



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
                  onTap:  loginUser,
                  child:  Container(
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
                  child: _isLoading ? const Center(child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                  )
                  : const Text('Log in'),
                  ),
                  ),

                const SizedBox(
                  height: 12,
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
                        child: const Text("New User?"),
                      ),

                      GestureDetector(
                       onTap: navigateToSignup ,

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
      ),
    );
  }
}

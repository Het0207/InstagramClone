import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
  void loginUser() async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);
    if(res == "success"){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  const ResponsiveLayout(mobileScreenLayout :MobileScreenLayout (), webScreenLayout :WebScreenLayout()),
        ),
      );
    }
    else{
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .center, //center from sideways not form all sides
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ), //main logo position, up odr down
              //svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter Your Password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              //login button
              InkWell(
                  onTap: loginUser,
                  child: Container(
                    child: _isLoading?const Center(child: CircularProgressIndicator(
                      color: primaryColor,
                    ),) :const Text(("Log in")),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: blueColor),
              )),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Dont Have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                      onTap: navigateToSignup,
                    child :Container(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    )
                  )
                ],
              )

              //text field in for email

              // text field in for password
              // login
              // transitiioning to sign up
            ],
          ),
        ),
      ),
    );
  }
}

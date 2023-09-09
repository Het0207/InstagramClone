import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List ? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }
void selectImage() async{
  Uint8List im = await pickImage(ImageSource.gallery);
  setState(() {
    _image = im;
  });
}
void signUpUser() async {
  setState(() {
    _isLoading = true;
  });
  String res = await AuthMethods().signUpUser(email: _emailController.text,
    password: _passwordController.text,
    username: _usernameController.text,
    bio: _bioController.text,
    file: _image!,
  );
  setState(() {
    _isLoading = false;
  });
  if(res != 'success'){
    showSnackBar(res, context);
  }
  else{
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>  const ResponsiveLayout(mobileScreenLayout :MobileScreenLayout (), webScreenLayout :WebScreenLayout()),
      ),
    );
  }
}

  void navigateToLogin(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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

              //circular widget to accept and show our selected file
              Stack(
                children: [
                  _image !=null?CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  )
                  : const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://tse2.mm.bing.net/th?id=OIP.1Agw8tPi1oidtC_q4U4ZdgHaHa&pid=Api&P=0&h=180'),
                  ),
                  Positioned(
                      bottom: -10,
                      left: 80,

                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      )
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              //text field input for username
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: "Enter your username",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              //text field input for email
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
              //text field input for bio
              TextFieldInput(
                textEditingController: _bioController,
                hintText: "Enter your bio",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              //sigup button
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading
                      ?const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                      ),)
                      : const Text(("Sign Up")),
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
                    child: const Text("Already Have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                      onTap: navigateToLogin,
                      child: Container(
                        child: const Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ))
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

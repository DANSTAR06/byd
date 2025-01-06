import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:testApp/screens/auth/resetPassword.dart';

import 'package:testApp/screens/auth/signUp.widget.dart';
import 'package:testApp/screens/main/home.dart';
import '../../controllers/auth.dart';
import '../../controllers/login_signup.dart';
import '../../styles/fonts.dart';
import '../../widegts/customButtonWithIcon.dart';
import '../../widegts/customInputField.dart';
import '../../widegts/passwordField.dart';

import 'package:firebase_auth/firebase_auth.dart';


class LoginSignupPage extends StatefulWidget {

  const LoginSignupPage({Key? key}) : super(key: key);

  @override
  State<LoginSignupPage> createState() => _loginscreenState();
}

class _loginscreenState extends State<LoginSignupPage> {
  bool isLoading = false;

  bool isvisible = true;



  get onWillPop => null;
  final fonKey = GlobalKey<FormState>();
  final passformKey = GlobalKey<FormState>();




  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _passController = TextEditingController();
  final _emailController = TextEditingController();

  final authController = AuthController.instance;


  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();

  }


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginSignupController()); // Initialize controller
    return Scaffold(
      backgroundColor: const Color(0xFFF5EEC7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.04), // Use Get.height
              const Text(
                "Welcome to AA Kenya\n TestApp",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF024F31),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * 0.01),
              const Text(
                "Login or sign up to access your account",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * 0.02),
              TabBar(
                controller: controller.tabController,
                indicatorColor: const Color(0xFFF5EEC7),
                labelColor: const Color(0xFF024F31),
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: "Login"),
                  Tab(text: "Sign Up"),
                ],
              ),
              SizedBox(height: Get.height * 0.04),
              SizedBox(
                height: Get.height * 1.0,
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    buildLoginForm(controller),
                    const buildSignupForm(),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //exit dialog
  Future<bool> exitDialogue() async {
    final shouldPop = await Get.dialog<bool>(
      AlertDialog(
        icon: const Icon(Icons.warning_amber,size: 40,color: Colors.red,),
        title: Text("Please Confirm",style: AppFonts.heading1,),
        content: const Text("Do you want to exit the app?"),
        actions: [
          ElevatedButton(
            onPressed: () {

              //SystemNavigator.pop(); // Exit the app
              exit(0);//terminates app activities

            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:  Text("Yes, Exit",style: AppFonts.heading2.copyWith(fontSize: 12),),

          ),
          ElevatedButton(
            onPressed: () {
              Get.back(result: false); // Stay in the app

            },
    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child:  Text("No, Stay",style: AppFonts.heading1.copyWith(fontSize: 12),),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  Widget buildLoginForm(LoginSignupController controller) {
    return WillPopScope(
      onWillPop: () {
        exitDialogue();
        return Future.value(false);
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () async{
                  setState(() {
                    isLoading=true;
                  });
                  try {

                    _loginGoogleUser();
                   //Get.offAll(() => const HomeScreen());


                  }catch(e){
                    setState(() {
                      isLoading=false;
                    });
                    Get.snackbar("Failed to signin With Google",e.toString(),backgroundColor: Colors.red);
                    print(e.toString());
                  }
                  finally{
                    setState(() {
                      isLoading=false;
                    });

                  }

                },
                icon: Image.asset(
                  'assets/images/icongoogle.png',
                  width: 28,
                  height: 28,
                ),
                label: const Text(
                  "Login with Google",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.apple, color: Colors.black, size: 36),
                label: const Text(
                  "Login with Apple",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              const Row(
                children: [
                  Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "or continue with email",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.black87,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 2, color: Colors.grey)),
                ],
              ),
              SizedBox(height: Get.height * 0.04),
              Form(key: fonKey,
                child: CustomInputField(
                  labelText: 'Email Address',
                  iconData: Icons.email_outlined,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _emailController.text = value!;
                  },
                  controller: _emailController,
                  validator: (value) {
                    //final RegExp phoneRegex = RegExp(r'^07\d{8}$');
                    if (value!.isEmpty) {
                      return ("Please Provide your Email Address");
                    }
                    //email format validation
                    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$')
                        .hasMatch(value)) {
                      return ("Invalid Email Address!");
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: Get.height * 0.02),

              Form(key: passformKey,
                child: PasswordField(
                  labelText: 'Password',
                  iconData: Icons.password,
                  controller: _passController,
                  isPasswordField: true,
                  onSaved: (value) {
                    _passController.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Provide your Login Password");
                    }
                    //email format validation
                    if (!RegExp(r'^.{6,}$')
                        .hasMatch(value)) {
                      return ("Invalid Password must be more than 6 characters");
                    }
                    return null;
                  },),
              ),
              SizedBox(height: Get.height * 0.02),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.to(const resetpassword());
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Color(0xFF024F31),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              isLoading
                  ? const SpinKitDualRing(
                size: 80,
                color: Colors.green,
              )
                  : CustomButtonWithIcon(
                text: 'Login',
                iconPath: 'assets/images/logincon.png',
                onPressed: () async {
                  if (fonKey.currentState!.validate() &&
                      passformKey.currentState!.validate()) {
                    // Save values to the controllers
                    setState(() {
                      isLoading = true;
                    });
                    fonKey.currentState!.save();
                    passformKey.currentState!.save();

                    try {
                      // Call sign-in with saved values
                      await _loginuser(_emailController.text.trim(), _passController.text.toString());
                      //await authController.loginWithEmail(_emailController.text.trim(), _passController.text.toString());
                    } catch (e) {
                      // Handle errors here (e.g., show an error message)
                      Get.snackbar("Error", "Something Happened\n$e");
                      print('Error during login: $e');
                    } finally {
                      // Ensure loading state is reset regardless of success or failure
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }//end of validation
                },
              ),

              SizedBox(height: Get.height * 0.01),
              const Text.rich(
                TextSpan(
                  text: "By signing in with an account, you agree to our ",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w200,
                      fontSize: 14,
                      color: Colors.grey),
                  children: [
                    TextSpan(
                      text: "\nTerms of Service",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                        color: Color(0xFF024F31),
                      ),
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy.",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                        color: Color(0xFF024F31),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //login user using our controller instance
_loginuser(mail,pass) async{
    final loguser = await authController.loginWithEmail(mail, pass);
    if(loguser != null){
      Fluttertoast.showToast(
        msg: "Hey\t$mail \nYou're already Logged in Successfully...",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 30,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );
      Get.offAll(const HomeScreen());

    }
}

  _loginGoogleUser() async{
    final loguser = await authController.signInWithGoogle();
    if(loguser != null){
      Fluttertoast.showToast(
        msg: "Hey\t \nYou're  Logged in Successfully...",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 30,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );
      Get.offAll(const HomeScreen());

    }
  }



}

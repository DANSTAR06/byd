import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


import '../../controllers/auth.dart';
import '../../styles/fonts.dart';
import '../../widegts/customButtonWithIcon.dart';
import '../../widegts/customInputField.dart';
import '../../widegts/passwordField.dart';



class buildSignupForm extends StatefulWidget {
  const buildSignupForm({Key? key}) : super(key: key);

  @override
  State<buildSignupForm> createState() => _SignupFormWidgetState();
}



class _SignupFormWidgetState extends State<buildSignupForm> {

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();


  bool _isLoading = false;

  // Firebase instances
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //final authController = AuthController.instance;

  final _auth = AuthController.instance;

  final phoneKey = GlobalKey<FormState>();
  final mailKey = GlobalKey<FormState>();
  final passKey = GlobalKey<FormState>();
  final confpassKey = GlobalKey<FormState>();


  //sign-up logic
  Future<void> registerUser(String email, String password) async {
    final user = await _auth.createuser(email, password);
    if (user != null) {

      //toast
      Fluttertoast.showToast(
        msg: "Account Created Successfully...Welcome Rider",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 30,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );

      /*showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text("$email Account Created Successfully"),
            actions: [TextButton(onPressed: () async {
              setState(() {
                _isLoading = false;
              });
              Get.off(() => const HomeScreen());
              //Navigator.pop(context);
              //Navigator.push(context, MaterialPageRoute(builder:(context)=>const HomeScreen()));
            }, child:  Text("Okay, Continue to Homepage",style: AppFonts.heading1,))
            ]);
      }); *///end of showing alert


    }
  }

  //save data
  /*postDetailsToDatabase() async
  {
    Map<String, dynamic> userData = {
      'phone': _phoneController.text.toString().trim(),
      'email': _emailController.text.toLowerCase().trim(),
      'password': _passwordController.text.hashCode.toString(),

    };
    try {
      // _userRef.push().set(userData);API
      await
      Fluttertoast.showToast(
        msg: "Account Created Successfully...You can LOGIN NOW",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 30,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );
      QuickAlert.show(context: context,
          type: QuickAlertType.success,
          title: "Success",
          text: "Registration Was SUCCESSFULLY",
          textColor: Colors.cyan,
          titleColor: Colors.redAccent,
          borderRadius: 20,
          autoCloseDuration: Duration(seconds: 5));
      //Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => ()), (route) => false);
      Get.off(() => LoginSignupPage());
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
// Handle errors
      QuickAlert.show(context: context,
          type: QuickAlertType.error,
          title: "FAILED",
          cancelBtnText:
          "OKAY",
          text: "Your Registration Failed :$e",
          textColor: Colors.cyan,
          titleColor: Colors.red,
          backgroundColor: Colors.deepPurple,
          cancelBtnTextStyle: const TextStyle(fontFamily: "NotoSansMono",
            fontWeight: FontWeight.w800,
            fontSize: 20.0,),
          borderRadius: 25);


      showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text('Error registering user: $e'),
            actions: [TextButton(onPressed: () async {

              Navigator.pop(context);
            }, child:  Text("OKAY",style: AppFonts.subHeading,))
            ]);
      });
    }
  }*/


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/icongoogle.png',
                width: 28,
                height: 28,
              ),
              label: Text(
                "Sign Up with Google",
                style: AppFonts.heading1.copyWith(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: h *0.02),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.apple, color: Colors.black, size: 36),
              label: Text(
                "Sign up with Apple",
                style: AppFonts.heading1.copyWith(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: h *0.01),
            Row(
              children: [
                const Expanded(
                    child: Divider(thickness: 2, color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Or Fill in the form below to Register",
                    style: AppFonts.subHeading.copyWith(fontSize: 12,backgroundColor: Colors.grey),
                    //style: AppFonts.bodyText.copyWith(fontSize: 18.0),
                  ),
                ),
                const Expanded(
                    child: Divider(thickness: 2, color: Colors.grey,)),
              ],
            ),
            //const SizedBox(height: 20),
            SizedBox(height: Get.height * 0.02),
            Form(key: phoneKey,
              child: CustomInputField(
                onSaved: (value) {
                  _phoneController.text = value!;
                },
                validator: (value) {

                  RegExp regexp =  RegExp('^254+[0-9]');
                  if (value!.isEmpty) {
                    return "Phone Number Required";
                  }

                  if(value.length < 10 || value.length >12)
                  {
                    return "Provide a Valid Phone Number";
                  }

                  if (!regexp.hasMatch(value)) {
                    return "Phone Number  format should be 254 then 9digits number";
                  }
                  return null;
                },
                controller: _phoneController,
                labelText: "Phone Number",
                iconData: Icons.phone_android,
                textInputAction: TextInputAction.next,
              ),
            ),

            SizedBox(height: Get.height * 0.02),
            Form(
              key: mailKey,
              child: CustomInputField(
                onSaved: (value) {
                  _emailController.text = value!;
                },
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
                labelText: "Email Address",
                iconData: Icons.email_outlined,
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Form(
              key: passKey,
              child: PasswordField(
                onSaved: (value) {
                  _passwordController.text = value!;
                },
                validator: (value) {
                  RegExp regexp = RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return "Kindly type in Your Password";
                  }
                  if (!regexp.hasMatch(value)) {
                    return "Password must not be less than 6 characters!";
                  }
                  return null;
                },
                isPasswordField: true,
                labelText: "Password",
                iconData: Icons.lock,
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Form(
              key: confpassKey,
              child: PasswordField(
                onSaved: (value) {
                  _confirmPasswordController.text = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirmation is required';
                  }
                  return null;
                },
                isPasswordField: true,
                labelText: "Confirm Password",
                iconData: Icons.password_rounded,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            _isLoading
                ? const Center(
              child: SpinKitChasingDots(size: 80, color: Colors.blue),
            )
                : CustomButtonWithIcon(
              text: 'Sign Up',
              iconPath: 'assets/images/regicon.png',
              onPressed: () async {
                if (phoneKey.currentState!.validate() &&
                    mailKey.currentState!.validate() &&
                    passKey.currentState!.validate() &&
                    confpassKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });

                  // Confirm password fields


                  // Save values to the controllers
                  phoneKey.currentState!.save();
                  mailKey.currentState!.save();
                  passKey.currentState!.save();
                  confpassKey.currentState!.save();

                  // Call signup with saved values
                  try {
                    if (_confirmPasswordController.text.trim() !=
                        _passwordController.text.trim()) {
                      setState(() {
                        _isLoading = false;
                      });

                      Get.snackbar(
                        "Password Fields don't Match!",
                        "Please Confirm your Password",
                        duration: const Duration(seconds: 7),
                        backgroundColor: Colors.red,
                      );
                      return; // Exit if passwords don't match
                    }
                    await registerUser(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                    Fluttertoast.showToast(
                      msg: "Congrats! \nYou've been Logged in Successfully...",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP_RIGHT,
                      timeInSecForIosWeb: 30,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 18,
                    );

                    // Handle successful registration here (e.g., navigate to another screen)
                  } catch (e) {

                    //print("Registration error: $e");

                    Get.snackbar(
                      "Registration Failed",
                      "An error occurred while signing up. Please try again.",
                      duration: const Duration(seconds: 10),
                      backgroundColor: Colors.red,
                    );
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              },
            ),


            //terms of service
            SizedBox(height: Get.height * 0.01),

            const Text.rich(
              TextSpan(
                text: "By signing in with an account, you agree to our ",
                style: TextStyle(fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.grey),
                children: [
                  TextSpan(
                    text: "\nTerms of Service",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline,
                      color: Color(0xFF024F31),
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy.",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline,
                      color: Color(0xFF024F31),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),


          ],
        ),
      ),
    );
  }


}

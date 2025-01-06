import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:testApp/models/userModel/userModel.dart' as model;
import 'package:testApp/screens/auth/login.dart';


import '../screens/introScreen/splash.dart';
import '../screens/main/home.dart';
import '../styles/colors.dart';
class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  User? get user => _user.value;

  bool isLoading = false;

  final _auth = FirebaseAuth.instance;


  @override
  void onReady() {
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialScreen);
    super.onReady();
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginSignupPage());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  //register
  Future<User?> createuser(String mail, String pass) async {
    if (mail.isNotEmpty && pass.isNotEmpty) {
      try {
        final cred = await _auth.createUserWithEmailAndPassword(
            email: mail, password: pass);
        Get.snackbar(
            "Success", "$mail\n Account was Successfully Created", duration: const
        Duration(seconds: 10),backgroundColor: Colors.green);
        return cred.user;
      } catch (e) {
        print(e.toString());
        Get.snackbar("Error Creating Your Account", e.toString(),backgroundColor: Colors.red,
        duration: const Duration(seconds: 10));
      }
      return null;
    }
    Get.snackbar("Error Creating Your Account", "Ensure all Fields are provided and correct",duration:
    const Duration(seconds: 10),backgroundColor: Colors.red);
    return null;
  }



  //login email and Password

  Future<User?> loginWithEmail(String mail,
      String pass) async{
    if(mail.isNotEmpty && pass.isNotEmpty){

    try{
      final cred = await _auth.signInWithEmailAndPassword(email: mail,
          password: pass);
      Get.snackbar("Success", "$mail\nLogged in Successfully",backgroundColor: Colors.green,duration: const Duration(seconds:7));

      return cred.user;


    } catch(e){
      //print(e.toString());
      Get.snackbar("Error Logging In, Check Credentials", e.toString(),duration: const Duration(seconds: 10),backgroundColor: Colors.red,colorText: Colors.white);
    }
    return null;

  }
    //Get.snackbar("Error!","Check that You have provided email and Password",duration: const Duration(seconds: 7),backgroundColor: Colors.red);
    return null;
  }

  //loginwithGoogle

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleClient = await GoogleSignIn().signIn();
      if (googleClient == null) {
        Get.snackbar("Cancelled", "Sign-in process was cancelled", backgroundColor: Colors.redAccent);
        return null; // User cancelled the sign-in
      }

      final googleAuth = await googleClient.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      Get.snackbar(
        "Success",
        "You're successfully logged in with your Google Account",
        backgroundColor: Colors.green,
      );

      return userCredential;
    } catch (e) {
      print("Google Sign-In Error: $e");
      Get.snackbar(
        "Error!",
        e.toString(),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 10),
      );
      return null;
    }

  }



  void saveUser(model.usermodel user, UserCredential cred) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(cred.user!.uid)
        .set(user.toJson());
  }


  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Get.snackbar("Oooops! No internet or something??", e.toString(),duration: const Duration(seconds: 10),backgroundColor: Colors.red);
    }
  }


//signin user

}

/*
*
*    void _login(String mail, String pass) async {
     try {
       if (fonKey.currentState!.validate() &&
           passformKey.currentState!.validate()) {
         fonKey.currentState!.save();
         passformKey.currentState!.save();

         {
           setState(() {
             isLoading = true;
           });
           try {
             UserCredential userCredential =
             await _auth.signInWithEmailAndPassword(
                 email: mail,
                 password: pass
             );

             String? email = userCredential.user!.email;
           } on FirebaseAuthException catch (e) {
             if (e.code == 'user-not-found') {
               setState(() {
                 isLoading = false;
               });
               QuickAlert.show(context: context,
                   type: QuickAlertType.error,
                   title: "user not found",
                   confirmBtnText:
                   "OKAY",
                   text: "No user found with this Email and Password",
                   textColor: Colors.cyan,
                   titleColor: Colors.red,
                   confirmBtnColor: Colors.lightBlue,
                   borderRadius: 20);
             } else if (e.code == 'wrong-password') {
               setState(() {
                 isLoading = false;
               });

               QuickAlert.show(context: context,
                   type: QuickAlertType.error,
                   title: "wrong-password",
                   confirmBtnText: "Try Again",
                   text: "Wrong password provided for This user",
                   textColor: Colors.cyan,
                   titleColor: Colors.red,
                   confirmBtnColor: Colors.blueGrey,
                   borderRadius: 20);
             }
           } catch (e) {
             setState(() {
               isLoading = false;
               //emailcontroller.clear();
               //passwordcontroller.clear();
             });
             QuickAlert.show(context: context,
                 type: QuickAlertType.error,
                 text: "Database ERROR " + e.toString(),
                 cancelBtnText: 'Retry');
           }
         }


         setState(() {
           isLoading = false;

           //if fields empty

           QuickAlert.show(context: context,
               type: QuickAlertType.error,
               title: "INPUT VALIDATION FAILED",
               text: "Check that you provided email and password as required",
               titleColor: Colors.red);
         });
       }
     }on SocketException catch (e) {
     QuickAlert.show(context: context, type: QuickAlertType.error,
     title: "Connection Problem",text: "Check Your Internet And retry",titleColor: Colors.red);

     // Handle SocketException error
     showDialog(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: const Text('Connection Error'),
         content: Text(e.message.toString() +
             ' Failed to connect to server. Please check your internet connection and try again.'),
         actions: <Widget>[
           TextButton(
             child: const Text('OKAY'),
             onPressed: () {
               Navigator.of(context).pop();
             },
           ),
         ],
       );
     },
     );
     }
   }
*/
/*
*
*
*             StringRequest request = new StringRequest(Request.Method.POST,"http://"+LoginActivity.ip+"/tenth/empire/insert.php", new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {

                    if (response.equals("You are registered successfully")) {
                       register_user(username,email, mobile, password);
                        Toast.makeText(RegisterActivity.this, "Wait for approval", Toast.LENGTH_SHORT).show();
                        startActivity(new Intent(RegisterActivity.this, LoginActivity.class));
                        progressDialog.dismiss();
                       // finish();
                    } else {
                        Toast.makeText(RegisterActivity.this, response, Toast.LENGTH_SHORT).show();
                        progressDialog.dismiss();
                    }

                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    Toast.makeText(RegisterActivity.this, error.toString(), Toast.LENGTH_SHORT).show();
                    progressDialog.dismiss();
                }
            }) */
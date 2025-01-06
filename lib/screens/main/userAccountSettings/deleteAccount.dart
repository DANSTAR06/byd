import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:testApp/screens/introScreen/splash.dart';

import '../../../styles/fonts.dart';
class deleteAccount extends StatefulWidget {
  const deleteAccount({Key? key}) : super(key: key);

  @override
  State<deleteAccount> createState() => _deleteAccountState();
}

class _deleteAccountState extends State<deleteAccount> {
  final formKey = GlobalKey<FormState>();
  final pasformKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;


  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: const Color(0xFF024F31),
      appBar: AppBar(title: const Text("AA Kenya TestApp", style: TextStyle(
          fontWeight: FontWeight.w900, fontSize: 14.0, fontFamily:
      "NotoSansMono",
          letterSpacing: 1.5),),
        centerTitle: true, backgroundColor: Colors.yellow,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w*2.0,
              height: h * 0.35,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/aalogo.png"),
                      fit: BoxFit.contain
                  )
              ),
            ),
            SizedBox(height: Get.height*0.01),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(70)),
              child: const Text(
                "Confirm your Email and Password to confirm you want to delete this account",
                style: TextStyle(fontFamily: "NotoSansMono",
                    fontWeight: FontWeight.w900, fontSize: 16.0,color: Colors.white),),),
            SizedBox(height: Get.height*0.02),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: TextFormField(

                  decoration: InputDecoration(labelText: 'Email',hintText: "example@gmail.com",labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon:const Icon( Icons.email_outlined,color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(70),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1.5,
                        ),

                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),

                  style: const TextStyle(fontSize: 14,
                      fontFamily: 'NotoSansMono', color: Colors.white,
                      fontWeight: FontWeight.w600),
                  autofocus: false,
                  controller: emailcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Kindly Email is Required!";
                    }
                    if (!RegExp(
                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("INVALID Email Format!!, check your typing");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emailcontroller.text = value!;
                  },

                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            SizedBox(height: Get.height*0.01),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(key: pasformKey,
                  child: TextFormField(
                      style: const TextStyle(fontSize: 14,
                          fontFamily: 'NotoSansMono',
                          fontWeight: FontWeight.w400),
                      autofocus: false,
                      controller: passcontroller,
                      validator: (value) {
                        RegExp regexp = new RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "Kindly type in Your Password";
                        }
                        if (!regexp.hasMatch(value)) {
                          return "Password must not be less than 6 characters!";
                        }
                      },
                      onSaved: (value) {
                        passcontroller.text = value!;
                      },
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_open, color: Colors.white,),
                          hintText: "Provide  your Password",
                          labelText: "Password",labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(70)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(70),
                              borderSide: const BorderSide(
                                color: Colors.indigo,
                                width: 1.5,
                              )
                          ),
                      )


                  )),
            ),
            SizedBox(height: Get.height*0.04),

            Padding(
              padding: const EdgeInsets.fromLTRB(40,10,40,10),
              child: FloatingActionButton.extended(onPressed: () {
                _deleteAccount(emailcontroller.text, passcontroller.text);
              },
                  backgroundColor: Colors.cyan,

                  icon: const Icon(
                    CupertinoIcons.delete_simple, color: Colors.redAccent,size: 30,),
                  label: const Text
                    ("Click to Delete Account",
                    style: TextStyle(fontFamily: "NotoSansMono",
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0,
                        color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }

  void _deleteAccount(String email, String password) async {
    if (formKey.currentState!.validate() &&
        pasformKey.currentState!.validate()) {
      User? user = await _auth.currentUser;
      AuthCredential authCredential = EmailAuthProvider.credential(
          email: email, password: password);

      await user?.reauthenticateWithCredential(authCredential).then((value) {
        value.user?.delete().then((res) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const SplashScreen()));
          const SnackBar(content: Text("Account Deleted Successfully!"),
            duration: Duration(seconds: 7),
            backgroundColor: Colors.green,
            elevation: 25,);
        });
      }).catchError((e) {
        print(e);
        showDialog(context: context, builder: (context) {
          return AlertDialog(content: Text(e.message.toString(),),
            actions: [TextButton(onPressed: () async {
              Navigator.pop(context);
            }, child:  Text("OKAY",style: AppFonts.heading1,))
            ],);
        });
      });
    }
  }

}

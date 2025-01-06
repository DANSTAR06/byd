import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../styles/colors.dart';

class resetpassword extends StatefulWidget {
  const resetpassword({Key? key}) : super(key: key);

  @override
  State<resetpassword> createState() => _resetpasswordState();
}


class _resetpasswordState extends State<resetpassword> {
  final formKey = GlobalKey<FormState>();


  final TextEditingController emailcontroller = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.darkgreen,
      appBar: AppBar(title: const Text("Reset Password", style: TextStyle(
          fontWeight: FontWeight.w900, fontSize: 24.0, fontFamily:
      "NotoSansMono",
          letterSpacing: 1.5),),
        centerTitle: true, backgroundColor: Colors.deepOrangeAccent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w,
              height: h * 0.35,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/aalogo.png"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(70)),
              child: const Text(
                "Provide your Email, you will receive a link via email to reset your Password",
                style: TextStyle(fontFamily: "NotoSansMono",
                    fontWeight: FontWeight.w900, fontSize: 16.0),),),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: TextFormField(

                  decoration: InputDecoration(labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(70),
                        borderSide: const BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                        ),

                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),

                  style: const TextStyle(fontSize: 14,
                      fontFamily: 'NotoSansMono',color: Colors.white,
                      fontWeight: FontWeight.w600),
                  autofocus: false,
                  controller: emailcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Kindly note that Email is Required!";
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
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: ElevatedButton.icon(onPressed: () {
                linkpassword();
              },
                  style:ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      backgroundColor: Colors.cyan),
                  icon: const Icon(
                      Icons.email_outlined, color: AppColors.darkgreen),
                  label: const Text
                    ("Click here to Request password Reset",
                    style: TextStyle(fontFamily: "NotoSansMono",
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }

  Future linkpassword() async {
    try {
      if (formKey.currentState!.validate()) {
        await _auth.sendPasswordResetEmail(email: emailcontroller.text.trim());
        Fluttertoast.showToast(msg: "Link Sent, Check Mails inbox or in Spam box of the email you provided",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    }
    on FirebaseAuthException catch (e) {
      //print(e);
      showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text(e.message.toString(),));
      });
    }
  }
}


//reuse stuff
/* Fluttertoast.showToast(
        msg: "Account Created Successfully...You can LOGIN NOW",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 30,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );
      QuickAlert.show(context: context, type: QuickAlertType.success,title: "Success",text: "Registration Was SUCCESSFULLY",textColor: Colors.cyan,titleColor: Colors.redAccent,
          borderRadius: 20,autoCloseDuration: Duration(seconds: 5));*/

/*
  Future<bool> exitDialogue() async
  {
    final shouldPop = await showDialog(context: context, builder: (context) =>


        AlertDialog(
          title: Text("Please Confirm"),
          content: Text("Do you Want to Exit The app?"),
          actions: [ElevatedButton(onPressed: () {
            SystemNavigator.pop();
          }, child: Text("Yes Exit")),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pop(false);
            }, child: Text("No I Want to Stay")),
          ],
        ),);

    return shouldPop ?? false;
  }
* */
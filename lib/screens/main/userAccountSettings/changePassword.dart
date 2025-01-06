import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testApp/screens/auth/login.dart';
import 'package:get/get.dart';

import '../../../styles/fonts.dart';

class changePassword extends StatefulWidget {
  const changePassword({Key? key}) : super(key: key);

  @override
  State<changePassword> createState() => _changePassState();
}

class _changePassState extends State<changePassword> {
  @override
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  bool ispasswordvisible=true;

  final TextEditingController newpasswordcontoller = new TextEditingController();

  final currentuser = FirebaseAuth.instance.currentUser;

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
          fontWeight: FontWeight.w900, fontSize: 12.0, fontFamily:
      "NotoSansMono",
          letterSpacing: 1.0),),
          centerTitle: true, backgroundColor: Colors.yellow,
          elevation: 0.0,
          actions: [
            TextButton.icon( onPressed:(){
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(title: const Row(children: [Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.warning_amber,color: Colors.redAccent,size: 30,
                  ),
                ),Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Log Out!",style: TextStyle(fontFamily: "NotoSnasMono",color: Colors.red,
                      fontSize: 20,fontWeight: FontWeight.w900),),
                ),
                ],
                ),content: const Text("Confirm You want to Log out?",style:
                TextStyle(fontFamily: "NotoSnasMono",fontSize: 16,fontWeight: FontWeight.w600)),
                  actions: [TextButton(onPressed: ()async{
                    Navigator.pop(context);
                  }, child: const Text("No stay In",style: TextStyle(fontFamily: "NotoSnasMono",
                      fontSize: 20,fontWeight: FontWeight.w900),),),
                    TextButton(onPressed: ()async{
                      Navigator.pop(context);
                      await _auth.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginSignupPage()));
                    }, child: const Text("Yess Log Out please",style: TextStyle(fontFamily: "NotoSnasMono",
                        fontSize: 18,fontWeight: FontWeight.w900),))],
                );
              });
            },
              icon: Icon(Icons.logout,size: 30,color: Colors.red[900],),label: const Text("Log out",
                style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14.0,fontFamily:
                "NotoSansMono",color: Colors.red
                ),),
            ),]
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w*2.0,
              height: h * 0.30,
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
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(70)),
              child: const Text(
                "Provide New Password",
                style: TextStyle(fontFamily: "NotoSansMono",color: Colors.white,
                    fontWeight: FontWeight.w900, fontSize: 16.0),),),
            SizedBox(height: Get.height*0.02),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: TextFormField(

                  decoration: InputDecoration(suffixIcon: GestureDetector(onTap: (){
                    setState(() {
                      ispasswordvisible =! ispasswordvisible;
                    });
                  },
                      child: Icon(ispasswordvisible ? Icons.visibility : Icons.visibility_off
                        ,size: 25,color: Colors.white,)),
                      labelText: 'New Password',labelStyle: const TextStyle(color: Colors.white),
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
                      fontFamily: 'NotoSansMono',color: Colors.white,
                      fontWeight: FontWeight.w600),
                  autofocus: false,
                  controller: newpasswordcontoller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Kindly New Password Can not be Empty";
                    }
                    if (value.length <6)
                    {
                      return ("INVALID Password!!, It Must Contain 6 or more character");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newpasswordcontoller.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  obscureText: ispasswordvisible,

                ),
              ),
            ),
            SizedBox(height:Get.height*0.02),

            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: ElevatedButton.icon(onPressed: () {
                if(formKey.currentState!.validate()){


                  changepassword(newpasswordcontoller.text);


                }},
                  style:ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      backgroundColor: Colors.cyan),
                  icon: const Icon(
                    CupertinoIcons.doc_checkmark_fill, color: Colors.white,size: 30,),
                  label: const Text
                    ("Save New Password",
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

  changepassword(String newpas) async{
    try{
      await currentuser!.updatePassword(newpas);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginSignupPage()));
      const SnackBar(content: Text("Password Changed! Log in Using the New Password"),
        duration: Duration(seconds: 5),backgroundColor: Colors.green,);

    }catch(err){
      showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text(err.toString(),),
          actions: [TextButton(onPressed: () async {
            Navigator.pop(context);
          }, child:  Text("OKAY", style:AppFonts.heading1))],);
      });
    }
  }
}



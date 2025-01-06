import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testApp/screens/auth/login.dart';
import 'package:testApp/screens/main/topics.dart';
import 'package:get/get.dart';
import 'package:testApp/screens/main/userAccountSettings/changePassword.dart';

import 'deleteAccount.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  FirebaseAuth _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF024F31),
        appBar: AppBar(backgroundColor:Colors.transparent,leading: IconButton(onPressed: () {
          {
            Get.to(TopicListScreen());
          }
        },
          icon: const Icon(CupertinoIcons.back, color: Colors.white,size: 25,),),
          elevation: 1,

        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(splashColor: Colors.green,onTap: (){Get.to(const deleteAccount());},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(CupertinoIcons.delete,size: 40,color: Colors.redAccent,),
                      SizedBox(width: 5,),Text("Delete Account",
                          style: TextStyle(
                              fontFamily: 'NotoSansMono', fontWeight: FontWeight.w700,
                              fontSize: 20.0, color: Colors.white)),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.01),
                const Divider(height: 2,thickness: 2,color: Colors.white),
                SizedBox(height:Get.height*0.04),
                InkWell(splashColor: Colors.redAccent,onTap: (){
                  Get.to(const changePassword());
                },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(CupertinoIcons.keyboard_chevron_compact_down,size: 40,color: Colors.redAccent,),
                      SizedBox(width: 5,),Text("Change Password",
                          style: TextStyle(
                              fontFamily: 'NotoSansMono', fontWeight: FontWeight.w700,
                              fontSize: 20.0, color: Colors.white)),

                    ],
                  ),
                ),
                 SizedBox(height: Get.height*0.04),
                const Divider(height: 2,thickness: 2,color: Colors.red),
                SizedBox(height: Get.height*0.04),
                InkWell(splashColor:Colors.redAccent,onTap: (){
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(title: const Row(children: [Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.warning_amber,color: Colors.red,
                      ),
                    ),Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Log Out!",style: TextStyle(fontFamily: "NotoSnasMono",
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
                          //Navigator.pop(context);
                          //await _auth.signOut();
                          Get.to(const LoginSignupPage());
                        }, child: const Text("Yess Log Out please",style: TextStyle(fontFamily: "NotoSnasMono",
                            fontSize: 18,fontWeight: FontWeight.w900),))],
                    );});
                },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(CupertinoIcons.return_icon,size: 40,color: Colors.redAccent,),
                      SizedBox(width: 5,),Text("Log Out",
                          style: TextStyle(
                              fontFamily: 'NotoSansMono', fontWeight: FontWeight.w700,
                              fontSize: 22.0, color: Colors.white)),

                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.04),
                const Divider(height: 2,thickness: 2,color: Colors.white),
              ],
            ),
          ),


        )
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class usermodel extends ChangeNotifier{
  String? phone;
  String? email;
  String? password;
  String? uid;




  usermodel(
      {this.phone, this.email, this.password, this.uid});


  usermodel.fromSnapshot(DataSnapshot dataSnapshot) {
    phone =  (dataSnapshot.child("fname").value.toString());
    email = (dataSnapshot.child("email").value.toString());
    password =  (dataSnapshot.child("pass").value.toString());
    uid =  (dataSnapshot.child("UID").value.toString());

  }



  //Receiving data from server
  factory usermodel.fromMap(map){
    return usermodel(
      phone: map['phone'],
      email: map['email'],
      password: map['password'], uid: map['UID'],



    );
  }

//sending data to server
  Map<String, dynamic> toMap() {
    return {
      'phone' : phone,
      'email': email,
      'password': password,
      'UID':uid,



    };
  }

  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      'email' : email,
      "password": password,
      "UID":uid,


    };
  }
}
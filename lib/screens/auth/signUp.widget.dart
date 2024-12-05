import 'package:flutter/material.dart';

import '../../styles/fonts.dart';
import '../../widegts/customButtonWithIcon.dart';
import '../../widegts/customInputField.dart';
import '../../widegts/passwordField.dart';

Widget buildSignupForm() {
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
           Row(
            children: [
              const Expanded(child: Divider(thickness: 2, color: Colors.grey)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Or Fill in the form below to Register",
                  style: AppFonts.subHeading.copyWith(fontSize: 12),
                  //style: AppFonts.bodyText.copyWith(fontSize: 18.0),
                ),
              ),
              const Expanded(child: Divider(thickness: 2, color: Colors.grey,)),
            ],
          ),
          const SizedBox(height: 20),
          const CustomInputField(
            labelText: "Phone",
            iconData: Icons.phone_android,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 10),
          const CustomInputField(
            labelText: "Email Address",
            iconData: Icons.email_outlined,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 10),
          const passwordField(
            isPasswordField: true,
            labelText: "Password",
            iconData: Icons.lock,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 10),
          const passwordField(
            isPasswordField: true,
            labelText: "Confirm Password",
            iconData: Icons.password_rounded,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 20),
          CustomButtonWithIcon(
            text: 'Sign Up',
            iconPath: 'assets/images/regicon.png',
            onPressed: () {},
          ),

          //terms of service
          const SizedBox(height: 10),
          const Text.rich(
            TextSpan(
              text: "By signing in with an account, you agree to our ",
              style: TextStyle(fontFamily:'Inter',fontWeight:FontWeight.w200,fontSize: 12, color: Colors.grey),
              children: [
                TextSpan(
                  text: "\nTerms of Service",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    decoration: TextDecoration.underline,
                    color: Color(0xFF024F31),
                  ),
                ),
                TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy Policy.",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w200,
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
  );
}
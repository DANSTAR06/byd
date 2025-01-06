import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:testApp/screens/main/topics.dart';
import 'package:testApp/styles/fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _seconds = 10; // Countdown from 10 seconds
  bool _isBlinking = false; // To control the blinking effect
  String? _userEmail; // To store the user's email
  String? _userName;

  @override
  void initState() {
    super.initState();
    _getCurrentUser(); // Fetch the user's email
    _startCountdown(); // Start the countdown and blinking effect
    _getUserName();
  }

  void _getCurrentUser() {
    // Fetch the current authenticated user
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _userEmail = user?.email ?? 'User'; // Use 'User' as fallback if no email
    });
  }

  //get name from mail

  void _getUserName() {
    // Fetch the current authenticated user
    User? user = FirebaseAuth.instance.currentUser;
    if (user?.email != null) {
      // Extract username from email (part before '@')
      setState(() {
        _userName = user!.email!.split('@')[0];
        _userName=_userName?.toUpperCase();
      });
    } else {
      // Fallback if no email is found
      setState(() {
        _userName = 'User';
      });
    }
  }


  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
          _isBlinking = !_isBlinking; // Toggle blinking effect
        });
        _startCountdown(); // Keep calling the countdown recursively
      } else {
        // Redirect to the questions screen after countdown
        Get.to(() => TopicListScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EEC7),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo at top-right of the page
            Align(
              alignment: Alignment.topRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 3, 40),
                    child: Image.asset(
                      'assets/images/aalogo.png',
                      width: 60,
                    ),
                  ),
                  const Text(
                    'Driving\nTest App',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: Color(0xFF024F31),
                    ),
                  ),
                ],
              ),
            ),
            // Welcome Text
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text(
              'Welcome Back,\t$_userName.', // Display user's email/name
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Color(0xFF024F31),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            // Centered Image
            Center(
              child: Image.asset('assets/images/ride.png'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            // Countdown Text
            Center(
              child: Text(
                'Redirecting in:',
                style: AppFonts.heading1,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Center(
              child: Text(
                '\t$_seconds seconds',
                style: AppFonts.heading1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

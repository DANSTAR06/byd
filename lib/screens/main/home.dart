import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_v2/screens/main/topics.dart';
import 'package:test_app_v2/styles/fonts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _seconds = 10;  // Countdown from 10 seconds
  bool _isBlinking = false;  // To control the blinking effect

  @override
  void initState() {
    super.initState();
    // Start the countdown and blinking effect
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
          _isBlinking = !_isBlinking;  // Toggle blinking effect
        });
        _startCountdown();  // Keep calling the countdown recursively
      } else {
        // Redirect to the questions screen after 5 seconds
        Get.offAll(() => TopicListScreen());
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
                    padding: const EdgeInsets.fromLTRB(20, 40, 2, 40),
                    child: Image.asset(
                      'assets/images/aalogo.png',
                      width: 60,
                    ),
                  ),
                  const Text(
                    'Driving\nTest App',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Color(0xFF024F31),
                    ),
                  ),
                ],
              ),
            ),
            // Welcome Text
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            const Text(
              'Welcome Back User', // Display user name or default text
              style: TextStyle(
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
              child:  Text('Redirecting in:',style: AppFonts.heading1),
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

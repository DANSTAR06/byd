import 'package:flutter/material.dart';
import 'dart:async';


import 'intro_one.dart';

//import 'auth/login.screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Time for one blink
      vsync: this,
    )..repeat(reverse: true); // Repeat blinking

    // Define animation (fade in and out)
    _animation = Tween<double>(begin: 0.0, end: 2.0).animate(_controller);

    // Navigate to the next screen after a delay
    Timer(const Duration(seconds: 10), () {
      _navigateToHome();
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const IntroScreenOne()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF5EEC7)
      backgroundColor: const Color(0xFFF5EEC7), // Background color
      body: Center(
        child: FadeTransition(
          opacity: _animation, // Apply the animation
          child: Image.asset(
            'assets/images/aalogo.png', // Logo path
            width: 200, // Adjust size as needed
            height: 200,
          ),
        ),
      ),
    );
  }
}
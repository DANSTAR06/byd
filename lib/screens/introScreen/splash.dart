import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart'; // Import Lottie package
import '../../controllers/auth.dart';
import '../main/home.dart';
import 'intro_one.dart'; // Import your next screen
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
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
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Navigate to the next screen after a delay
    Timer(const Duration(seconds: 7), () {
      _navigateToIntro();
    });
  }

  void _navigateToIntro() {
    // Example: Navigate based on authentication state
    if (AuthController.instance.user != null) {
      Get.offAll(() => const HomeScreen()); // Navigate to home if authenticated
    } else {
      Get.offAll(() => const IntroScreenOne()); // Navigate to intro screen
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF024F31),
      body: Stack(
        children: [
          // Lottie animation as background
          Center(
            child: Lottie.asset(
              'assets/anime/truckongreenanime.json', // Lottie file path
              fit: BoxFit.cover, // Covers the entire screen
              //width: Get.width*1.80,
              //height:double.infinity,
            ),
          ),
          // Logo with FadeTransition
          Align(
            alignment: Alignment.bottomRight,
            child: FadeTransition(
              opacity: _animation, // Apply fade animation
              child: Image.asset(
                'assets/images/aalogo.png', // Logo path
                width: Get.width*2.0,
                height: Get.height*2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

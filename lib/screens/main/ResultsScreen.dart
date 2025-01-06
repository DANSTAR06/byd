import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../styles/fonts.dart';
import '../../widegts/button.dart';

class ResultScreen extends StatelessWidget {
  final double score;
  final int correctAnswers;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // Extract username from email
    String userName = user?.email?.split('@')[0] ?? "User";
    String usermail = user?.email ?? 'User Email?';

    userName = userName.toUpperCase();

    bool isPassed = score >= 80;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge Design
            Stack(
              alignment: Alignment.center,
              children: [
                // Outer gold circle
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.amber, // Gold border color
                    shape: BoxShape.circle,
                  ),
                ),
                // Inner dark green circle
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.green.shade900, // Dark green background
                    shape: BoxShape.circle,
                  ),
                ),
                // White inner content circle
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white, // White inner circle
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Your Score:\n${correctAnswers}/${totalQuestions}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isPassed ? Colors.green : Colors.red, // Text color based on pass/fail
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height* 0.06), // Space below the badge
            // Result message
            Text(
              isPassed
                  ? "Congratulations, $userName! You passed!"
                  : "Oops! You didn't do so well, $userName.",
              textAlign: TextAlign.center,
              style: AppFonts.heading1,
            ),
            SizedBox(height: Get.height* 0.04), // Space before buttons
            // View Results Button
            CustomButton(
              label: "View Results",
              onPressed: () {
                // Navigate to detailed results page
              },
            ),
             SizedBox(height: Get.height* 0.04), // Space between buttons
            // Back to Home Button
            CustomButton(
              label: "Back to Home",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

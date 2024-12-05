import 'package:flutter/material.dart';

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
    bool isPassed = score >= 80;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Text(
                "Your Score: ${correctAnswers}/${totalQuestions}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isPassed ? Colors.green : Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isPassed ? "Congratulations! You passed!" : "Oops! You failed!",
              style: AppFonts.heading1,
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: "View Results",
              onPressed: () {
                // Navigate to detailed results page
              },
            ),
            const SizedBox(height: 8),
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

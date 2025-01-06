import 'package:flutter/material.dart';

import '../../widegts/button.dart';
import '../../widegts/sidebar.dart';
import 'ResultsScreen.dart';
import 'package:get/get.dart';


class QuizScreen extends StatefulWidget {
  final String topicName;
  final int questionIndex; // Current question index
  final int totalQuestions; // Total number of questions

  const QuizScreen({
    super.key,
    required this.topicName,
    required this.questionIndex,
    required this.totalQuestions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Map<int, bool> showAnswers = {
  }; // Keep track of show/hide answer per question
  int _currentIndex = 0; // Active question index
  Map<int, String> userAnswers = {}; // Store user answers

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is required to drive On Kenyan Roads?",
      "options": [
        "Driving license",
        "Vehicle Insurance",
        "Vehicle documents",
        "All the above"
      ],
      "answer": "All the above",
    },
    {
      "question": "What are the common Causes of Road Accidents?",
      "options": [
        "Over speeding",
        "Pumping Brakes",
        "Driving Old Vehicles",
        "All the above"
      ],
      "answer": "Over speeding", // Corrected case to match comparison
    },
    {
      "question": "Which one of the following is a compulsory traffic sign?",
      "options": [
        "Pass to the left",
        "River Bank ahead",
        "Pedestrian crossing place",
        "Proceed straight or turn left"
      ],
      "answer": "Pass to the left",
    }
    // Add more questions as needed
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.questionIndex; // Initialize the current index
  }

  void _selectAnswer(String answer) {
    setState(() {
      userAnswers[_currentIndex] = answer;
    });
  }

  void _submitQuiz() {
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == questions[i]['answer']) {
        correctAnswers++;
      }
    }
    double scorePercentage = (correctAnswers / questions.length) * 100;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultScreen(
              score: scorePercentage,
              correctAnswers: correctAnswers,
              totalQuestions: questions.length,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[_currentIndex];

    return Scaffold(
      drawer: UserSidebar(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.topicName,
          style: const TextStyle(
              fontFamily: "Inter", fontSize: 16, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Question: ${_currentIndex + 1}/${widget.totalQuestions}",
                    style: const TextStyle(fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.green),
                  ),
                ),
                const Spacer(),
                InkWell(
                  child: const Text(
                    'Quit',
                    style: TextStyle(fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
             SizedBox(height: Get.height * 0.02),
            Text(
              currentQuestion["question"],
              style: const TextStyle(fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Get.height * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion["options"].length,
                itemBuilder: (context, index) {
                  String option = currentQuestion["options"][index];
                  bool isSelected = userAnswers[_currentIndex] == option;

                  return GestureDetector(
                    onTap: () => _selectAnswer(option),
                    child: OptionCard(option: String.fromCharCode(65 + index),
                        text: option,
                        isSelected: isSelected),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  showAnswers[_currentIndex] =
                  !(showAnswers[_currentIndex] ?? false);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    (showAnswers[_currentIndex] ?? false)
                        ? "Hide Answer"
                        : "Show Answer",
                    style: const TextStyle(fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            if (showAnswers[_currentIndex] ?? false) ...[
              SizedBox(height: Get.height * 0.01),
              Text(
                "Answer: ${currentQuestion["answer"]}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
             SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_currentIndex > 0)
                  CustomButton(
                    label: "Previous",
                    onPressed: () {
                      setState(() {
                        _currentIndex--;
                      });
                    },
                  ),
                SizedBox(height: Get.height * 0.01),
                if (_currentIndex < widget.totalQuestions - 1)
                  CustomButton(
                    label: "Next",
                    onPressed: () {
                      setState(() {
                        _currentIndex++;
                      });
                    },
                  ),
                if (_currentIndex == widget.totalQuestions - 1)
                  CustomButton(
                    label: "Submit",
                    onPressed: _submitQuiz,
                  ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _buildNavBarItem(Icons.home, 0),
          _buildNavBarItem(Icons.history, 1),
          _buildNavBarItem(Icons.notifications, 2),
        ],
        backgroundColor: const Color(0xFF024F31),
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index ? Colors.yellow : Colors.transparent,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          color: _currentIndex == index ? Colors.green : Colors.white,
        ),
      ),
      label: "",
    );
  }
}
  class OptionCard extends StatelessWidget {
    final String option;
    final String text;
    final bool isSelected;

    const OptionCard(
        {super.key, required this.option, required this.text, this.isSelected = false});

    @override
    Widget build(BuildContext context) {
      return Card(
        color: isSelected ? Colors.green : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: isSelected ? Colors.white : Colors.green,
                child: Text(
                  option,
                  style: TextStyle(
                      color: isSelected ? Colors.green : Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

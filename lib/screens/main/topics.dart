import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widegts/sidebar.dart';
import 'QuizScreen.dart';

class Topic {
  final String title;
  final String description;

  Topic({required this.title, required this.description});
}

class TopicListController extends GetxController {
  var topics = <Topic>[
    Topic(title: "Topic 1", description: "Introduction to Driving"),
    Topic(title: "Topic 2", description: "Road Safety Tips"),
    Topic(title: "Topic 3", description: "Traffic Signs"),
  ].obs;
}

class TopicListScreen extends StatelessWidget {
  final TopicListController controller = Get.put(TopicListController());

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Exit"),
        content: const Text("Are you sure you want to go back?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Stay on the screen
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Exit the screen
            },
            child: const Text("Okay"),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        drawer: UserSidebar(),
        appBar: AppBar(
          title: const Text("Topics"),
          centerTitle: true,
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: controller.topics.length,
            itemBuilder: (context, index) {
              final topic = controller.topics[index];
              return ListTile(
                leading: const Icon(Icons.book, color: Colors.green),
                title: Text(topic.title),
                subtitle: Text(topic.description),
                trailing: const Icon(Icons.lock, color: Colors.red),
                onTap: () {
                  // Navigate to the quiz screen with the selected topic
                  Get.to(() => QuizScreen(
                    topicName: topic.title,
                    questionIndex: index,
                    totalQuestions: controller.topics.length,
                  ));
                },
              );
            },
          );
        }),
      ),
    );
  }
}

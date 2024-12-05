import 'package:flutter/material.dart';
import 'package:test_app_v2/screens/auth/login.dart';

import '../screens/main/topics.dart';
import 'package:get/get.dart';

import '../styles/fonts.dart';


class UserSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF024F31),
      child: Column(
        children: [
          // User Profile Section
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/screentwo.png'), // Background image
                fit: BoxFit.contain,
              ),
            ),
            child: UserProfile(),
          ),
          // List of Options
          Expanded(
            child: ListView(
              children: [
                SidebarOption(
                  title: "Home",
                  icon: Icons.home,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TopicListScreen()),
                    );
                  },
                ),
                SidebarOption(
                  title: "Topics",
                  icon: Icons.topic,
                  onTap: () {
                    // Navigate to Topics page
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Get.off(() =>  TopicListScreen());
                    });
                  },
                ),
                SidebarOption(
                  title: "Settings",
                  icon: Icons.settings,
                  onTap: () {
                    // Navigate to Settings page
                  },
                ),
                SidebarOption(
                  title: "Logout",
                  icon: Icons.logout,
                  onTap: () {
                    // Handle Logout
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Get.off(() => const LoginSignupPage());
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*const CircleAvatar(
            radius: 40,
           // backgroundImage: AssetImage('assets/images/screentwo.png'), // User avatar
          ),*/
          const SizedBox(height: 20),
          Align(alignment: Alignment.centerLeft,
            child: Text(
              "User Name", // User name
              style: AppFonts.heading2
              ),
          ),
        ],
      ),
    );
  }
}

class SidebarOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  SidebarOption({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: Colors.white,size: 24,),
      title: Text(title,style: AppFonts.heading2,),
      onTap: onTap,
    );
  }
}
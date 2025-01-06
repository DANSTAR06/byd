import 'package:flutter/material.dart';
import 'package:testApp/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:testApp/screens/main/userAccountSettings/settings.dart';
import '../controllers/auth.dart';
import '../screens/main/topics.dart';
import 'package:get/get.dart';
import '../styles/fonts.dart';

class UserSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: const Color(0xFF024F31),
      child: Column(
        children: [
          // User Profile Section
          Container(
            height: h*0.20,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/aalogo.png'), // Background image
                fit: BoxFit.fill,
              ),
            ),
            child: UserProfile(), // Updated UserProfile widget
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
                      Get.off(() => TopicListScreen());
                    });
                  },
                ),
                SidebarOption(
                  title: "Settings",
                  icon: Icons.settings,
                  onTap: () {
                    Get.to(const settings());
                    // Navigate to Settings page
                  },
                ),
                SidebarOption(
                  title: "Logout",
                  icon: Icons.logout,
                  onTap: () async{
                    // Handle Logout
                    final authController = AuthController.instance;
                    //await authController.signOut();
                    Get.to(const LoginSignupPage());
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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    // Fetch the current authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    // Extract username from email
    String userName = user?.email?.split('@')[0] ?? "User";
    String usermail =user?.email??'User Email?';

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: h * 0.03),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              userName.toUpperCase(), // Display dynamic username
              style: AppFonts.heading2.copyWith(fontSize: 24,fontWeight: FontWeight.w900,backgroundColor: const Color(0xFF024F31)),
            ),

          ),
          SizedBox(height: h * 0.01),
          Text(
            usermail, // Display dynamic username
            style: AppFonts.heading1.copyWith(fontSize: 20,fontWeight: FontWeight.w700,color: const Color(0xFF024F31),backgroundColor: Colors.yellow),
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
      leading: Icon(
        icon,
        color: Colors.white,
        size: 32,
      ),
      title: Text(
        title,
        style: AppFonts.heading2,
      ),
      onTap: onTap,
    );
  }
}

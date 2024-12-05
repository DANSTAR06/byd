import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_v2/screens/auth/signUp.widget.dart';
import '../../controllers/login_signup.dart';
import '../../widegts/customButtonWithIcon.dart';
import '../../widegts/customInputField.dart';
import '../../widegts/passwordField.dart';
import '../main/home.dart';


class LoginSignupPage extends StatelessWidget {
  const LoginSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginSignupController()); // Initialize controller
    return Scaffold(
      backgroundColor: const Color(0xFFF5EEC7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.04), // Use Get.height
              const Text(
                "Welcome to AA Kenya\n TestApp",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF024F31),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * 0.01),
              const Text(
                "Login or sign up to access your account",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * 0.01),
              TabBar(
                controller: controller.tabController,
                indicatorColor: const Color(0xFFF5EEC7),
                labelColor: const Color(0xFF024F31),
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: "Login"),
                  Tab(text: "Sign Up"),
                ],
              ),
              SizedBox(height: Get.height * 0.04),
              SizedBox(
                height: Get.height * 0.9,
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    buildLoginForm(controller),
                    buildSignupForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm(LoginSignupController controller) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/icongoogle.png',
                width: 28,
                height: 28,
              ),
              label: const Text(
                "Login with Google",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.apple, color: Colors.black, size: 36),
              label: const Text(
                "Login with Apple",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            const Row(
              children: [
                Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "or continue with email",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Colors.black87,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
                Expanded(child: Divider(thickness: 2, color: Colors.grey)),
              ],
            ),
            SizedBox(height: Get.height * 0.04),
            const CustomInputField(
              labelText: 'Email Address',
              iconData: Icons.email_outlined,
            ),
            SizedBox(height: Get.height * 0.02),
            const passwordField(
              labelText: 'Password',
              iconData: Icons.password,
              isPasswordField: true,
            ),
            SizedBox(height: Get.height * 0.01),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Color(0xFF024F31),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            CustomButtonWithIcon(
              text: 'Login',
              iconPath: 'assets/images/logincon.png',
              onPressed: () {
                Get.off(() => const HomeScreen());
              },
            ),
            SizedBox(height: Get.height * 0.01),
            const Text.rich(
              TextSpan(
                text: "By signing in with an account, you agree to our ",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: Colors.grey),
                children: [
                  TextSpan(
                    text: "\nTerms of Service",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w100,
                      decoration: TextDecoration.underline,
                      color: Color(0xFF024F31),
                    ),
                  ),
                  TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy.",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.underline,
                      color: Color(0xFF024F31),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

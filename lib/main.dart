import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:testApp/screens/introScreen/splash.dart';


import 'controllers/auth.dart';

import 'utils/translations.dart';
import 'screens/introScreen/intro_one.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    print("Firebase Initialized Successfully!");
    Get.put(AuthController()); // Initialize AuthController
  }).catchError((error) {
    Get.snackbar("Error", "You may NOT be connected",
        backgroundColor: Colors.red, duration: const Duration(seconds: 10));
    print("Error initializing Firebase: $error");
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.native,
      translations: MyTranslations(),
      locale: const Locale('en', 'US'),
      home: const SplashScreen(), // SplashScreen as the initial screen
      getPages: [
        GetPage(name: '/Intro_one', page: () => const IntroScreenOne()),
      ],
    );
  }
}

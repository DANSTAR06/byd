import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_v2/screens/auth/login.dart';
import 'package:test_app_v2/screens/introScreen/splash.dart';

import 'utils/transitions.dart';
import 'utils/translations.dart';
import 'screens/introScreen/intro_one.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner:false,
      initialRoute: '/home',
      defaultTransition: Transition.native,
      translations: MyTranslations(),
      locale: const Locale('en', 'US'),
      getPages: [
        GetPage(name: '/home', page: () => const SplashScreen()),
        GetPage(
          name: '/second',
          page: () => const IntroScreenOne(),
          customTransition: SizeTransitions(),
        ),

        GetPage(
          name: '/third',
          transition: Transition.cupertino,
          page: () => const LoginSignupPage(),
        ),
      ],
    );
  }
}

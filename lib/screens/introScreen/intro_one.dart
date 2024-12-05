import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:lottie/lottie.dart';

import '../auth/login.dart';


class IntroScreenOne extends StatefulWidget {
  const IntroScreenOne({super.key});

  @override
  State<IntroScreenOne> createState() => _IntroScreenOneState();
}

class _IntroScreenOneState extends State<IntroScreenOne> {
  // 1. Define a GlobalKey for IntroductionScreen
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
    designSize: const Size(375, 812),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF), // Light beige background #FFFFFF
        body: IntroductionScreen(
          key: _introKey,
          globalBackgroundColor: const Color(0xFFFFFFFF),
          pages: [
            // Page 1
            PageViewModel(
              title: "Access verified\ntest materials",
              bodyWidget: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get access to high class driving and \nNTSA test materials approved \nby our competent team to help \nyou ace your driving test.",
                    textAlign: TextAlign.center, // Center the text
                    style: TextStyle(
                      fontFamily: 'Inter', // Specify font family (make sure you have this font in assets or Google Fonts)
                      fontWeight: FontWeight.w600, // Font weight 400
                      fontSize: 16, // Font size 17.46px
                      height: 21.13 / 17.46, // Line height is the ratio (Line height / Font size)
                      letterSpacing: 0.02, // Letter spacing 2%
                    ),
                  ),
                ],
              ),

              image: Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: Align(
                  alignment: const Alignment(-1.8, -4.0), // Position the image using Figma's Top and Left values
                  child: SizedBox(
                    width: 400, // Set width from Figma
                    height: 450, // Set height from Figma
                    child: Image.asset(
                      'assets/images/screenone.png', // Replace with your image path
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              decoration: const PageDecoration(
                titleTextStyle: TextStyle(
                  fontFamily: 'Inter', // Match with the body font
                  fontWeight: FontWeight.w900, // Match body font weight
                  fontSize: 24,
                  height: 24.0 / 22.0, // Match body line height ratio
                  letterSpacing: 0.04, // Match body letter spacing
                  color: Color(0xFF024F31), // Dark green color for the title
                ),
                bodyFlex: 2,
              ),
            ),
            // Page 2
            PageViewModel(
              title: "Test Your Gained Skills",
              bodyWidget:const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Access and attempt simulated \ntest materials that will help you \nput into practice your learnt skills",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter', // Use Inter font
                      fontWeight: FontWeight.w400, // Font weight 400
                      fontSize: 18, // Font size 17.46px
                      height: 21.13 / 17.46, // Line height based on font size
                      letterSpacing: 0.02, // Letter spacing 2%
                    ),
                  ),
                ],
              ),
              image: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Align(
                  alignment: const Alignment(0.0, 0.0), // Adjust alignment if needed
                  child: SizedBox(
                    width: 400,
                    height: 450,
                    child: Image.asset(
                      'assets/images/screentwo.png', // Replace with the second image asset path
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

              ),

              decoration: const PageDecoration(
                titleTextStyle: TextStyle(
                  fontFamily: 'Inter', // Match with the body font
                  fontWeight: FontWeight.w800, // Match body font weight
                  fontSize: 24, // Match body font size
                  height: 24.0 / 22.0, // Match body line height ratio
                  letterSpacing: 0.04, // Match body letter spacing
                  color: Color(0xFF024F31), // Dark green color for the title
                ),
                bodyFlex: 2,
              ),
            ),
            //page 3
            PageViewModel(
              title: "Test Your Driving Skills",
              bodyWidget: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "AA Kenya.\n Inspiring Mobility😜",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter', // Use Inter font
                      fontWeight: FontWeight.w700, // Font weight 400
                      fontSize: 16, // Font size 17.46px
                      height: 25 / 25, // Line height based on font size
                      letterSpacing: 0.02, // Letter spacing 2%
                      color: Color(0xFF024F31),
                    ),
                  ),
                ],
              ),
              image: Container(
                margin: const EdgeInsets.only(top: 80.0),
                child: Align(
                  alignment: const Alignment(1.7, -4.0), // Adjust alignment if needed
                  child: SizedBox(
                    width: 400,
                    height: 450,
                    child: Lottie.asset(
            'assets/anime/dsc.json',
            fit: BoxFit.contain,
          ),
                  ),
                ),
              ),
              decoration: const PageDecoration(
                titleTextStyle: TextStyle(
                  fontFamily: 'Inter', // Match with the body font
                  fontWeight: FontWeight.w600, // Match body font weight
                  fontSize: 24, // Match body font size
                  height: 25.0 / 25.0, // Match body line height ratio
                  letterSpacing: 0.02, // Match body letter spacing
                  color: Color(0xFF024F31), // Dark green color for the title
                ),
                bodyFlex: 2,
              ),
            ),
          ],
          onDone: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.off(() => const LoginSignupPage());
            });
          },

          showSkipButton: true,
          skip: const Text(
            "Skip",
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF024F31),
            ),
          ),
          //white icon on darkgreen background
          next: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF024F31), // Dark green color
              shape: BoxShape.circle,  // Makes the background circular
            ),
            padding: const EdgeInsets.all(8.0), // Adjust padding for spacing
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
          ),

          done: const Text("Done", style: TextStyle(fontFamily:'Inter',fontWeight: FontWeight.w600,color: Color(0xFF024F31),fontSize: 18,)),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Colors.amberAccent,
            activeSize: Size(22.0, 10.0),
            activeColor: Color(0xFF024F31), // Dark green active dot
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
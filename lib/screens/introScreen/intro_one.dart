import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:lottie/lottie.dart';

import '../../styles/fonts.dart';
import '../auth/login.dart';


class IntroScreenOne extends StatefulWidget {
  const IntroScreenOne({super.key});

  @override
  State<IntroScreenOne> createState() => _IntroScreenOneState();
}

class _IntroScreenOneState extends State<IntroScreenOne> {

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
              title: "Access verified test materials",
              bodyWidget: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get access to high class driving and NTSA test materials\n approved by our competent team to help you ace your driving test.",
                    textAlign: TextAlign.center, // Center the text
                    style: TextStyle(
                      fontFamily: 'Inter', // Specify font family (make sure you have this font in assets or Google Fonts)
                      fontWeight: FontWeight.w600, // Font weight 400
                      fontSize: 16, // Font size 17.46px
                      height: 21 / 18, // Line height is the ratio (Line height / Font size)
                      letterSpacing: 0.05, // Letter spacing 2%
                    ),
                  ),
                ],
              ),

              image: Container(
                margin: const EdgeInsets.only(top: 60.0),
                child: Align(
                  alignment: const Alignment(-1.8, -4.0), // Position the image using Figma's Top and Left values
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 3.0, // Set width from Figma
                    height:MediaQuery.of(context).size.height * 3.6,
                    child: Image.asset(
                      'assets/images/sc.png', // Replace with your image path
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              decoration: const PageDecoration(
                titleTextStyle: TextStyle(
                  fontFamily: 'Inter', // Match with the body font
                  fontWeight: FontWeight.w900, // Match body font weight
                  fontSize: 24,
                  height: 24.0 / 23.0, // Match body line height ratio
                  letterSpacing: 0.05, // Match body letter spacing
                  color: Color(0xFF024F31), // Dark green color for the title
                ),
                bodyFlex: 1,
              ),
            ),
            // Page 2
            PageViewModel(
              title: "Test Your Gained Skills",
              bodyWidget:const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Access and attempt simulated test materials that will help you put into practice your riding skills",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter', // Use Inter font
                      fontWeight: FontWeight.w700, // Font weight 400
                      fontSize: 18, // Font size 17.46px
                      height: 22 / 20, // Line height based on font size
                      letterSpacing: 0.05, // Letter spacing 5%
                    ),
                  ),
                ],
              ),
              image: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Align(
                  alignment: const Alignment(0.0, 0.0), // Adjust alignment if needed
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 2.0, // Set width from Figma
                    height:MediaQuery.of(context).size.height * 3.6,
                    child: Image.asset(
                      'assets/images/ride.png', // Replace with the second image asset path
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

              ),

              decoration: const PageDecoration(
                titleTextStyle: TextStyle(
                  fontFamily: 'Inter', // Match with the body font
                  fontWeight: FontWeight.w800, // Match body font weight
                  fontSize: 24, // Match body font size
                  height: 28.0 / 26.0, // Match body line height ratio
                  letterSpacing: 0.04, // Match body letter spacing
                  color: Color(0xFF024F31), // Dark green color for the title
                ),
                bodyFlex: 1,
              ),
            ),
            //page 3
            PageViewModel(
              title: "\nTest Your Driving Skills",
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "With AA Kenya \n\n Champions of Mobility\n\n💪\t🚕",
                    textAlign: TextAlign.center,
                    style: AppFonts.heading1,
                  ),
                ],
              ),
              image: Container(
                margin: const EdgeInsets.only(top: 80.0),
                child: Align(
                  alignment: const Alignment(1.7, -4.0), // Adjust alignment if needed
                  child: SizedBox(
                    width: Get.height * 3.8, // Set width from Figma
                    height:Get.width *3.60,
                    child: Lottie.asset(
            'assets/anime/dsc.json',
            fit: BoxFit.cover,
          ),
                  ),
                ),
              ),
              decoration: const PageDecoration(
                titleTextStyle: TextStyle(
                  fontFamily: 'Inter', // Match with the body font
                  fontWeight: FontWeight.w900, // Match body font weight
                  fontSize: 20, // Match body font size
                  height: 20.0 / 20.0, // Match body line height ratio
                  letterSpacing: 0.02, // Match body letter spacing
                  color: Color(0xFF024F31), // Dark green color for the title
                ),
                bodyFlex: 1,
              ),
            ),
          ],
          onDone: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.to(() =>  const LoginSignupPage());
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

          done: const Text("Done", style: TextStyle(fontFamily:'Inter',fontWeight: FontWeight.w600,color: Color(0xFF024F31),fontSize: 20,)),
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
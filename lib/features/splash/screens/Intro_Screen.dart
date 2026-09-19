
import 'package:car_rental/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(

      pages: [



        PageViewModel(
          title: "Hit the Road!",
          body:
              "Pick up your car and start your adventure. Enjoy the freedom of the open road with DriveNow.",
          image: Center(
            child: Lottie.asset(
              'assets/lottie/cars.json'
            )
          ),
          decoration: _pageDecoration(context),
        ),
        PageViewModel(
          title: "Hit the Road!",
          body:
              "Pick up your car and start your adventure. Enjoy the freedom of the open road with DriveNow.",
          image: Center(
            child: Lottie.asset(
              "assets/lottie/meter speedometer car.json",
              height: 600,
              fit: BoxFit.contain,
            ),
          ),
          decoration: _pageDecoration(context),
        ),
        PageViewModel(
          title: "Hit the Road!",
          body:
              "Pick up your car and start your adventure. Enjoy the freedom of the open road with DriveNow.",

          image: Center(
            child: Lottie.asset(
              "assets/lottie/Car Parking Valet.json",
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          decoration: _pageDecoration(context),
        ),

      ],

      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        "Get Started",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),



      onDone: () async {

        final prefs = await SharedPreferences.getInstance();
        final hasSeenIntro = await  prefs.setBool('has_seen_intro' , true);

        if(context.mounted){
          Navigator.pushReplacementNamed(context, '/login');
        }

      },
      onSkip: () async {

        final prefs = await SharedPreferences.getInstance();
        final hasSeenIntro = await  prefs.setBool('has_seen_intro' , true);

        if(context.mounted){
          Navigator.pushReplacementNamed(context, '/login');
        }

      },

      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(22.0, 10.0),
        activeColor: AppColors.primary,
        color: AppColors.borderDark,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  PageDecoration _pageDecoration(BuildContext context) {
    return PageDecoration(

      titleTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.bold,
      ),
      bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,


      imagePadding: const EdgeInsets.only(top: 40),
      contentMargin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}


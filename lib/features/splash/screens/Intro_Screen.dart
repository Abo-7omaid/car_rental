
import 'package:car_rental/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

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
      onDone: () {
        Navigator.pushReplacementNamed(context, '/login');
      },
      onSkip: () {
        Navigator.pushReplacementNamed(context, '/login');
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

// ── Data class for each page ────────────────────────────────────────────────


// class IntroScreen extends StatefulWidget {
//   const IntroScreen({super.key});
//
//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }
//
// class _IntroScreenState extends State<IntroScreen> {
//
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   // Background color for the whole screen
//   static const _bgColor = Color(0xFF1B1B2F);
//
//
//   // Change images and text here
//   final List<_IntroPageData> _pages = const [
//     _IntroPageData(
//       title: 'Easy way to rent\n your dream car',
//       subtitle:
//       'Browse our premium fleet of vehicles.\n'
//           'From economy to luxury — we have\n'
//           'the perfect ride for every journey.',
//       imagePath: 'assets/images/Lamborghini-orange.jpg',
//     ),
//     _IntroPageData(
//       title: 'Book in just\na few taps',
//       subtitle:
//       'Select your dates, choose extras,\n'
//           'and confirm your reservation\n'
//           'instantly — no paperwork needed.',
//       imagePath: 'assets/images/mercedes-yellow.jpg',
//     ),
//     _IntroPageData(
//       title: 'Hit the road\nwith confidence',
//       subtitle:
//       'Pick up your car and start your\n'
//           'adventure. Enjoy the freedom of\n'
//           'the open road with RentRide.',
//       imagePath: 'assets/images/porche.jpg',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

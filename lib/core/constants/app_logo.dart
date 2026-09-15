import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double fontSize;
  final bool showIcon;

  const AppLogo({
    super.key,
    this.fontSize = 28,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    // We grab the colors dynamically from the Theme so the logo
    // magically adapts to Light Mode and Dark Mode!
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final mainTextColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor, // Dark Carbon in Light Mode, Platinum in Dark Mode
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.directions_car,
              color: onPrimaryColor, // Contrasting color for the car icon
              size: fontSize * 0.8,  // Slightly scaled down icon for elegance
            ),
          ),
          const SizedBox(width: 12),
        ],
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Rent',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  color: primaryColor,         // 🔥 Changes "Rent" to Soft Gold!
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: 'Ride',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w300, // Thin/Light for contrast
                  color: mainTextColor,        // Same color, different weight!
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
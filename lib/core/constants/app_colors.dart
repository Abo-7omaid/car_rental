import 'package:flutter/material.dart';

/// A Modern, Luxury Dark/Light Theme Palette
/// Aesthetic: "Carbon & Platinum" - Think Uber Black, Porsche, high-end fashion.
/// Uses deep matte blacks, crisp whites, and brushed steel grays. No cheap neons.
class AppColors {


  // --- The Ultra-Luxury Dark Mode Colors ---

  // This is the deep, dark matte carbon background (almost pitch black)
  // static const Color backgroundDark = Color(0xFF050505);

  // This is the slightly lighter carbon color for the Car Cards so they pop out
  // static const Color surfaceDark = Color(0xFF141414);

  // This is the Champagne Gold for the glowing borders and text

  // This ensures your text on dark mode stays crisp white
  // static const Color textPrimaryDark = Colors.white;



  // ---------------------------------------------------------------------------
  // Core Brand Colors (Monochrome Luxury)
  // ---------------------------------------------------------------------------
  static const Color primary = Color(0xFFDFDEDE); // Deep Carbon
  static const Color primaryLight = Color(0xFF2A2A2A);
  static const Color champagne  = Color(0xFFD4AF37); // Classic Soft Gold

  // static const Color accent = Color(0xFFE5CFA5); // Lighter, softer gold (optional)
  static const Color accent = Color(0xff55ddff); // Lighter, softer gold (optional)

  static const Color accentLight = Color(0xFF20515d);
  // static const Color accentLight = Color(0xFFC59B5F);
  // ─── DARK MODE GOLD ───
  // The luminous, creamy champagne gold you love that glows on black
  static const Color accentDark = Color(0xFF2f7585);
  // static const Color accentDark = Color(0xFFE5CFA5);
  // ---------------------------------------------------------------------------
  // Light Theme Colors (Clean & Minimal)
  // ---------------------------------------------------------------------------
  static const Color backgroundLight = Color(0xFFF9F9F9); // Very subtle off-white
  static const Color surfaceLight = Color(0xFFFFFFFF); // Pure white cards
  static const Color textPrimaryLight = Color(0xFF111111); // Near black text
  static const Color textSecondaryLight = Color(0xFF737373); // Steel gray text
  static const Color borderLight = Color(0xFFE5E5E5); // Soft border
  static const Color dividerLight = Color(0xFFF0F0F0);

  // ---------------------------------------------------------------------------
  // Dark Theme Colors (The Core Luxury Experience)
  // ---------------------------------------------------------------------------
  static const Color backgroundDark = Color(0xFF050505); // True OLED Black
  static const Color surfaceDark = Color(0xFF141414); // Elevated matte surface
  static const Color surfaceDarkHi = Color(0xFF222222); // Hover/Highlight surface
  static const Color textPrimaryDark = Color(0xFFFFFFFF); // Crisp white text
  static const Color textSecondaryDark = Color(0xFFA3A3A3); // Muted silver text
  static const Color borderDark = Color(0xFF2A2A2A); // Subtle dark border
  static const Color dividerDark = Color(0xFF1F1F1F);

  // ---------------------------------------------------------------------------
  // Semantic Colors (Subdued so they don't break the luxury feel)
  // ---------------------------------------------------------------------------
  static const Color success = Color(0xFF34C759); // Crisp clean green
  static const Color error = Color(0xFFFF3B30); // Crisp clean red
  static const Color warning = Color(0xFFFF9F0A); // Subdued amber
  static const Color info = Color(0xFF0A84FF); // Subdued structural blue

  // ---------------------------------------------------------------------------
  // Gradients (For Splash screens or Premium Cards)
  // ---------------------------------------------------------------------------
  static const Color gradientStart = Color(0xFF1C1C1E); // Dark charcoal
  static const Color gradientEnd = Color(0xFF050505); // True black

  // ---------------------------------------------------------------------------
  // Shimmer Loading Effects
  // ---------------------------------------------------------------------------
  static const Color shimmerBaseLight = Color(0xFFE5E5E5);
  static const Color shimmerHighlightLight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF1A1A1A);
  static const Color shimmerHighlightDark = Color(0xFF2A2A2A);

  // ---------------------------------------------------------------------------
  // Shadows (Ultra soft for a floating, premium feel)
  // ---------------------------------------------------------------------------
  static const List<BoxShadow> softShadowLight = [
    BoxShadow(
      color: Color(0x0A000000), // Very soft 4% black
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> softShadowDark = [
    BoxShadow(
      color: Color(0x80000000), // Deep 50% black
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];
}
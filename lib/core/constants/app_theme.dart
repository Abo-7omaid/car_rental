import 'package:flutter/material.dart';

import 'app_colors.dart';


// abstract final class AppTheme {
//   static ThemeData light() => _build(Brightness.light);
//   static ThemeData dark() => _build(Brightness.dark);
//
//   static ThemeData _build(Brightness brightness) {
//     final isDark = brightness == Brightness.dark;
//     final scheme = ColorScheme.fromSeed(
//       seedColor: AppColors.accent,
//       brightness: brightness,
//       primary: isDark ? AppColors.accent : AppColors.navy,
//       secondary: AppColors.accent,
//       error: AppColors.danger,
//       surface: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
//     );
//
//     final textTheme = const TextTheme(
//       displaySmall: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
//       headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
//       headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
//       titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//       titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//       titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//       bodyLarge: TextStyle(fontSize: 16, height: 1.4),
//       bodyMedium: TextStyle(fontSize: 14, height: 1.35),
//       bodySmall: TextStyle(fontSize: 12, height: 1.3),
//       labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//       labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//     ).apply(
//       bodyColor: isDark ? AppColors.textLight : AppColors.textDark,
//       displayColor: isDark ? AppColors.textLight : AppColors.textDark,
//     );
//
//     final inputDecorationTheme = InputDecorationTheme(
//       filled: true,
//       fillColor: isDark ? AppColors.surfaceDarkHi : AppColors.scaffoldLight,
//       hintStyle: TextStyle(
//         color: isDark ? AppColors.textGreyDark : AppColors.textGrey,
//         fontSize: 14,
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(
//           color: isDark ? AppColors.borderDark : AppColors.borderLight,
//         ),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(
//           color: isDark ? AppColors.borderDark : AppColors.borderLight,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: AppColors.accent, width: 1.6),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: AppColors.danger),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: AppColors.danger, width: 1.6),
//       ),
//     );
//
//     final cardTheme = CardThemeData(
//       color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
//       elevation: 0,
//       margin: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//         side: BorderSide(
//           color: isDark ? AppColors.borderDark : AppColors.borderLight,
//         ),
//       ),
//     );
//
//     return ThemeData(
//       useMaterial3: true,
//       brightness: brightness,
//       colorScheme: scheme,
//       scaffoldBackgroundColor:
//       isDark ? AppColors.scaffoldDark : AppColors.scaffoldLight,
//       textTheme: textTheme,
//       appBarTheme: AppBarThemeData(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         centerTitle: false,
//         titleTextStyle: textTheme.titleLarge?.copyWith(
//           color: isDark ? AppColors.textLight : AppColors.textDark,
//         ),
//         iconTheme: IconThemeData(
//           color: isDark ? AppColors.textLight : AppColors.textDark,
//         ),
//       ),
//       inputDecorationTheme: inputDecorationTheme,
//       cardTheme: cardTheme,
//
//       filledButtonTheme: FilledButtonThemeData(
//         style: FilledButton.styleFrom(
//           backgroundColor: AppColors.primary_dark,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//         ),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.accent,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           elevation: 4,
//           shadowColor: AppColors.accent.withValues(alpha: 0.35),
//           textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//         ),
//       ),
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: isDark ? AppColors.textLight : AppColors.navy,
//           side: BorderSide(
//             color: isDark ? AppColors.borderDark : AppColors.borderLight,
//             width: 1.4,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//         ),
//       ),
//       chipTheme: ChipThemeData(
//         backgroundColor: isDark ? AppColors.surfaceDarkHi : Colors.white,
//         selectedColor: AppColors.accent,
//         labelStyle: TextStyle(
//           color: isDark ? AppColors.textLight : AppColors.textDark,
//           fontWeight: FontWeight.w600,
//         ),
//         side: BorderSide(
//           color: isDark ? AppColors.borderDark : AppColors.borderLight,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
//       ),
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
//         selectedItemColor: AppColors.accent,
//         unselectedItemColor:
//         isDark ? AppColors.textGreyDark : AppColors.textGrey,
//         type: BottomNavigationBarType.fixed,
//         elevation: 8,
//       ),
//       dividerTheme: DividerThemeData(
//         color: isDark ? AppColors.borderDark : AppColors.borderLight,
//         thickness: 1,
//         space: 1,
//       ),
//       switchTheme: SwitchThemeData(
//         thumbColor: WidgetStateProperty.resolveWith(
//               (states) => states.contains(WidgetState.selected)
//               ? Colors.white
//               : (isDark ? AppColors.textGreyDark : AppColors.textGrey),
//         ),
//         trackColor: WidgetStateProperty.resolveWith(
//               (states) => states.contains(WidgetState.selected)
//               ? AppColors.accent
//               : (isDark ? AppColors.borderDark : AppColors.borderLight),
//         ),
//       ),
//       progressIndicatorTheme: const ProgressIndicatorThemeData(
//         color: AppColors.accent,
//       ),
//       dialogTheme: DialogThemeData(
//         backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24),
//         ),
//         titleTextStyle: textTheme.titleLarge?.copyWith(
//           color: isDark ? AppColors.textLight : AppColors.textDark,
//         ),
//         contentTextStyle: textTheme.bodyMedium?.copyWith(
//           color: isDark ? AppColors.textGreyDark : AppColors.textGrey,
//         ),
//       ),
//       snackBarTheme: SnackBarThemeData(
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: isDark ? AppColors.surfaceDarkHi : AppColors.navy,
//         contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       ),
//       splashFactory: InkSparkle.splashFactory,
//     );
//   }
// }


abstract final class AppTheme {
  // ── LIGHT THEME ────────────────────────────────────────────────────────
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentLight,            // Gold
        onPrimary: AppColors.primary,         // Carbon Black
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimaryLight,
        error: AppColors.error,
        outline: AppColors.borderLight,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimaryLight),
        bodyMedium: TextStyle(color: AppColors.textSecondaryLight),
      ),
      // 👇 FIX THIS SECTION 👇
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentLight,  // 🔥 Changed to Gold
          foregroundColor: AppColors.primary, // 🔥 Changed to Carbon Text
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.borderDark), // <-- Dark border
      ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accentLight, width: 2), // 🔥 Turns Gold!
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
    )
    );
  }

  // ── DARK THEME ─────────────────────────────────────────────────────────
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.surfaceDarkHi,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentDark,            // Gold
        onPrimary: AppColors.primary,         // Carbon Black
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        error: AppColors.error,
        outline: AppColors.borderDark,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimaryDark),
        bodyMedium: TextStyle(color: AppColors.textSecondaryDark),
      ),
      // 👇 FIX THIS SECTION 👇
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentDark,  // 🔥 Changed to Gold
          foregroundColor: AppColors.primary, // 🔥 Changed to Carbon Text
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // FOR DARK MODE
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark), // <-- Uses the dark border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accentDark, width: 2), // Turns Gold!
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),
    );
  }
}
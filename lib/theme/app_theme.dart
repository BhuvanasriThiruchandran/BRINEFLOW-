import 'package:flutter/material.dart';

class AppTheme {
  // ============================================================
  // BRAND COLORS
  // ============================================================

  static const Color primaryBlue = Color(0xFF0288D1);
  static const Color navy = Color(0xFF0A192F);
  static const Color ocean = Color(0xFF0077B6);
  static const Color cyan = Color(0xFF00B4D8);
  static const Color oceanCyan = Color(0xFF0096C7);

  // ============================================================
  // BACKGROUND COLORS
  // ============================================================

  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color cardWhite = Colors.white;

  // ============================================================
  // TEXT COLORS
  // ============================================================

  static const Color textDark = Color(0xFF1E293B);
  static const Color textMuted = Color(0xFF64748B);

  // Aliases used by widgets
  static const Color ink = Color(0xFF1E293B);
  static const Color muted = Color(0xFF64748B);
  static const Color inkSecondary = Color(0xFF475569);

  // ============================================================
  // STATUS COLORS
  // ============================================================

  static const Color success = Color(0xFF10B981);
  static const Color statusGreen = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);

  static const Color statusAmber = Color(0xFFF59E0B);
  static const Color amberWarning = Color(0xFFF59E0B);

  static const Color info = Color(0xFF3B82F6);
  static const Color danger = Color(0xFFEF4444);
  static const Color infoLight = Color(0xFFDBEAFE);

  static const Color blue = Color(0xFF3B82F6);

  // Profit / positive metric
  static const Color emeraldGreen = Color(0xFF059669);

  // ============================================================
  // BORDER
  // ============================================================

  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color border = Color(0xFFE2E8F0);

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor: bgLight,

      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        surface: cardWhite,
      ),

      cardTheme: const CardThemeData(
        color: cardWhite,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: bgLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: textDark,
        ),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // DARK THEME
  // ============================================================

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor: navy,

      colorScheme: const ColorScheme.dark(
        primary: cyan,
        surface: Color(0xFF112240),
      ),

      cardTheme: const CardThemeData(
        color: Color(0xFF112240),
        elevation: 0,
        margin: EdgeInsets.zero,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: navy,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF22C55E);
  static const Color _backgroundColor = Color(0xFFF8FBF9);

  static ThemeData get theme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      surface: Colors.white,
      onSurfaceVariant: const Color(0xFF697586),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _backgroundColor,
      textTheme: _buildTextTheme(),
      appBarTheme: _buildAppBarTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme),
      iconTheme: IconThemeData(color: colorScheme.primary),
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(colorScheme),
    );
  }

  static TextTheme _buildTextTheme() {
    const base = Typography.blackMountainView;
    return base.copyWith(
      headlineSmall: base.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.bodyLarge?.copyWith(height: 1.5),
      bodyMedium: base.bodyMedium?.copyWith(height: 1.5),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static AppBarTheme _buildAppBarTheme() {
    return const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      surfaceTintColor: Colors.transparent,
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(
    ColorScheme colorScheme,
  ) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        ),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.primary.withValues(alpha: 0.5);
          }
          return colorScheme.primary;
        }),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
    );
  }

  static BottomNavigationBarThemeData _buildBottomNavigationBarTheme(
    ColorScheme colorScheme,
  ) {
    return BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    );
  }
}

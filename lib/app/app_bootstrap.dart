import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/home/presentation/home_screen.dart';

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodChain',
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}

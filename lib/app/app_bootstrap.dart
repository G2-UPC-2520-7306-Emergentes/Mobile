import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../core/providers/app_state_provider.dart';
import '../features/home/presentation/home_screen.dart';

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodChain',
        theme: AppTheme.theme,
        home: const HomeScreen(),
      ),
    );
  }
}

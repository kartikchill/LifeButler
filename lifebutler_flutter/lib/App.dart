import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/dashboard_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'services/preferences_service.dart';

class LifeButlerApp extends StatelessWidget {
  const LifeButlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeButler',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: PreferencesService().hasSeenOnboarding 
          ? const DashboardScreen() 
          : const OnboardingScreen(),
    );
  }
}

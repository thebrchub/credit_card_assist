import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_screen.dart';
import 'main_dashboard.dart';

class LoginOrDashboardDecider extends StatefulWidget {
  const LoginOrDashboardDecider({super.key});

  @override
  State<LoginOrDashboardDecider> createState() => _LoginOrDashboardDeciderState();
}

class _LoginOrDashboardDeciderState extends State<LoginOrDashboardDecider> {
  bool _isLoading = true;
  bool _showOnboarding = true;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getBool('onboarding_complete') ?? false;
    setState(() {
      _showOnboarding = !completed;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0E0F1B),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return _showOnboarding
        ? const OnboardingScreen()
        : const MainDashboardScreen();
  }
}

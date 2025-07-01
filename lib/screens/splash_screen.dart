import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    // Give splash time to show (2s delay)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (!onboardingComplete) {
      Navigator.pushReplacementNamed(context, '/onboarding');
    } else if (!isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/welcome');
    } else {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0E0F1B),
      body: Center(
        child: Text(
          'Payzo',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:payzo/models/user_profile.dart';

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

    // ⏳ Wait for 2 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    // 🔒 Check if user profile exists in Hive
    final userBox = Hive.box<AppUser>('userBox');
    final user = userBox.get('profile');

    if (!mounted) return;

    if (!onboardingComplete) {
      Navigator.pushReplacementNamed(context, '/onboarding');
    } else if (!isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/welcome');
    } else if (user == null) {
      // user is logged in, but has not completed profile
      Navigator.pushReplacementNamed(context, '/user_details', arguments: ""); // Will be replaced with real email if logged in
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/card_model.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/main_dashboard.dart';
import 'screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDir.path);
  Hive.registerAdapter(CreditCardAdapter());
  await Hive.openBox<CreditCard>('userCards');

  // ✅ Onboarding check
  final prefs = await SharedPreferences.getInstance();
  final isOnboardingComplete = prefs.getBool('onboarding_complete') ?? false;

  runApp(PayzoApp(showOnboarding: !isOnboardingComplete));
}

class PayzoApp extends StatelessWidget {
  final bool showOnboarding;

  const PayzoApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payzo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0E0F1B),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF181826),
          hintStyle: const TextStyle(color: Color(0xFF9F9F9F)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: showOnboarding ? const OnboardingScreen() : const MainDashboardScreen(),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/dashboard': (context) => const MainDashboardScreen(),
      },
    );
  }
}

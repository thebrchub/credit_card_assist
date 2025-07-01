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
// Removed: import 'screens/login_or_dashboard_decider.dart'; ❌ Not needed anymore

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDir.path);
  Hive.registerAdapter(CreditCardAdapter());
  await Hive.openBox<CreditCard>('userCards');

  runApp(const PayzoApp());
}

class PayzoApp extends StatelessWidget {
  const PayzoApp({super.key});

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

      // ✅ Initial screen: Splash which handles all the routing logic
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/dashboard': (context) => const MainDashboardScreen(),
      },
    );
  }
}

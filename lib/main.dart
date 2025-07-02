import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/card_model.dart';
import 'models/user_profile.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/main_dashboard.dart';
import 'screens/onboarding_screen.dart';
import 'screens/user_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Firebase Init
  await Firebase.initializeApp();

  // ✅ Hive Init
  final appDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDir.path);

  Hive.registerAdapter(CreditCardAdapter());
  Hive.registerAdapter(AppUserAdapter());

  await Hive.openBox<CreditCard>('userCards');
  await Hive.openBox<AppUser>('userBox'); // ✅ Unified name

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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/dashboard': (context) => const MainDashboardScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/user_details') {
          final email = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => UserProfileScreen(email: email),
          );
        }
        return null;
      },
    );
  }
}

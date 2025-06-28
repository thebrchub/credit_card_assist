import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _continueAsGuest(BuildContext context) {
    // Store local preference if needed
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  void _signInWithGoogle(BuildContext context) {
    // We'll integrate Google Sign-In logic later
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to Payzo",
                style: GoogleFonts.inter(
                    fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 16),
            Text(
              "Your Smart Personal Finance Assistant",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white60, fontSize: 14),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => _signInWithGoogle(context),
              icon: const Icon(Icons.login, color: Colors.white),
              label: const Text("Sign in with Google"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size.fromHeight(50),
                textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _continueAsGuest(context),
              child: Text("Skip for now",
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70)),
            ),
            const SizedBox(height: 12),
            const Text(
              "⚠ Data won’t be backed up if skipped",
              style: TextStyle(fontSize: 12, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}

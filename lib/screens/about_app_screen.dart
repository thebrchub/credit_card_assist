import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "About App",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Credit Card Assist", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            Text("Version 1.0.0", style: GoogleFonts.inter(color: Colors.white70)),
            const SizedBox(height: 20),
            Text(
              "Credit Card Assist helps you make smart financial decisions by recommending the best credit card for your purchases based on offers, benefits, and price comparison. It also includes an expense tracker and a card management system.",
              style: GoogleFonts.inter(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Text("© 2025 Blazing Render Creation Hub LLP", style: GoogleFonts.inter(color: Colors.grey, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

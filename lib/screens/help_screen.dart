import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Help",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHelpItem("How does card recommendation work?", "We analyze your saved cards, offers, and platform discounts to suggest the best card."),
          _buildHelpItem("How to track expenses?", "Go to Expense Tracker from the drawer menu. You can add and visualize your monthly expenses."),
          _buildHelpItem("How to compare product prices?", "Use the Compare Prices section to paste product links and view best prices across platforms."),
          _buildHelpItem("How to add a new card?", "Navigate to My Cards > Tap on '+' > Fill in bank, card name, and expiry."),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String title, String description) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(title, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
          child: Text(description, style: GoogleFonts.inter(color: Colors.white70)),
        ),
      ],
    );
  }
}

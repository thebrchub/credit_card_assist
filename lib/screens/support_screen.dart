import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Support",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Need help or have a query?",
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 16),

            // 🔹 Email Support
            ListTile(
              leading: const Icon(Icons.email, color: Colors.white),
              title: Text("Email Us", style: GoogleFonts.inter(color: Colors.white)),
              subtitle: Text("support@creditcardassist.com",
                  style: GoogleFonts.inter(color: Colors.white70)),
            ),
            const SizedBox(height: 12),

            // 🔹 Phone Support
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.white),
              title: Text("Call Us", style: GoogleFonts.inter(color: Colors.white)),
              subtitle: Text("+91 98765 43210", style: GoogleFonts.inter(color: Colors.white70)),
            ),
            const SizedBox(height: 12),

            // 🔹 WhatsApp Support (Fallback to chat icon)
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.green),
              title: Text("Chat on WhatsApp", style: GoogleFonts.inter(color: Colors.white)),
              subtitle: Text("+91 98765 43210", style: GoogleFonts.inter(color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}

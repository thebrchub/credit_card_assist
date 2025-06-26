import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Your Privacy Matters"),
              _buildText(
                  "We respect your privacy and are committed to protecting your personal data. "
                  "This privacy policy outlines how we collect, use, and safeguard your information."),
              const SizedBox(height: 20),
              _buildSectionTitle("Data We Collect"),
              _buildText(
                  "- Personal Information (Name, Email, Phone)\n"
                  "- Card details (stored securely and never shared)\n"
                  "- Usage Data for improving features"),
              const SizedBox(height: 20),
              _buildSectionTitle("How We Use It"),
              _buildText(
                  "- To personalize your app experience\n"
                  "- To suggest the best card offers\n"
                  "- To provide customer support\n"
                  "- To analyze and improve our services"),
              const SizedBox(height: 20),
              _buildSectionTitle("Your Control"),
              _buildText(
                  "You can update or delete your data anytime. For any data-related queries, contact us at support@creditcardassist.com."),
              const SizedBox(height: 20),
              _buildSectionTitle("Security Measures"),
              _buildText(
                  "We follow strict encryption and secure storage practices to keep your data safe."),
              const SizedBox(height: 20),
              _buildSectionTitle("Policy Updates"),
              _buildText(
                  "Our privacy policy may change. Please review this page regularly for updates."),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Last updated: June 26, 2025",
                  style: GoogleFonts.inter(color: Colors.white38, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: GoogleFonts.inter(color: Colors.white70, fontSize: 14, height: 1.5),
      ),
    );
  }
}

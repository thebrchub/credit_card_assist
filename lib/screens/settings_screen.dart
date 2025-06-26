import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool biometricLock = false;
  String selectedCurrency = '₹';
  String selectedLanguage = 'English';

  final List<String> currencies = ['₹', '\$', '€'];
  final List<String> languages = ['English', 'Hindi', 'Kannada', 'Telugu'];

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
          "Settings",
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
          children: [
            _buildSwitchTile(
              title: "Dark Mode",
              value: darkMode,
              onChanged: (val) => setState(() => darkMode = val),
            ),
            _buildSwitchTile(
              title: "Enable Biometric Lock",
              value: biometricLock,
              onChanged: (val) => setState(() => biometricLock = val),
            ),
            _buildDropdownTile(
              title: "Preferred Currency",
              value: selectedCurrency,
              items: currencies,
              onChanged: (val) => setState(() => selectedCurrency = val ?? selectedCurrency),
            ),
            _buildDropdownTile(
              title: "Language",
              value: selectedLanguage,
              items: languages,
              onChanged: (val) => setState(() => selectedLanguage = val ?? selectedLanguage),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF181826),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blueAccent,
            inactiveTrackColor: Colors.white24,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged, // ✅ Updated type here
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF181826),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: title,
          labelStyle: GoogleFonts.inter(color: Colors.white60),
          border: InputBorder.none,
        ),
        dropdownColor: const Color(0xFF2A2A3C),
        style: const TextStyle(color: Colors.white),
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item, style: const TextStyle(color: Colors.white)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

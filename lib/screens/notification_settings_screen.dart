import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool transactionAlerts = true;
  bool billReminders = true;
  bool bestDeals = true;
  bool monthlySummary = false;
  bool promotionalUpdates = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Notification Settings",
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
          children: [
            _buildToggleTile(
              title: "Transaction Alerts",
              value: transactionAlerts,
              onChanged: (val) => setState(() => transactionAlerts = val),
            ),
            _buildToggleTile(
              title: "Bill Reminders",
              value: billReminders,
              onChanged: (val) => setState(() => billReminders = val),
            ),
            _buildToggleTile(
              title: "Best Deal Notifications",
              value: bestDeals,
              onChanged: (val) => setState(() => bestDeals = val),
            ),
            _buildToggleTile(
              title: "Monthly Summary",
              value: monthlySummary,
              onChanged: (val) => setState(() => monthlySummary = val),
            ),
            _buildToggleTile(
              title: "Promotional Updates",
              value: promotionalUpdates,
              onChanged: (val) => setState(() => promotionalUpdates = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleTile({
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
}

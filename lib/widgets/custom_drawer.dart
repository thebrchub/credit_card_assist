import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  final Function(String) onItemSelected;

  const CustomDrawer({Key? key, required this.onItemSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0E0F1B),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/user.png'),
                        radius: 28,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'John Wick',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Edit Profile',
                              style: GoogleFonts.inter(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset('assets/logo.png', width: 30),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white24),
            drawerItem(Icons.bar_chart, 'Expense Tracker'),
            drawerItem(Icons.compare_arrows, 'Compare Product Prices'),
            const Divider(color: Colors.white24),
            drawerItem(Icons.credit_card, 'My Cards'),
            drawerItem(Icons.notifications_none, 'Notification Settings'),
            drawerItem(Icons.settings, 'Settings'),
            drawerItem(Icons.support_agent, 'Support'),
            drawerItem(Icons.help_outline, 'Help'),
            drawerItem(Icons.info_outline, 'About App'),
            drawerItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Logout',
                style: GoogleFonts.inter(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onTap: () => onItemSelected('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
      ),
      onTap: () => onItemSelected(label),
    );
  }
}

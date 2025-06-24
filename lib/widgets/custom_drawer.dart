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
            const SizedBox(height: 20),
            ListTile(
              leading: const CircleAvatar(backgroundImage: AssetImage('assets/user.png')),
              title: Text('John Wick',
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              subtitle: TextButton(
                onPressed: () {},
                child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset('assets/logo_icon.png', height: 30),
              ),
            ),
            const Divider(color: Colors.white24),
            drawerItem('Expense Tracker'),
            drawerItem('Compare Product Prices'),
            const Divider(color: Colors.white24),
            drawerItem('My Cards'),
            drawerItem('Notification Settings'),
            drawerItem('Settings'),
            drawerItem('Support'),
            drawerItem('Help'),
            drawerItem('About App'),
            drawerItem('Privacy Policy'),
            const Spacer(),
            ListTile(
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () => onItemSelected('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(String label) {
    return ListTile(
      title: Text(
        label,
        style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
      ),
      onTap: () => onItemSelected(label),
    );
  }
}

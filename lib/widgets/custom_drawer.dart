import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_profile.dart';

class CustomDrawer extends StatelessWidget {
  final Function(String) onItemSelected;

  const CustomDrawer({super.key, required this.onItemSelected});

  final List<_DrawerItem> topItems = const [
    _DrawerItem(icon: Icons.bar_chart, label: 'Expense Tracker'),
    _DrawerItem(icon: Icons.compare_arrows, label: 'Compare Product Prices'),
  ];

  final List<_DrawerItem> bottomItems = const [
    _DrawerItem(icon: Icons.credit_card, label: 'My Cards'),
    _DrawerItem(icon: Icons.notifications_none, label: 'Notification Settings'),
    _DrawerItem(icon: Icons.settings, label: 'Settings'),
    _DrawerItem(icon: Icons.support_agent, label: 'Support'),
    _DrawerItem(icon: Icons.help_outline, label: 'Help'),
    _DrawerItem(icon: Icons.info_outline, label: 'About App'),
    _DrawerItem(icon: Icons.privacy_tip_outlined, label: 'Privacy Policy'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0E0F1B),
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<AppUser>('userBox').listenable(),
          builder: (context, Box<AppUser> box, _) {
            final user = box.get('profile');

            final isGuest = user == null || user.email.isEmpty;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildUserProfileSection(user),
                const SizedBox(height: 20),
                const Divider(color: Colors.white24),
                ...topItems.map((item) => _buildDrawerItem(item.icon, item.label)),
                const Divider(color: Colors.white24),
                ...bottomItems.map((item) => _buildDrawerItem(item.icon, item.label)),
                const Spacer(),
                if (!isGuest) _buildLogoutButton(), // only show if logged in
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserProfileSection(AppUser? user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: user?.imagePath != null &&
                        File(user!.imagePath!).existsSync()
                    ? FileImage(File(user.imagePath!))
                    : const AssetImage('assets/user.png') as ImageProvider,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? 'Guest User',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => onItemSelected('Edit Profile'),
                    child: Container(
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
                  ),
                ],
              ),
            ],
          ),
          Image.asset('assets/logo.png', width: 30),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
      ),
      onTap: () => onItemSelected(label),
    );
  }

  Widget _buildLogoutButton() {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: Text(
        'Logout',
        style: GoogleFonts.inter(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      onTap: () => onItemSelected('Logout'),
    );
  }
}

class _DrawerItem {
  final IconData icon;
  final String label;

  const _DrawerItem({required this.icon, required this.label});
}

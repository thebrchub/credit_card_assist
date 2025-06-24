import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:credit_card_assist/widgets/custom_drawer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      drawer: Drawer(
  backgroundColor: const Color(0xFF0E0F1B),
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: const BoxDecoration(color: Color(0xFF0E0F1B)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/user.png'), // ✅ Your avatar asset
                  radius: 28,
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'John Wick',
                      style: TextStyle(
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
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Image.asset('assets/logo.png', width: 30), // ✅ Your app logo asset
          ],
        ),
      ),
      _drawerItem('Expense Tracker'),
      _drawerItem('Compare Product Prices'),
      const Divider(color: Colors.white10),
      _drawerItem('My Cards'),
      _drawerItem('Notification Settings'),
      _drawerItem('Settings'),
      _drawerItem('Support'),
      _drawerItem('Help'),
      _drawerItem('About App'),
      _drawerItem('Privacy Policy'),
      const Divider(color: Colors.white10),
      ListTile(
        title: const Text(
          'Logout',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          // Add logout logic if needed
          Navigator.pop(context);
        },
      ),
    ],
  ),
),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Smart Card Recommendation',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Paste the product link here', style: TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 12),
            TextField(
              controller: _linkController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF181826),
                hintText: 'https://example/com/product...........',
                hintStyle: const TextStyle(color: Color(0xFF9F9F9F)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4247B2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                String enteredLink = _linkController.text;
                if (enteredLink.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link sent for analysis!')),
                  );
                }
              },
              child: const Text('Analyze and Recommend Card'),
            ),
            const SizedBox(height: 30),
            const Text('Best Card to Use', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF211D49), Color(0xFF0E0E1D)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('ICICI PLATINUM CREDIT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 4),
                  Text('****** 12/28', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  Text('ICICI PLATINUM CREDIT 3771', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('5% Cashback on Electronics', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const Text('Valid until Jun 30, 2024', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            const Text('Expense Tracker', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF181826),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('Graph Placeholder', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        // Implement navigation logic here
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title tapped')));
      },
    );
  }
}

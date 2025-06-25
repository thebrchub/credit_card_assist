import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:credit_card_assist/widgets/custom_drawer.dart';
import 'package:credit_card_assist/screens/expense_tracker_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),

      drawer: CustomDrawer(
  onItemSelected: (label) {
    Navigator.pop(context); // Close drawer first
    if (label == 'Expense Tracker') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExpenseTrackerScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$label tapped')),
      );
    }
  },
),


      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Smart Card Recommendation',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 18,
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

      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Paste the product link here'),
                    const SizedBox(height: 10),
                    _buildLinkInput(),

                    const SizedBox(height: 20),
                    _buildAnalyzeButton(),

                    const SizedBox(height: 30),
                    _buildSectionTitle('Best Card to Use'),
                    const SizedBox(height: 12),
                    _buildCardInfoBox(),

                    const SizedBox(height: 16),
                    _buildOfferInfo(),

                    const SizedBox(height: 30),
                    _buildSectionTitle('Expense Tracker'),
                    const SizedBox(height: 12),
                    _buildExpenseTrackerPlaceholder(size),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildLinkInput() {
    return TextField(
      controller: _linkController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF181826),
        hintText: 'https://example.com/product/...',
        hintStyle: const TextStyle(color: Color(0xFF9F9F9F)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildAnalyzeButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4247B2),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () {
          final enteredLink = _linkController.text;
          if (enteredLink.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Link sent for analysis!')),
            );
          }
        },
        child: const Text('Analyze and Recommend Card'),
      ),
    );
  }

  Widget _buildCardInfoBox() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF211D49), Color(0xFF0E0E1D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
    );
  }

  Widget _buildOfferInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('5% Cashback on Electronics', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(height: 2),
        Text('Valid until Jun 30, 2024', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildExpenseTrackerPlaceholder(Size size) {
    return Container(
      height: size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF181826),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text('Graph Placeholder', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

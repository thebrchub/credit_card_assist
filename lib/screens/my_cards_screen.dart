import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/card_model.dart';
import '../widgets/card_tile.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  final List<CreditCard> _cards = [];

  final List<String> _banks = ['ICICI', 'HDFC', 'SBI', 'Axis', 'Kotak', 'Others'];

  final Map<String, List<String>> _cardOptions = {
    'ICICI': ['Coral', 'Rubyx', 'Platinum'],
    'HDFC': ['Millennia', 'Regalia', 'Infinia'],
    'SBI': ['SimplySAVE', 'Elite', 'Prime'],
    'Axis': ['ACE', 'Flipkart', 'Magnus'],
    'Kotak': ['811', 'Essentia', 'League'],
    'Others': ['Other Card'],
  };

  String? _selectedBank;
  String? _selectedCardName;
  DateTime? _selectedExpiryDate;

  void _addCard() {
    if (_selectedBank == null || _selectedCardName == null || _selectedExpiryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all details")),
      );
      return;
    }

    final newCard = CreditCard(
      bankName: _selectedBank!,
      cardName: _selectedCardName!,
      expiryDate: _selectedExpiryDate!,
    );

    setState(() {
      _cards.add(newCard);
      _selectedBank = null;
      _selectedCardName = null;
      _selectedExpiryDate = null;
    });

    Navigator.pop(context);
  }

  void _showAddCardDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add New Card",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                const SizedBox(height: 16),

                /// 🔹 Bank Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedBank,
                  dropdownColor: const Color(0xFF2A2A3C),
                  decoration: _dropdownDecoration("Select Bank"),
                  style: const TextStyle(color: Colors.white),
                  items: _banks.map<DropdownMenuItem<String>>((bank) {
                    return DropdownMenuItem<String>(
                      value: bank,
                      child: Text(bank, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBank = value;
                      _selectedCardName = null;
                    });
                  },
                ),

                const SizedBox(height: 12),

                /// 🔹 Card Dropdown (FIXED casting issue)
                DropdownButtonFormField<String>(
                  value: _selectedCardName,
                  dropdownColor: const Color(0xFF2A2A3C),
                  decoration: _dropdownDecoration("Select Card"),
                  style: const TextStyle(color: Colors.white),
                  items: (_selectedBank != null ? _cardOptions[_selectedBank!]! : [])
                      .map<DropdownMenuItem<String>>((card) {
                        return DropdownMenuItem<String>(
                          value: card,
                          child: Text(card, style: const TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCardName = value;
                    });
                  },
                ),

                const SizedBox(height: 12),

                /// 🔹 Expiry (MM/YY only)
                GestureDetector(
                  onTap: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: now,
                      lastDate: DateTime(2035),
                      builder: (context, child) {
                        return Theme(data: ThemeData.dark(), child: child!);
                      },
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedExpiryDate = picked;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A3C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white54, size: 18),
                        const SizedBox(width: 10),
                        Text(
                          _selectedExpiryDate != null
                              ? "Expiry: ${DateFormat('MM/yy').format(_selectedExpiryDate!)}"
                              : "Select Expiry Date",
                          style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _addCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("Save Card",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  InputDecoration _dropdownDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: const Color(0xFF2A2A3C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  void _deleteCard(int index) {
    setState(() {
      _cards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        centerTitle: true,
        elevation: 0,
        title: Text("My Cards",
            style: GoogleFonts.inter(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCardDialog,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _cards.isEmpty
            ? Center(
                child: Text(
                  "No cards added yet.\nTap + to add your card.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: Colors.white60, fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  return CardTile(
                    card: _cards[index],
                    onDelete: () => _deleteCard(index),
                  );
                },
              ),
      ),
    );
  }
}

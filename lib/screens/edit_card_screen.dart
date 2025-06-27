import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import '../models/card_model.dart';

class EditCardScreen extends StatefulWidget {
  final CreditCard card;
  final int cardIndex;

  const EditCardScreen({
    super.key,
    required this.card,
    required this.cardIndex,
  });

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final List<String> _banks = ['ICICI', 'HDFC', 'SBI', 'Axis', 'Kotak', 'Others'];

  final Map<String, List<String>> _cardOptions = {
    'ICICI': ['Coral', 'Rubyx', 'Platinum'],
    'HDFC': ['Millennia', 'Regalia', 'Infinia'],
    'SBI': ['SimplySAVE', 'Elite', 'Prime'],
    'Axis': ['ACE', 'Flipkart', 'Magnus'],
    'Kotak': ['811', 'Essentia', 'League'],
    'Others': ['Other Card'],
  };

  final List<String> _availableTags = [
    'Fuel', 'Groceries', 'Dining', 'Travel', 'Shopping', 'Movies', 'Bills', 'Others'
  ];

  String? _selectedBank;
  String? _selectedCardName;
  int? _selectedMonth;
  int? _selectedYear;
  DateTime? _selectedExpiryDate;
  List<String> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    _selectedBank = widget.card.bankName;
    _selectedCardName = widget.card.cardName;
    _selectedExpiryDate = widget.card.expiryDate;
    _selectedMonth = _selectedExpiryDate?.month;
    _selectedYear = _selectedExpiryDate?.year;
    _selectedTags = List.from(widget.card.tags);
  }

  void _updateExpiryDate() {
    if (_selectedMonth != null && _selectedYear != null) {
      _selectedExpiryDate = DateTime(_selectedYear!, _selectedMonth!);
    }
  }

  Future<void> _saveChanges() async {
    if (_selectedBank == null || _selectedCardName == null || _selectedExpiryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    final updatedCard = CreditCard(
      bankName: _selectedBank!,
      cardName: _selectedCardName!,
      expiryDate: _selectedExpiryDate!,
      tags: List.from(_selectedTags),
    );

    final box = Hive.box<CreditCard>('userCards');
    await box.putAt(widget.cardIndex, updatedCard);

    if (mounted) Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        title: Text("Edit Card", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedBank,
              dropdownColor: const Color(0xFF2A2A3C),
              decoration: _dropdownDecoration("Select Bank"),
              style: const TextStyle(color: Colors.white),
              items: _banks.map((bank) {
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
            DropdownButtonFormField<String>(
              value: _selectedCardName,
              dropdownColor: const Color(0xFF2A2A3C),
              decoration: _dropdownDecoration("Select Card"),
              style: const TextStyle(color: Colors.white),
              items: (_selectedBank != null ? _cardOptions[_selectedBank!]! : [])
                  .map((card) {
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

            // ✅ Month-Year Dropdowns
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedMonth,
                    decoration: _dropdownDecoration("Month"),
                    dropdownColor: const Color(0xFF2A2A3C),
                    style: const TextStyle(color: Colors.white),
                    items: List.generate(12, (index) {
                      final month = index + 1;
                      return DropdownMenuItem(
                        value: month,
                        child: Text(month.toString().padLeft(2, '0'),
                            style: const TextStyle(color: Colors.white)),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        _selectedMonth = value;
                        _updateExpiryDate();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedYear,
                    decoration: _dropdownDecoration("Year"),
                    dropdownColor: const Color(0xFF2A2A3C),
                    style: const TextStyle(color: Colors.white),
                    items: List.generate(15, (index) {
                      final year = DateTime.now().year + index;
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year.toString(),
                            style: const TextStyle(color: Colors.white)),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value;
                        _updateExpiryDate();
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Tags",
                  style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _availableTags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  selectedColor: Colors.blueAccent,
                  backgroundColor: const Color(0xFF2A2A3C),
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white70),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Save Changes",
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}

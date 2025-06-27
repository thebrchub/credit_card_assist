import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import '../models/card_model.dart';
import '../widgets/card_tile.dart';
import 'edit_card_screen.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
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
  final List<String> _selectedTags = [];

  Box<CreditCard> get _cardBox => Hive.box<CreditCard>('userCards');

  void _updateExpiryDate() {
    if (_selectedMonth != null && _selectedYear != null) {
      _selectedExpiryDate = DateTime(_selectedYear!, _selectedMonth!);
    }
  }

  void _addCard() async {
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
      tags: List<String>.from(_selectedTags),
    );

    await _cardBox.add(newCard);

    setState(() {
      _selectedBank = null;
      _selectedCardName = null;
      _selectedMonth = null;
      _selectedYear = null;
      _selectedExpiryDate = null;
      _selectedTags.clear();
    });

    if (mounted) Navigator.pop(context);
  }

  void _deleteCard(int index) async {
    await _cardBox.deleteAt(index);
    setState(() {});
  }

  void _editCard(int index) {
    final card = _cardBox.getAt(index);
    if (card != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditCardScreen(card: card, cardIndex: index),
        ),
      ).then((_) => setState(() {}));
    }
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
            child: StatefulBuilder(
              builder: (context, setModalState) {
                return SingleChildScrollView(
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
                          setModalState(() {
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
                          setModalState(() {
                            _selectedCardName = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
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
                                  child: Text(month.toString().padLeft(2, '0'), style: const TextStyle(color: Colors.white)),
                                );
                              }),
                              onChanged: (value) {
                                setModalState(() {
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
                                  child: Text(year.toString(), style: const TextStyle(color: Colors.white)),
                                );
                              }),
                              onChanged: (value) {
                                setModalState(() {
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
                        child: Text(
                          "Select Tags",
                          style:
                              GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w500),
                        ),
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
                            labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.white70),
                            onSelected: (selected) {
                              setModalState(() {
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _addCard,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text("Save Card",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                );
              },
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

  @override
  Widget build(BuildContext context) {
    final cards = _cardBox.values.toList();

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
        child: cards.isEmpty
            ? Center(
                child: Text(
                  "No cards added yet.\nTap + to add your card.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: Colors.white60, fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return CardTile(
                    card: cards[index],
                    onDelete: () => _deleteCard(index),
                    onEdit: () => _editCard(index),
                  );
                },
              ),
      ),
    );
  }
}

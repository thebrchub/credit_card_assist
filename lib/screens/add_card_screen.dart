import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../helpers/hive_helpers.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String bankName = '';
  String cardName = '';
  DateTime? expiryDate;

  void saveCard() async {
    if (_formKey.currentState!.validate() && expiryDate != null) {
      final newCard = CreditCard(
        bankName: bankName,
        cardName: cardName,
        expiryDate: expiryDate!,
      );

      await addCreditCard(newCard); // ✅ Add card

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Card saved successfully')),
      );

      Navigator.pop(context); // Go back to card list
    }
  }

  Future<void> pickExpiryDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
    if (selectedDate != null) {
      setState(() {
        expiryDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Credit Card')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bank Name'),
                onChanged: (val) => bankName = val,
                validator: (val) => val!.isEmpty ? 'Enter bank name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Card Name'),
                onChanged: (val) => cardName = val,
                validator: (val) => val!.isEmpty ? 'Enter card name' : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: pickExpiryDate,
                child: Text(
                  expiryDate == null
                      ? 'Pick Expiry Date'
                      : 'Expiry: ${expiryDate!.month}/${expiryDate!.year}',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveCard,
                child: const Text('Save Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

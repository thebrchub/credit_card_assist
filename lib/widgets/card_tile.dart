import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/card_model.dart';

class CardTile extends StatelessWidget {
  final CreditCard card;
  final VoidCallback onDelete;

  const CardTile({super.key, required this.card, required this.onDelete});

  List<Color> _getGradientColors(String bankName) {
    switch (bankName.toLowerCase()) {
      case 'hdfc':
        return [const Color(0xFF1E3C72), const Color(0xFF2A5298)];
      case 'sbi':
        return [const Color(0xFF003366), const Color(0xFF006699)];
      case 'icici':
        return [const Color.fromARGB(115, 202, 87, 64), const Color(0xFFDD2476)];
      case 'axis':
        return [const Color(0xFF41295A), const Color(0xFF2F0743)];
      case 'kotak':
        return [const Color(0xFF93291E), const Color(0xFFED213A)];
      default:
        return [const Color(0xFF5D5FEF), const Color(0xFF2D2E8E)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final expiry = DateFormat('MM/yy').format(card.expiryDate);
    final colors = _getGradientColors(card.bankName);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colors.last.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon or placeholder for logo
          const Icon(Icons.credit_card, color: Colors.white, size: 32),
          const SizedBox(width: 14),
          // Card info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.cardName,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bank: ${card.bankName}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  'Expiry: $expiry',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_forever_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

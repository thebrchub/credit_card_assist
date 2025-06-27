import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/card_model.dart';

class CardTile extends StatelessWidget {
  final CreditCard card;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const CardTile({
    super.key,
    required this.card,
    required this.onDelete,
    this.onEdit,
  });

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

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'fuel':
        return Colors.orange;
      case 'groceries':
        return Colors.green;
      case 'dining':
        return Colors.redAccent;
      case 'travel':
        return Colors.teal;
      case 'shopping':
        return Colors.deepPurple;
      case 'movies':
        return Colors.pinkAccent;
      case 'bills':
        return Colors.blueGrey;
      default:
        return Colors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final expiry = DateFormat('MM/yy').format(card.expiryDate);
    final isExpired = card.expiryDate.isBefore(DateTime(now.year, now.month + 1));
    final isExpiringSoon = !isExpired && card.expiryDate.difference(now).inDays <= 30;

    final colors = _getGradientColors(card.bankName);

    String statusText = '';
    Color statusColor = Colors.transparent;

    if (isExpired) {
      statusText = "Expired";
      statusColor = Colors.redAccent;
    } else if (isExpiringSoon) {
      statusText = "Expiring Soon";
      statusColor = Colors.orangeAccent;
    }

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
            color: Color.alphaBlend(statusColor.withAlpha(70), colors.last),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.credit_card, color: Colors.white, size: 32),
          const SizedBox(width: 14),
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
                Row(
                  children: [
                    Text(
                      'Expiry: $expiry',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (statusText.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(30),
                          border: Border.all(color: statusColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          statusText,
                          style: GoogleFonts.inter(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                if (card.tags.isNotEmpty)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: card.tags.map((tag) {
                      return Chip(
                        label: Text(
                          tag,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                        backgroundColor: _getTagColor(tag),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_forever_rounded, color: Colors.white),
              ),
              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, color: Colors.white70),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

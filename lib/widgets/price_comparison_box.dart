import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PriceComparisonBox extends StatelessWidget {
  final Product product;

  const PriceComparisonBox({super.key, required this.product});

  void _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch the link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Find best final price (after discount)
    final bestEntry = product.platformPrices.entries.reduce((a, b) {
      final priceA = a.value - (product.cardOffers[a.key]?['discount'] ?? 0.0);
      final priceB = b.value - (product.cardOffers[b.key]?['discount'] ?? 0.0);
      return priceA < priceB ? a : b;
    });
    final bestPlatform = bestEntry.key;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181826),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image and Title
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.imageUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  product.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Platform Prices with Card Offers
          ...product.platformPrices.entries.map((entry) {
            final platform = entry.key;
            final price = entry.value;
            final isBest = platform == bestPlatform;

            final card = product.cardOffers[platform]?['card'] ?? 'N/A';
            final offerText = product.cardOffers[platform]?['offer'] ?? 'No Offer';
            final discount = product.cardOffers[platform]?['discount'] ?? 0.0;
            final finalPrice = price - discount;
            final productUrl = product.links[platform] ?? '';

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isBest ? const Color(0xFF1E2C1D) : const Color(0xFF202030),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isBest ? Colors.greenAccent.withOpacity(0.5) : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Platform Row + Best Deal badge
                  Row(
                    children: [
                      Icon(Icons.storefront, color: Colors.white70, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        platform,
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isBest)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.greenAccent, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                "Best Deal",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => _launchURL(context, productUrl),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white12,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Buy Now", style: TextStyle(color: Colors.blueAccent)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Prices
                  Row(
                    children: [
                      Text(
                        '₹${price.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 14,
                          decoration: discount > 0 ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      if (discount > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '₹${finalPrice.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Card Offer Line
                  Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.amberAccent.shade200, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '$card - $offerText',
                          style: GoogleFonts.inter(
                            color: Colors.white60,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

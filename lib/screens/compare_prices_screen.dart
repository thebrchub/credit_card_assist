import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product_model.dart';

class CompareProductPricesScreen extends StatefulWidget {
  const CompareProductPricesScreen({super.key});

  @override
  State<CompareProductPricesScreen> createState() =>
      _CompareProductPricesScreenState();
}

class _CompareProductPricesScreenState
    extends State<CompareProductPricesScreen> {
  final TextEditingController _inputController = TextEditingController();
  Product? searchedProduct;
  bool isLoading = false;

  // 🔸 Mock data with offers
  Future<Product> fetchMockProduct(String input) async {
    await Future.delayed(const Duration(seconds: 1));
    return Product(
      name: "Apple AirPods Pro (2nd Gen)",
      imageUrl:
          "https://m.media-amazon.com/images/I/61f1YfTkTDL._SL1500_.jpg",
      prices: {
        "Amazon": 22990,
        "Flipkart": 22499,
        "Myntra": 23999,
        "Ajio": 21990,
        "Croma": 22690,
      },
      links: {
        "Amazon": "https://www.amazon.in/dp/B0BDJ6N9G8",
        "Flipkart":
            "https://www.flipkart.com/apple-airpods-pro-2nd-gen/p/itmabc",
        "Myntra": "https://www.myntra.com/apple-airpods",
        "Ajio": "https://www.ajio.com/apple-airpods",
        "Croma": "https://www.croma.com/apple-airpods",
      },
      cardOffers: {
        "Amazon": {"bank": "ICICI Credit Card", "discount": 10},
        "Flipkart": {"bank": "HDFC Credit Card", "discount": 5},
        "Myntra": {"bank": "SBI Credit Card", "discount": 7},
        "Ajio": {"bank": "Axis Credit Card", "discount": 10},
        "Croma": {"bank": "Kotak Credit Card", "discount": 8},
      },
    );
  }

  void handleSearch() async {
    final input = _inputController.text.trim();
    if (input.isEmpty) return;

    setState(() {
      isLoading = true;
      searchedProduct = null;
    });

    final result = await fetchMockProduct(input);
    setState(() {
      searchedProduct = result;
      isLoading = false;
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch the link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bestPlatform = searchedProduct?.prices.entries.reduce((a, b) {
      double aDiscount =
          searchedProduct!.cardOffers[a.key]?['discount']?.toDouble() ?? 0;
      double bDiscount =
          searchedProduct!.cardOffers[b.key]?['discount']?.toDouble() ?? 0;
      double aFinal = a.value * (1 - aDiscount / 100);
      double bFinal = b.value * (1 - bDiscount / 100);
      return aFinal < bFinal ? a : b;
    }).key;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F1B),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Compare Prices',
          style: GoogleFonts.inter(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter product name or paste link...',
                hintStyle: const TextStyle(color: Color(0xFF9F9F9F)),
                fillColor: const Color(0xFF181826),
                filled: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: handleSearch,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const Center(child: CircularProgressIndicator(color: Colors.white)),
            if (!isLoading && searchedProduct == null)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  "Your smart deal finder starts here!\nSearch or paste a product link to begin.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            if (searchedProduct != null)
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildProductCard(searchedProduct!, bestPlatform!),
                    const SizedBox(height: 20),
                    _buildSummary(bestPlatform, searchedProduct!),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product, String bestPlatform) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181826),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.blueAccent.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(product.imageUrl,
                    width: 70, height: 70, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(product.name,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...product.prices.entries.map((entry) {
            final isBest = entry.key == bestPlatform;
            final originalPrice = entry.value;
            final discount =
                (product.cardOffers[entry.key]?['discount'] ?? 0).toDouble();
            final bank = product.cardOffers[entry.key]?['bank'] ?? "N/A";
            final finalPrice = originalPrice * (1 - discount / 100);

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isBest
                    ? const Color(0xFF1E2C1D)
                    : const Color(0xFF202030),
                borderRadius: BorderRadius.circular(10),
                border: isBest
                    ? Border.all(color: Colors.greenAccent, width: 1)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(entry.key,
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 14)),
                      if (isBest)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 14, color: Colors.greenAccent),
                              const SizedBox(width: 4),
                              Text("Best Deal",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.greenAccent)),
                            ],
                          ),
                        ),
                      const Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white10,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          final url = product.links[entry.key];
                          if (url != null) _launchURL(url);
                        },
                        child: const Text("Buy Now",
                            style: TextStyle(color: Colors.blueAccent)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text("₹${originalPrice.toStringAsFixed(0)}",
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 13,
                        decoration: discount > 0
                            ? TextDecoration.lineThrough
                            : null,
                      )),
                  if (discount > 0)
                    Text("₹${finalPrice.toStringAsFixed(0)}",
                        style: GoogleFonts.inter(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  Text("$discount% off with $bank",
                      style: GoogleFonts.inter(
                          color: Colors.blueAccent, fontSize: 13)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSummary(String bestPlatform, Product product) {
    final offer = product.cardOffers[bestPlatform];
    final discount = (offer?['discount'] ?? 0).toDouble();
    final basePrice = product.prices[bestPlatform]!;
    final finalPrice = basePrice * (1 - discount / 100);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.credit_card, color: Colors.greenAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Best deal on $bestPlatform — Use ${offer?['bank']} to save ₹${(basePrice - finalPrice).round()}!",
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

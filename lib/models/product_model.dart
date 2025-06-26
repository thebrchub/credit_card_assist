class Product {
  final String name;
  final String imageUrl;
  final Map<String, double> prices;
  final Map<String, String> links;
  
  // 📌 New: Map for card offers per platform
  // Example: { "Amazon": { "bank": "ICICI", "discount": 10 } }
  final Map<String, Map<String, dynamic>> cardOffers;

  Product({
    required this.name,
    required this.imageUrl,
    required this.prices,
    required this.links,
    required this.cardOffers, // ✅ Add this
  });

  Map<String, double> get platformPrices => prices;

  String get title => name;
}

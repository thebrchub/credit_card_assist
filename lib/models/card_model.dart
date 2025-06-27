import 'package:hive/hive.dart';

part 'card_model.g.dart';

@HiveType(typeId: 0)
class CreditCard extends HiveObject {
  @HiveField(0)
  final String bankName;

  @HiveField(1)
  final String cardName;

  @HiveField(2)
  final DateTime expiryDate;

  @HiveField(3)
  final List<String> tags; // ✅ New field for card tags

  CreditCard({
    required this.bankName,
    required this.cardName,
    required this.expiryDate,
    this.tags = const [],
  });
}

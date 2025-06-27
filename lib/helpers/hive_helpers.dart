import 'package:hive/hive.dart';
import '../models/card_model.dart';

Future<void> addCreditCard(CreditCard card) async {
  final cardBox = Hive.box<CreditCard>('userCards');
  await cardBox.add(card); // ✅ Adds without replacing old ones
}

List<CreditCard> getAllSavedCards() {
  final cardBox = Hive.box<CreditCard>('userCards');
  return cardBox.values.toList();
}

Future<void> deleteCardAt(int index) async {
  final cardBox = Hive.box<CreditCard>('userCards');
  await cardBox.deleteAt(index);
}

Future<void> updateCardAt(int index, CreditCard updatedCard) async {
  final cardBox = Hive.box<CreditCard>('userCards');
  await cardBox.putAt(index, updatedCard);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditCardAdapter extends TypeAdapter<CreditCard> {
  @override
  final int typeId = 0;

  @override
  CreditCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditCard(
      bankName: fields[0] as String,
      cardName: fields[1] as String,
      expiryDate: fields[2] as DateTime,
      tags: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, CreditCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.bankName)
      ..writeByte(1)
      ..write(obj.cardName)
      ..writeByte(2)
      ..write(obj.expiryDate)
      ..writeByte(3)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

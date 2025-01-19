// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LedgerModelAdapter extends TypeAdapter<LedgerModel> {
  @override
  final int typeId = 17;

  @override
  LedgerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LedgerModel(
      transactionId: fields[0] as String,
      transactionDate: fields[1] as DateTime,
      amount: fields[2] as double,
      entryType: fields[6] as String,
      description: fields[3] as String,
      category: fields[4] as String,
      subcategory: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LedgerModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.transactionId)
      ..writeByte(1)
      ..write(obj.transactionDate)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.subcategory)
      ..writeByte(6)
      ..write(obj.entryType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LedgerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

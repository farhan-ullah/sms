// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revenue_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevenueModelAdapter extends TypeAdapter<RevenueModel> {
  @override
  final int typeId = 11;

  @override
  RevenueModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RevenueModel(
      serialNumber: fields[5] as String,
      transactionId: fields[4] as String,
      revenueDescription: fields[6] as String,
      revenueCategory: fields[0] as String?,
      revenueSubcategory: fields[1] as String?,
      amount: fields[2] as double,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RevenueModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.revenueCategory)
      ..writeByte(1)
      ..write(obj.revenueSubcategory)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.transactionId)
      ..writeByte(5)
      ..write(obj.serialNumber)
      ..writeByte(6)
      ..write(obj.revenueDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevenueModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

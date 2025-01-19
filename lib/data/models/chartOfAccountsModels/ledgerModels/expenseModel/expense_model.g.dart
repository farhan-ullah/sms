// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 10;

  @override
  ExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModel(
      transactionId: fields[4] as String,
      serialNumber: fields[5] as String,
      expenseDescription: fields[6] as String,
      expenseMainCategory: fields[0] as String?,
      expenseSubcategory: fields[1] as String?,
      expenseAmount: fields[2] as double?,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.expenseMainCategory)
      ..writeByte(1)
      ..write(obj.expenseSubcategory)
      ..writeByte(2)
      ..write(obj.expenseAmount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.transactionId)
      ..writeByte(5)
      ..write(obj.serialNumber)
      ..writeByte(6)
      ..write(obj.expenseDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

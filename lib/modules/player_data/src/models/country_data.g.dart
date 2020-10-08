// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryDataAdapter extends TypeAdapter<CountryData> {
  @override
  final int typeId = 1;

  @override
  CountryData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryData(
      id: fields[0] as String,
    )
      ..attempts = fields[1] as int
      ..timesCorrect = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, CountryData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.attempts)
      ..writeByte(2)
      ..write(obj.timesCorrect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

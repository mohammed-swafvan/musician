// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsDataBaseAdapter extends TypeAdapter<SongsDataBase> {
  @override
  final int typeId = 1;

  @override
  SongsDataBase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsDataBase(
      name: fields[0] as String,
      songId: (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, SongsDataBase obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.songId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsDataBaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

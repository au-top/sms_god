// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppConfigAdapter extends TypeAdapter<AppConfig> {
  @override
  final int typeId = 1;

  @override
  AppConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppConfig(
      weChatSdkConfig: fields[1] as WeChatSdkConfig,
      freeMessageConfig: fields[2] as FreeMessageConfig,
    );
  }

  @override
  void write(BinaryWriter writer, AppConfig obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.weChatSdkConfig)
      ..writeByte(2)
      ..write(obj.freeMessageConfig);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeChatSdkConfigAdapter extends TypeAdapter<WeChatSdkConfig> {
  @override
  final int typeId = 2;

  @override
  WeChatSdkConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeChatSdkConfig(
      url: fields[1] == null ? '' : fields[1] as String,
      corpid: fields[2] == null ? '' : fields[2] as String,
      corpsecret: fields[3] == null ? '' : fields[3] as String,
      agentid: fields[4] == null ? '' : fields[4] as String,
      enable: fields[5] == null ? false : fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, WeChatSdkConfig obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.corpid)
      ..writeByte(3)
      ..write(obj.corpsecret)
      ..writeByte(4)
      ..write(obj.agentid)
      ..writeByte(5)
      ..write(obj.enable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeChatSdkConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FreeMessageConfigAdapter extends TypeAdapter<FreeMessageConfig> {
  @override
  final int typeId = 3;

  @override
  FreeMessageConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FreeMessageConfig(
      targetUUID: fields[1] == null ? '' : fields[1] as String,
      cpassword: fields[4] == null ? [] : (fields[4] as List).cast<String>(),
      email: fields[2] == null ? '' : fields[2] as String,
      passwd: fields[3] == null ? '' : fields[3] as String,
      enable: fields[5] == null ? false : fields[5] as bool,
      baseUrl: fields[6] == null ? '' : fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FreeMessageConfig obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.targetUUID)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.passwd)
      ..writeByte(4)
      ..write(obj.cpassword)
      ..writeByte(5)
      ..write(obj.enable)
      ..writeByte(6)
      ..write(obj.baseUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FreeMessageConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

part of '../settings_entity.dart';

class SettingsFilePath extends SettingsEntity {
  static SettingsFilePath? fromEntity(SettingsEntity? item) {
    return item != null && item.type == SettingsTypeEnum.filePath.index
        ? SettingsFilePath(
            id: item.id,
            name: item.name,
            defaultValue: item.defaultValue,
            userValue: item.userValue,
            confirmType: item.confirmType,
            type: item.type,
            values: item.values,
            isDeleted: item.isDeleted,
          )
        : null;
  }

  SettingsFilePath({
    required super.id,
    required super.name,
    required super.defaultValue,
    required super.userValue,
    required super.confirmType,
    required super.type,
    required super.values,
    required super.isDeleted,
  });
  FileType get getFileType => values != null ? FileType.values.byName(values![0]) : FileType.any;
  List<String>? get getFileAllowedExtensions => (values?[0] == "custom") ? values!.sublist(1) : null;
}

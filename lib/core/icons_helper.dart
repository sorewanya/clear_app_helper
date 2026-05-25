import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/icon_picker_icon.dart';
import 'package:flutter_iconpicker/Serialization/icondata_serialization.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get_it/get_it.dart';

class IconsHelper {
  /// Delimiter between pack name and icon name in serialized form.
  static const kIconPackDelimiter = ':';

  /// Deserializes a string back to [IconPickerIcon].
  ///
  /// Returns null if the format is invalid.
  static IconPickerIcon? deserialize(String value) {
    final delimiterIndex = value.indexOf(kIconPackDelimiter);
    if (delimiterIndex <= 0 || delimiterIndex >= value.length - 1) return null;

    final pack = value.substring(0, delimiterIndex);
    final name = value.substring(delimiterIndex + 1);

    return deserializeIcon({'key': name, 'pack': pack});
  }

  static Widget getIcon(String nameOfSettings) => Icon(getIconData(nameOfSettings));
  static Widget getIconByEnum(EnumsOfSettings settings) => Icon(getIconData(settings.name));

  /// Try to get IconData from [nameOfSettings]
  /// default: MdiIcons.crosshairsQuestion
  static IconData getIconData(String nameOfSettings) {
    final name =
        GetIt.instance<SettingsBloc>().getUserOrDefaultValueByNamed(nameOfSettings) ?? 'allMaterial:question_mark';
    final tryInt = int.tryParse(name);
    if (tryInt != null) {
      return IconData(tryInt, fontFamily: 'Material Design Icons', fontPackage: 'flutter_material_design_icons');
    }
    return deserialize(name)?.data ?? Icons.question_answer;
  }

  static IconData getIconDataByEnum(EnumsOfSettings settings) => getIconData(settings.name);

  static IconData getIconDataByString(String name) => getIconDataOrNullByString(name) ?? MdiIcons.crosshairsQuestion;

  /// take IconData from added to settings in [IconSettingsEnum] or from [MdiIcons.fromString]
  static IconData? getIconDataOrNullByString(String name) {
    final tryInt = int.tryParse(name);
    if (tryInt != null) {
      return IconData(tryInt, fontFamily: 'Material Design Icons', fontPackage: 'flutter_material_design_icons');
    }
    IconData? data;
    final mapOfSettings = {
      '<': IconSettingsEnum.less,
      '<=': IconSettingsEnum.lessOrEqual,
      '>': IconSettingsEnum.greater,
      '>=': IconSettingsEnum.greaterOrEqual,
      '=': IconSettingsEnum.equal,
      'true': IconSettingsEnum.trueIcon,
      'false': IconSettingsEnum.falseIcon,
      'dark': IconSettingsEnum.themeDark,
      'light': IconSettingsEnum.themeLight,
      'systemLight': IconSettingsEnum.themeSystem,
      'setTimeData': IconSettingsEnum.setTimeData,
      'full': IconSettingsEnum.textFull,
      'midl': IconSettingsEnum.textMidl,
      'short': IconSettingsEnum.textShort,
      'slider': IconSettingsEnum.slider,
      'textField': IconSettingsEnum.textField,
    };
    data = mapOfSettings.containsKey(name) ? getIconDataByEnum(mapOfSettings[name]!) : deserialize(name)?.data;
    return data;
  }

  /// Serializes an [IconPickerIcon] to a string: `"pack:name"`.
  static String serialize(IconPickerIcon icon) {
    return '${icon.pack}$kIconPackDelimiter${icon.name}';
  }
}

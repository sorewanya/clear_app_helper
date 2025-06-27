import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';

///Material Design Icons IconData class
class MdiIconData extends IconData {
  const MdiIconData(super.codePoint)
    : super(fontFamily: 'Material Design Icons', fontPackage: 'material_design_icons_flutter');
}

class IconsHelper {
  static IconData getIconDataByString(String name) => getIconDataOrNullByString(name) ?? MdiIcons.crosshairsQuestion;

  /// Try to get IconData from [nameOfSettings]
  /// default: MdiIcons.crosshairsQuestion
  static IconData getIconData(String nameOfSettings) {
    return MdiIconData(
      Get.context != null
          ? int.parse(Get.context!.read<SettingsBloc>().getUserOrDefaultValueByNamed(nameOfSettings) ?? "0xf1136")
          : 0xf1136,
    );
  }

  static IconData getIconDataByEnum(EnumsOfSettings settings) => getIconData(settings.name);

  static Widget getIcon(String nameOfSettings) => Icon(getIconData(nameOfSettings));
  static Widget getIconByEnum(EnumsOfSettings settings) => Icon(getIconData(settings.name));

  /// take IconData from added to settings in [IconSettingsEnum] or from [MdiIcons.fromString]
  static IconData? getIconDataOrNullByString(String name) {
    IconData? data;
    final mapOfSettings = {
      "<": IconSettingsEnum.less,
      "<=": IconSettingsEnum.lessOrEqual,
      ">": IconSettingsEnum.greater,
      ">=": IconSettingsEnum.greaterOrEqual,
      "=": IconSettingsEnum.equal,
      "true": IconSettingsEnum.trueIcon,
      "false": IconSettingsEnum.falseIcon,
      "dark": IconSettingsEnum.themeDark,
      "light": IconSettingsEnum.themeLight,
      "systemLight": IconSettingsEnum.themeSystem,
      "setTimeData": IconSettingsEnum.setTimeData,
      "full": IconSettingsEnum.textFull,
      "midl": IconSettingsEnum.textMidl,
      "short": IconSettingsEnum.textShort,
      "slider": IconSettingsEnum.slider,
      "textField": IconSettingsEnum.textField,
    };
    data = mapOfSettings.containsKey(name) ? getIconDataByEnum(mapOfSettings[name]!) : MdiIcons.fromString(name);
    return data;
  }
}

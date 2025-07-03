import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';

class SettingsHelper {
  static final SettingsBloc bloc = GetIt.instance<SettingsBloc>();

  static SettingsEntity? get getDatetimePersonalFormat =>
      bloc.getByEnum(CoreSettingsEnum.datetimeDefaultPersonalFormat);
  static String get getDatetimeDefaultFormat =>
      (getDatetimePersonalFormat != null && getDatetimePersonalFormat!.userValue != null)
      ? getDatetimePersonalFormat!.userValue!
      : bloc.getUserOrDefaultValueByNamed(CoreSettingsEnum.datetimeDefaultFormat.name) ?? "E-d/M yy, HH:mm";
  static String get getDatetimeLanguage =>
      bloc.getUserOrDefaultValueByNamed(CoreSettingsEnum.datetimeLanguage.name) ??
      GetIt.instance<CoreI18n>().dateTimeLocale;
  static DateFormat get getDefaultDateFormat => DateFormat(getDatetimeDefaultFormat, getDatetimeLanguage);
}

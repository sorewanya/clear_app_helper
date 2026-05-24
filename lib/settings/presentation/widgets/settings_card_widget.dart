import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/theme_data.dart';
import 'package:clear_app_helper/core/presentation/widgets/loading_indicator.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_types.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:clear_app_helper/settings/presentation/widgets/confirm_type_warning.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingsCardWidget extends StatelessWidget {
  const SettingsCardWidget({required this.id, super.key});
  final int id;
  @override
  Widget build(BuildContext context) {
    final settingsBloc = GetIt.I<SettingsBloc>();
    return StreamBuilder<SettingsEntity?>(
      initialData: settingsBloc.getByIdSync(id),
      stream: settingsBloc.getStreamById(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData && snapshot.data == null) {
          return loadingIndicator(GetIt.instance<CoreI18n>().settingIsNotSaved);
        }
        final SettingsEntity item = snapshot.data!;

        Widget valueView(String value, String string, Widget iconWidget) {
          final valueAsInt = int.tryParse(value);
          return (item.type != SettingsTypeEnum.listOfValues.index &&
                  item.type != SettingsTypeEnum.listOfValuesExtend.index)
              ? Wrap(
                  children: [
                    iconWidget,
                    Text(string),
                    //icon?
                    if (item.type == SettingsTypeEnum.icon.index && valueAsInt != null)
                      Icon(IconsHelper.mdi(valueAsInt), size: 40)
                    else
                      (item.type == SettingsTypeEnum.value.index && valueAsInt != null)
                          ? Text(item.values?[valueAsInt] ?? '')
                          : Text(value),
                  ],
                )
              : Text("$string ${value.split(",").map(int.tryParse).whereType<int>().toList()}");
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColorLight.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(10),
              color: getColorByBoolIsDeleted(item.isDeleted, context),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    IconsHelper.getIconDataByString(
                      (item.defaultValue == item.userValue || item.userValue == null).toString(),
                    ),
                  ),
                  onPressed: () => settingsBloc.add(SettingsBlocEvent.resetToDefault(item)),
                  tooltip: GetIt.instance<CoreI18n>().restore,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: settingsBloc.getDescriptionById(item.id),
                        builder: (context, snapshot) {
                          return snapshot.data != null
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(snapshot.data!.description),
                                )
                              : const SizedBox();
                        },
                      ),

                      ///Name
                      Text(item.name),

                      ///default value
                      if (item.defaultValue != '')
                        valueView(
                          item.defaultValue,
                          '${GetIt.instance<CoreI18n>().setDefaultInSettings}: ',
                          IconsHelper.getIconByEnum(IconSettingsEnum.defaultValue),
                        ),

                      ///User value
                      ConfirmTypeWarning(confirmType: item.confirmType),
                      if (item.userValue != null)
                        valueView(
                          item.userValue!,
                          '${GetIt.instance<CoreI18n>().settingUserValue}: ',
                          IconsHelper.getIconByEnum(IconSettingsEnum.userValue),
                        ),

                      ///values List
                      if (item.values != null && item.type != SettingsTypeEnum.listOfValuesExtend.index)
                        Text('${GetIt.instance<CoreI18n>().settingVariants}: ${(item.values!).asMap()}')
                      else if (item.values != null)
                        Builder(
                          builder: (context) {
                            final i = SettingsListOfValuesExtend.fromEntity(item);
                            final values = i?.getValuesFromBase(settingsBloc.getByNamed);
                            if (values != null) {
                              return Text('${GetIt.instance<CoreI18n>().settingVariants}: ${values.asMap()}');
                            }
                            return const SizedBox();
                          },
                        ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final list = item.name.split('.')..removeLast();
                    settingsBloc.add(SettingsBlocEvent.load(SettingsSearchEntity(name: list.join('.'))));
                  },
                  icon: IconsHelper.getIconByEnum(IconSettingsEnum.searchSearch),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

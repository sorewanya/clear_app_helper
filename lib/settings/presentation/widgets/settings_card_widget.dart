import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/theme_data.dart';
import 'package:clear_app_helper/core/presentation/widgets/checkbox_text_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/loading_indicator.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_types.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:clear_app_helper/settings/presentation/widgets/confirm_type_warning.dart';
import 'package:get_it/get_it.dart';

class SettingsCardWidget extends StatelessWidget {
  final int id;
  const SettingsCardWidget({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();
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
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    iconWidget,
                    Text(string),
                    //icon?
                    (item.type == SettingsTypeEnum.icon.index && valueAsInt != null)
                        ? Icon(MdiIconData(valueAsInt), size: 40)
                        //value of values List?
                        : (item.type == SettingsTypeEnum.value.index && valueAsInt != null)
                        ? Text(item.values?[valueAsInt] ?? "")
                        : Text(value),
                  ],
                )
              : Text("$string ${value.split(",").map((e) => int.tryParse(e)).whereType<int>().toList().toString()}");
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
                CheckboxTextButton(
                  check: item.defaultValue == item.userValue || item.userValue == null,
                  onPressed: () => settingsBloc.add(SettingsBlocEvent.resetToDefault(item)),
                  checkName: GetIt.instance<CoreI18n>().restore,
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
                              ? Row(
                                  children: [
                                    Column(children: [Text(snapshot.data!.description), const SizedBox(height: 10)]),
                                  ],
                                )
                              : const SizedBox();
                        },
                      ),

                      ///Name
                      Text(item.name),

                      ///default value
                      if (item.defaultValue != "")
                        valueView(
                          item.defaultValue,
                          "${GetIt.instance<CoreI18n>().setDefaultInSettings}: ",
                          IconsHelper.getIconByEnum(IconSettingsEnum.defaultValue),
                        ),

                      ///User value
                      ConfirmTypeWarning(confirmType: item.confirmType),
                      if (item.userValue != null)
                        valueView(
                          item.userValue!,
                          "${GetIt.instance<CoreI18n>().settingUserValue}: ",
                          IconsHelper.getIconByEnum(IconSettingsEnum.userValue),
                        ),

                      ///values List
                      if (item.values != null && item.type != SettingsTypeEnum.listOfValuesExtend.index)
                        Text(
                          "${GetIt.instance<CoreI18n>().settingVariants}: ${(item.values as List<String>).asMap().toString()}",
                        )
                      else if (item.values != null)
                        Builder(
                          builder: (context) {
                            final i = SettingsListOfValuesExtend.fromEntity(item);
                            final values = i?.getValuesFromBase(settingsBloc.getByNamed);
                            if (values != null) {
                              return Text(
                                "${GetIt.instance<CoreI18n>().settingVariants}: ${values.asMap().toString()}",
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final list = item.name.split(".");
                    list.removeLast();
                    settingsBloc.add(SettingsBlocEvent.load(SettingsSearchEntity(name: list.join("."))));
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

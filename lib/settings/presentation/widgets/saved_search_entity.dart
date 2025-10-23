import 'dart:convert';

import 'package:animated_tree_view/helpers/collection_utils.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/flash_messanger.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/domain/entities/named_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// ignore: avoid_types_as_parameter_names
class SavedSearchEntity<Type extends SearchEntity> extends StatelessWidget {
  const SavedSearchEntity({
    required this.searchEntity,
    required this.setState,
    required this.setSearchEntity,
    required this.setting,
    required this.fromJson,
    super.key,
  });
  final Type searchEntity;

  /// ```
  /// setState: (f) => setState(() => f()),
  /// ```
  final Function(Function() f) setState;

  /// Функция возвращает установленное значение
  final Function(Type newSearchEntity) setSearchEntity;
  final Type Function(Map<String, dynamic> json) fromJson;
  final EnumsOfSettings setting;

  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();
    final s = settingsBloc.getByEnum(setting);

    if (s == null) return const SizedBox();

    final List<NamedSearchEntity<Type>> list =
        s.values
            ?.map((e) {
              final m = json.decode(e) as Map<String, dynamic>;
              if (m.entries.isNotEmpty) {
                return NamedSearchEntity<Type>(
                  m.entries.first.key,
                  fromJson(m.entries.first.value as Map<String, dynamic>),
                );
              }
              return null;
            })
            .filterNotNull()
            .toList() ??
        [];

    void setSavedList(List<NamedSearchEntity<Type>> list) {
      final List<String> l = [];
      for (final element in list) {
        l.add(json.encode({element.name: element.searchEntity.toJson()}));
      }
      // ignore: avoid_dynamic_calls
      settingsBloc.add(SettingsBlocEvent.update(item: s.copyWith(values: l) as SettingsEntity));
    }

    return SizedBox(
      height: list.isEmpty ? 40 : 200,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            if (list.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text(list[index].name),
                        const SizedBox(width: 5),

                        //search
                        IconButton(
                          onPressed: () => setState(() {
                            setSearchEntity(list[index].searchEntity);
                          }),
                          tooltip: GetIt.instance<CoreI18n>().savedSearchFind,
                          icon: IconsHelper.getIconByEnum(IconSettingsEnum.searchSearch),
                        ),
                        const SizedBox(width: 5),

                        //rename
                        IconButton(
                          onPressed: () => setState(() {
                            final TextEditingController editingController = TextEditingController()
                              ..text = list[index].name;
                            FlashMessangerHelper.showBottomFlashWithTextFormField(
                              editingController: editingController,
                              ifYes: () {
                                setState(() {
                                  final i = list[index];
                                  list[index] = NamedSearchEntity<Type>(editingController.text, i.searchEntity);
                                  setSavedList(list);
                                });
                              },
                              titleText: GetIt.instance<CoreI18n>().savedSearchRename,
                              contentText: GetIt.instance<CoreI18n>().savedSearchHelpText,
                              yesText: GetIt.instance<CoreI18n>().savedSearchFind,
                              noText: GetIt.instance<CoreI18n>().cancel,
                            );
                          }),
                          tooltip: GetIt.instance<CoreI18n>().savedSearchRename,
                          icon: Icon(IconsHelper.getIconDataByString('formTextboxPassword')),
                        ),
                        const SizedBox(width: 5),

                        //update
                        IconButton(
                          onPressed: () => setState(() {
                            FlashMessangerHelper.showBottomFlashSearch(
                              ifYes: () {
                                setState(() {
                                  list[index] = NamedSearchEntity<Type>(list[index].name, searchEntity);
                                  setSavedList(list);
                                });
                              },
                              titleText: GetIt.instance<CoreI18n>().savedSearchUpdate,
                              contentText: '',
                              yesText: GetIt.instance<CoreI18n>().savedSearchUpdate,
                              noText: GetIt.instance<CoreI18n>().cancel,
                            );
                          }),
                          tooltip: GetIt.instance<CoreI18n>().savedSearchUpdateByCurrent,
                          icon: Icon(IconsHelper.getIconDataByString('clockEditOutline')),
                        ),

                        //delete
                        IconButton(
                          onPressed: () => setState(() {
                            list.removeAt(index);
                            setSavedList(list);
                          }),
                          tooltip: GetIt.instance<CoreI18n>().savedSearchRemove,
                          icon: IconsHelper.getIconByEnum(IconSettingsEnum.delete),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.grey[400]);
                  },
                  itemCount: list.length,
                  padding: const EdgeInsets.only(bottom: 60, left: 4, right: 4, top: 4),
                ),
              ),
            //save
            TextButton(
              onPressed: () {
                final editingController = TextEditingController();
                FlashMessangerHelper.showBottomFlashWithTextFormField(
                  editingController: editingController,
                  ifYes: () {
                    list.add(NamedSearchEntity(editingController.text, searchEntity));
                    setState(() {
                      setSavedList(list);
                    });
                  },
                  titleText: GetIt.instance<CoreI18n>().savedSearchSave,
                  contentText: GetIt.instance<CoreI18n>().savedSearchSaveHelpText,
                  yesText: GetIt.instance<CoreI18n>().savedSearchSave,
                  noText: GetIt.instance<CoreI18n>().cancel,
                );
              },
              child: Text(GetIt.instance<CoreI18n>().savedSearchSaveSearch),
            ),
          ],
        ),
      ),
    );
  }
}

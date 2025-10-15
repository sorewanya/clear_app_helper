import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/functions.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_case_sensitive_warning_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_checkbox_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_find_text_and_icon_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_reset_text_and_icon_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_text_form_field_with_reset_widget.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_required_types.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:clear_app_helper/settings/presentation/widgets/saved_search_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SettingsListSearchWidget extends StatefulWidget {
  final SettingsSearchEntity searchEntity;
  const SettingsListSearchWidget({required this.searchEntity, super.key});

  @override
  State<SettingsListSearchWidget> createState() => _SettingsListSearchWidgetState();
}

class _SettingsListSearchWidgetState extends State<SettingsListSearchWidget> {
  late SettingsSearchEntity _searchEntity;

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  late String dropdownSettingsRequiredTypeValue;

  @override
  void initState() {
    // ignore: avoid_dynamic_calls
    _searchEntity = widget.searchEntity.copyWith() as SettingsSearchEntity;
    idController.text = _searchEntity.id?.toString() ?? '';
    nameController.text = _searchEntity.name ?? '';
    dropdownSettingsRequiredTypeValue = '_';

    super.initState();
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();

    void filterSearchResults() {
      settingsBloc.add(SettingsBlocEvent.load(_searchEntity));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SearchResetTextAndIconButton(
            onTap: () {
              setState(() {
                idController.clear();
                nameController.clear();

                _searchEntity = const SettingsSearchEntity();
                FunctionsHelper.showResetUpdateInfoBarOrFilter(
                  filterSearchResults: () {
                    _searchEntity = const SettingsSearchEntity();
                    filterSearchResults();
                  },
                );
              });
            },
          ),
          const SizedBox(height: 10),
          Builder(
            builder: (context) {
              return SavedSearchEntity<SettingsSearchEntity>(
                setting: SettingsSettingsEnum.savedSearch,
                fromJson: SettingsSearchEntity.fromJson,
                searchEntity: _searchEntity,
                setSearchEntity: (se) {
                  settingsBloc.add(SettingsBlocEvent.load(se));
                },
                setState: (f) => mounted ? setState(() => f()) : null,
              );
            },
          ),

          ///NAME
          SearchTextFormFieldResetResetWidget(
            controller: nameController,
            labelAndHintText: GetIt.instance<CoreI18n>().searchName,
            filtr: filterSearchResults,
            // ignore: avoid_dynamic_calls
            setSearchParam: (s) => _searchEntity = _searchEntity.copyWith(name: s) as SettingsSearchEntity,
            setState: (f) => setState(() => f()),
          ),

          ///isDeleted
          SearchCheckboxWidget(
            filtr: filterSearchResults,
            param: _searchEntity.isDeleted,
            // ignore: avoid_dynamic_calls
            setParam: (b) => _searchEntity = _searchEntity.copyWith(isDeleted: b) as SettingsSearchEntity,
            text: GetIt.instance<CoreI18n>().searchShowDeleted,
            setState: (f) => setState(() => f()),
          ),

          ///SettingsRequiredType
          DropdownButtonFormField<String>(
            value: dropdownSettingsRequiredTypeValue,
            icon: IconsHelper.getIconByEnum(IconSettingsEnum.dropDown),
            elevation: 16,
            items: [
              const DropdownMenuItem<String>(value: '_', child: Text('_')),
              ...SettingsRequiredTypesEnum.values.map(
                (e) => DropdownMenuItem<String>(value: e.index.toString(), child: Text(e.name)),
              ),
            ],
            onChanged: (value) => setState(() {
              dropdownSettingsRequiredTypeValue = value ?? '_';
              _searchEntity =
                  // ignore: avoid_dynamic_calls
                  _searchEntity.copyWith(confirmType: int.tryParse(dropdownSettingsRequiredTypeValue))
                      as SettingsSearchEntity;
            }),
          ),

          ///isChanged
          SearchCheckboxWidget(
            filtr: filterSearchResults,
            param: _searchEntity.isChanged,
            // ignore: avoid_dynamic_calls
            setParam: (b) => _searchEntity = _searchEntity.copyWith(isChanged: b) as SettingsSearchEntity,
            text: GetIt.instance<CoreI18n>().searchShowChanged,
            setState: (f) => setState(() => f()),
          ),
          const SizedBox(height: 10),
          const SearchCaseSensitiveWarningWidget(),
          const SizedBox(height: 10),
          SearchFindTextAndIconButton(
            onTap: () {
              setState(filterSearchResults);
            },
          ),
        ],
      ),
    );
  }
}

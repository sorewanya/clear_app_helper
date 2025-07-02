import 'package:clear_app_helper/core/domain/entities/text_field_variant.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:file_picker/file_picker.dart';

import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/functions.dart';
import 'package:clear_app_helper/core/presentation/widgets/animated_toggle_switch_or_dropdown.dart';
import 'package:clear_app_helper/core/presentation/widgets/floating_save_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/icon_view_and_picker_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/loading_indicator.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_detail_page_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_text_field_widget.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:clear_app_helper/core/settings_route_names.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_types.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:clear_app_helper/settings/presentation/widgets/confirm_type_warning.dart';
import 'package:clear_app_helper/settings/presentation/widgets/list_of_saved_search_entity_widget.dart';
import 'package:clear_app_helper/settings/presentation/widgets/list_of_values_widget.dart';
import 'package:get_it/get_it.dart';

class SettingsDetailPage extends StatefulWidget {
  const SettingsDetailPage({super.key});

  @override
  State<SettingsDetailPage> createState() => _SettingsDetailPageState();
}

class _SettingsDetailPageState extends State<SettingsDetailPage> {
  //<state params>
  late GlobalKey<FormState> _formkey;
  late bool shouldPop;
  late bool firstLoad;

  //<item params>
  SettingsEntity? origItem;
  late int? id;
  late int? confirmType;
  late String name;
  late String defaultValue;
  late String? userValue;
  late int type;
  late List<String>? values;
  late bool isDeleted;

  @override
  void initState() {
    shouldPop = true;
    firstLoad = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();
    //LOCAL SCOPE FUNCTIONS
    void pop() {
      shouldPop = true;
      RouteHelper.back();
    }

    SettingsEntity createItem() {
      return SettingsEntity(
        id: id,
        name: name,
        defaultValue: defaultValue,
        userValue: userValue,
        confirmType: confirmType,
        type: type,
        values: values,
        isDeleted: isDeleted,
      );
    }

    void saveForm({Function()? popParam}) {
      settingsBloc.add(
        SettingsBlocEvent.saveForm(item: createItem(), origItem: origItem, pop: popParam ?? pop, formKey: _formkey),
      );
    }

    checkSettingsType() {
      if (type == SettingsTypeEnum.boolean.index) {
        return AnimatedToggleSwitchOrDropdown(
          values: const ["false", "true"],
          hasIndexValue: false,
          value: userValue ?? defaultValue,
          setState: (f) => setState(() => f()),
          setValue: (value) {
            if (userValue != value) {
              userValue = value;
              shouldPop = false;
            }
          },
        );
      } else if (type == SettingsTypeEnum.integer.index ||
          type == SettingsTypeEnum.listOfInt.index ||
          type == SettingsTypeEnum.listOfString.index ||
          type == SettingsTypeEnum.doublee.index) {
        return MyTextFieldWidget(
          text: "${GetIt.instance<CoreI18n>().userValue}: ",
          formFieldKey: const ValueKey("userValue"),
          getValue: () => userValue ?? defaultValue,
          setValue: (s) => userValue = s,
          setShouldPop: (b) => shouldPop = b,
          canBeEmpty: false,
          variant: type == SettingsTypeEnum.integer.index ? TextFieldVariant.integer() : null,
          validator: type == SettingsTypeEnum.listOfInt.index
              ? ((value) {
                  String? str;
                  value.split(',').forEach((element) {
                    if (int.tryParse(element) == null) {
                      str = GetIt.instance<CoreI18n>().settingsValueNotIntWarning;
                    }
                  });
                  return str;
                })
              : null,
        );
      } else if (type == SettingsTypeEnum.listOfValues.index) {
        return ListOfValuesWidget(
          userValue: userValue ?? defaultValue,
          values: values ?? [],
          updateUserValue: (newUserValue) => setState(() => userValue = newUserValue),
        );
      } else if (type == SettingsTypeEnum.listOfValuesBase.index) {
        return Text("${GetIt.instance<CoreI18n>().settingsNotEditedSetting} ${values.toString()}");
      } else if (type == SettingsTypeEnum.savedSearch.index) {
        return ListOfSavedSearchEntityWidget(
          values: values ?? [],
          updateValues: (newValues) => setState(() => values = newValues),
        );
      } else if (type == SettingsTypeEnum.listOfValuesExtend.index) {
        final i = SettingsListOfValuesExtend.fromEntity(origItem);
        final values = i?.getValuesFromBase(settingsBloc.getByNamed);
        return ListOfValuesWidget(
          userValue: userValue ?? defaultValue,
          values: values ?? [],
          updateUserValue: (newUserValue) => setState(() => userValue = newUserValue),
        );
      } else if (type == SettingsTypeEnum.icon.index) {
        return IconViewAndPickerButton(
          setString: (icon) => setState(() {
            if (userValue != icon) {
              userValue = icon;
              shouldPop = false;
            }
          }),
          initIconCode: int.tryParse(userValue ?? defaultValue),
        );
      } else if (type == SettingsTypeEnum.value.index) {
        return (values != null && values?.isNotEmpty == true)
            ? AnimatedToggleSwitchOrDropdown(
                values: values!,
                value: userValue ?? defaultValue,
                hasIndexValue: true,
                setState: (f) => setState(() => f()),
                setValue: (value) {
                  if (userValue != value) {
                    shouldPop = false;
                    userValue = value!;
                  }
                },
              )
            : Text(GetIt.instance<CoreI18n>().settingsValueTypeError);
      } else if (type == SettingsTypeEnum.filePath.index) {
        return Column(
          children: [
            Text("${GetIt.instance<CoreI18n>().filePath}: ${userValue ?? defaultValue}"),
            Text("${GetIt.instance<CoreI18n>().filePathAllowedExtensions}: ${values?[0]}"),
            TextButton(
              onPressed: () {
                FilePicker.platform
                    .pickFiles(
                      allowMultiple: false,
                      type: SettingsFilePath.fromEntity(origItem)?.getFileType ?? FileType.any,
                      allowedExtensions: SettingsFilePath.fromEntity(origItem)?.getFileAllowedExtensions,
                    )
                    .then((path) {
                      if (path != null) {
                        setState(() => userValue = path.paths.first);
                      }
                    });
              },
              child: Text(GetIt.instance<CoreI18n>().filePathChange),
            ),
          ],
        );
      } else if (type == SettingsTypeEnum.dirPath.index) {
        return Column(
          children: [
            Text("${GetIt.instance<CoreI18n>().filePathCurent}: ${userValue ?? defaultValue}"),
            TextButton(
              onPressed: () {
                FilePicker.platform.getDirectoryPath().then((path) {
                  if (path != null) {
                    setState(() => userValue = path);
                  }
                });
              },
              child: Text(GetIt.instance<CoreI18n>().filePathChange),
            ),
          ],
        );
      } else if (type == SettingsTypeEnum.string.index || type == SettingsTypeEnum.rfwWidget.index) {
        return MyTextFieldWidget(
          text: "${GetIt.instance<CoreI18n>().userValue}: ",
          formFieldKey: const ValueKey("userValue"),
          getValue: () => userValue ?? defaultValue,
          setValue: (s) => userValue = s,
          setShouldPop: (b) => shouldPop = b,
          canBeEmpty: true,
        );
      } else {
        return Text(GetIt.instance<CoreI18n>().settintsTypeNotFound);
      }
    }

    void getById() async {
      if (firstLoad) {
        final se = FunctionsHelper.getArgs<SettingsSearchEntity>();
        origItem = settingsBloc.getByIdSync(se?.id);
        id = origItem?.id!;
        name = origItem?.name ?? "";
        defaultValue = origItem?.defaultValue ?? "";
        userValue = origItem?.getUserOrDefaultValueAsString;
        type = origItem?.type ?? 0;
        confirmType = origItem?.confirmType;
        values = origItem?.values;
        isDeleted = origItem?.isDeleted ?? false;

        firstLoad = false;
      }
    }

    //<form params>
    _formkey = GlobalKey<FormState>();
    ValueKey nameKey = const ValueKey("name");

    //Get arguments
    getById();
    if (firstLoad) return loadingIndicator(GetIt.instance<CoreI18n>().settingEditLoading);
    return MyDetailPageWidget(
      formkey: _formkey,
      isDelete: isDeleted,
      getShouldPop: () => shouldPop,
      entityInfo: "${GetIt.instance<CoreI18n>().setting} $name:",
      saveForm: saveForm,
      pop: pop,
      appBarTitle: Text(
        id == null ? "${GetIt.instance<CoreI18n>().settingAdd}:" : "${GetIt.instance<CoreI18n>().setting} $name:",
      ),
      body: Column(
        children: [
          MyTextFieldWidget(
            text: "${GetIt.instance<CoreI18n>().name}: ",
            formFieldKey: nameKey,
            getValue: () => name,
            setValue: (s) => name = s,
            setShouldPop: (b) => shouldPop = b,
          ),

          Text("${GetIt.instance<CoreI18n>().settingDefaultValue}:$defaultValue"),

          ConfirmTypeWarning(confirmType: confirmType),
          Text("${GetIt.instance<CoreI18n>().settingType}: $type"),
          id != null ? checkSettingsType() : const Text("settings add not implaemented"),
          TextButton(
            onPressed: () {
              final list = name.split(".");
              list.removeLast();
              RouteHelper.toNamed(
                SettingsRouteNames.settingsViewPage,
                arguments: SettingsSearchEntity(name: list.join(".")),
              );
            },
            child: Text(GetIt.instance<CoreI18n>().settingsFindRelatedUp),
          ),
        ],
      ),
      //BUTTONS
      floatingActionButtonList: [
        FloatingSaveButton(saveForm: saveForm),
        const SizedBox(width: 20),
        FloatingActionButton(
          heroTag: const ValueKey('reset'),
          onPressed: () => settingsBloc.add(SettingsBlocEvent.resetToDefault(createItem())),
          child: IconsHelper.getIconByEnum((IconSettingsEnum.settingsResetToDefault)),
        ),
      ],
    );
  }
}

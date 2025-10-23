import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';

/// wrapper around [DropdownButtonFormField]\<String>
class NameDropDownFormFieldStringWidget extends StatelessWidget {
  const NameDropDownFormFieldStringWidget({
    required this.dropdownNameValue,
    required this.setState,
    required this.setDropdownNameValue,
    required this.setDropdownNameValueId,
    required this.currentMap,
    super.key,
    this.setShouldPop,
    this.withoutUnderline = false,
  });

  /// current value
  final String dropdownNameValue;

  /// value variants name:id
  final Map<String, int> currentMap;

  /// callback new value
  final Function(String s) setDropdownNameValue;

  /// callback new value id
  final Function(int id) setDropdownNameValueId;

  final Function(bool b)? setShouldPop;

  /// ```
  /// setState:(f) => setState(() => f()),
  /// ```
  final Function(Function() f) setState;

  /// if true variant "_" not added
  final bool withoutUnderline;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> dropdownList = [];

    currentMap.forEach((key, value) => dropdownList.add(DropdownMenuItem<String>(value: key, child: Text(key))));
    return DropdownButtonFormField<String>(
      initialValue: dropdownNameValue,
      icon: IconsHelper.getIconByEnum(IconSettingsEnum.dropDown),
      elevation: 16,
      items: [
        if (!withoutUnderline) const DropdownMenuItem<String>(value: '_', child: Text('_')),
        ...dropdownList,
      ],
      onChanged: (newValue) {
        setState(() {
          if (newValue == dropdownNameValue) return;
          setShouldPop?.call(false);
          if (newValue != null) {
            setDropdownNameValue(newValue);
            if (newValue != '_') {
              setDropdownNameValueId(currentMap[newValue]!);
            }
          }
        });
      },
    );
  }
}

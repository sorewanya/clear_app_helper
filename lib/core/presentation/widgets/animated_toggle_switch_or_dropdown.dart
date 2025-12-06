import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:country_icons/country_icons.dart';
import 'package:flutter/material.dart';

/// AnimatedToggleSwitch, if all values have icon from
/// (```IconsHelper.getIconDataOrNullByString```)
///
/// else DropdownButtonFormField with this values
class AnimatedToggleSwitchOrDropdown extends StatelessWidget {
  const AnimatedToggleSwitchOrDropdown({
    required this.value,
    required this.values,
    required this.setValue,
    required this.setState,
    required this.hasIndexValue,
    super.key,
  });

  /// current Value
  final String value;

  final List<String>? values;

  /// true if in userValue/defaultValue save index of value
  final bool hasIndexValue;

  /// new value callback
  final Function(String? s) setValue;

  /// ```
  /// setState: (f) => setState(() => f()),
  /// ```
  final Function(Function() f) setState;

  @override
  Widget build(BuildContext context) {
    final asInt = int.tryParse(value);
    if (values == null || (hasIndexValue && asInt == null)) {
      return const SizedBox();
    }

    bool haveAllIcons = true;
    final iconDatas = values!.map(IconsHelper.getIconDataOrNullByString).toList();
    if (iconDatas.contains(null)) haveAllIcons = false;
    final Map<String, Widget> countryIcons = {};
    if (values!.first.contains('_')) {
      for (final e in values!) {
        try {
          final locale = e.split('_').first;
          countryIcons[e] = SizedBox(
            width: Theme.of(context).iconTheme.size,
            height: Theme.of(context).iconTheme.size,
            child: CountryIcons.getSvgFlag(locale == 'en' ? 'gb' : locale),
          );
        } finally {}
      }
      if (values!.length == countryIcons.length) {
        haveAllIcons = true;
      }
    }
    final currentValue = hasIndexValue ? values![asInt!] : value;

    final size = Theme.of(context).iconTheme.size ?? 20;

    return haveAllIcons
        ? AnimatedToggleSwitch<String>.rolling(
            current: currentValue,
            values: values!,
            height: size * 2,
            borderWidth: size * 0.1,
            onChanged: (i) => setState(() => setValue(hasIndexValue ? values!.indexOf(i).toString() : i)),
            iconBuilder: (value, foreground) => countryIcons[value] ?? Icon(IconsHelper.getIconDataByString(value)),
          )
        : DropdownButtonFormField<String>(
            initialValue: currentValue,
            icon: IconsHelper.getIconByEnum(IconSettingsEnum.dropDown),
            elevation: 16,
            items: values!.map((e) {
              return DropdownMenuItem<String>(value: e, child: Text(e));
            }).toList(),
            onChanged: (value) {
              final newValue = hasIndexValue ? values!.indexOf(value!).toString() : value!;
              setState(() => setValue(newValue));
            },
          );
  }
}

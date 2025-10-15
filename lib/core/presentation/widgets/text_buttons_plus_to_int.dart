import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// "+1 +5 +10" buttons
class TextButtonsPlusToInt extends StatelessWidget {
  const TextButtonsPlusToInt({required this.plusIntValue, super.key, this.intSet});

  /// value to plus callback
  final Function(int value) plusIntValue;

  /// default "[1,5,10,30]", getted from settings CoreSettingsEnum.plusIntValues
  final Set<int>? intSet;

  @override
  Widget build(BuildContext context) {
    final curentIntSet =
        intSet ??
        context
            .read<SettingsBloc>()
            .getStringsListUserOrDefaultValueByNamed(CoreSettingsEnum.plusIntValues.name)
            .map(int.tryParse)
            .whereType<int>()
            .toSet();

    return SizedBox(
      child: Wrap(
        children: [
          ...curentIntSet.map(
            (e) => SizedBox(
              child: TextButton(
                onPressed: () {
                  plusIntValue(e);
                },
                child: Text('+$e'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

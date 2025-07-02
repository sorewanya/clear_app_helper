import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// "+1 +5 +10" buttons
class TextButtonsPlusToInt extends StatelessWidget {
  const TextButtonsPlusToInt({super.key, required this.plusIntValue, this.intSet});

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
            .map((e) => int.tryParse(e))
            .whereType<int>()
            .toSet();

    return SizedBox(
      height: 30,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 60,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
        itemCount: curentIntSet.length,
        itemBuilder: (context, index) => TextButton(
          onPressed: (() {
            plusIntValue(curentIntSet.elementAt(index));
          }),
          child: Text("+${curentIntSet.elementAt(index)}"),
        ),
      ),
    );
  }
}

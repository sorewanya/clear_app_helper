import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';

class SetDateTimeIconButtonWidget extends StatelessWidget {
  const SetDateTimeIconButtonWidget({
    required this.dateTimeSet,
    required this.label,
    required this.dateTime,
    super.key,
    this.ifDayOnly,
  });

  /// base dateTime
  final DateTime? dateTime;

  /// new dataTime callback
  final Function(DateTime dateTime) dateTimeSet;

  /// return true if setted only date
  final Function(bool dayOnly)? ifDayOnly;

  /// showDatePicker label
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: dateTime ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2900),
          fieldLabelText: label,
          currentDate: DateTime.now(),
        );

        if (selectedDate != null && context.mounted) {
          final selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(
              hour: dateTime?.hour ?? DateTime.now().hour,
              minute: dateTime?.minute ?? DateTime.now().minute,
            ),
          );
          if (selectedTime != null) {
            dateTimeSet(
              DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute),
            );
            ifDayOnly?.call(false);
          } else {
            dateTimeSet(DateTime(selectedDate.year, selectedDate.month, selectedDate.day));
            ifDayOnly?.call(true);
          }
        }
      },
      child: Icon(IconsHelper.getIconDataByEnum(IconSettingsEnum.setTimeData)),
    );
  }
}

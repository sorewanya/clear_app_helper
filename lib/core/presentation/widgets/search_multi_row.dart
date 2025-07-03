import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';

class SearchElementMultiRow extends StatelessWidget {
  const SearchElementMultiRow({super.key, required this.label, required this.children, required this.onPressedAdd});

  final String label;

  final Function() onPressedAdd;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            SizedBox(width: 250, child: Text("$label: ")),
            TextButton(onPressed: onPressedAdd, child: IconsHelper.getIconByEnum((IconSettingsEnum.add))),
            ...children,
          ],
        ),
      ],
    );
  }
}

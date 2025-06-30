import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_reset_text_and_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// Show SearchResetTextAndIconButton and text about empty search
class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key, required this.onTap});

  /// send to [SearchResetTextAndIconButton]
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(GetIt.instance<CoreI18n>().searchEmptyListMessage),
          SearchResetTextAndIconButton(onTap: onTap),
        ],
      ),
    );
  }
}

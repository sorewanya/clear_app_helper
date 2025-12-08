import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:markdown_widget/markdown_widget.dart';

/// Widget show dialog with markDown text
class ChangelogView extends StatelessWidget {
  ChangelogView({super.key, this.markdownData, this.replaceForDefaultUpdateText});

  /// markdown string to show for user
  final String? markdownData;

  /// Replace for text, what show if [markdownData] is empty
  final String? replaceForDefaultUpdateText;

  final settingsBloc = GetIt.instance<SettingsBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: settingsBloc.getStreamByEnum(CoreSettingsEnum.showChangelog),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.getUserOrDefaultValueAsString == 'true') {
          final settingsBloc = GetIt.instance<SettingsBloc>();
          Widget widget;
          if (markdownData == null) {
            widget = Text(replaceForDefaultUpdateText ?? GetIt.instance<CoreI18n>().defaultUpdateText);
          } else {
            widget = MarkdownWidget(data: markdownData!);
          }
          return SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(child: widget),
                  TextButton(
                    onPressed: () {
                      final showSetting = settingsBloc.getByEnum(CoreSettingsEnum.showChangelog);
                      if (showSetting != null) settingsBloc.updateUserValueCallback(showSetting)('false');
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

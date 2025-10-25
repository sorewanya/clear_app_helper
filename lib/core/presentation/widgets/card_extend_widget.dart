import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/functions.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardExtendWidget extends StatelessWidget {
  const CardExtendWidget({required this.cardWidgetSizeSetting, required this.widgets, super.key, this.middleWidgets});
  final EnumsOfSettings cardWidgetSizeSetting;
  final List<Widget> widgets;

  final List<Widget>? middleWidgets;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: context.read<SettingsBloc>().getByEnum(cardWidgetSizeSetting),
      stream: context.read<SettingsBloc>().getStreamByEnum(cardWidgetSizeSetting),
      builder: (context, cardWidgetSizeSnapshot) {
        if (!cardWidgetSizeSnapshot.hasData && cardWidgetSizeSnapshot.hasData is! SettingsValue) {
          return const SizedBox();
        }
        final cardWidgetSize = SettingsValue.fromEntity(cardWidgetSizeSnapshot.data);

        final bool notSmall = !(cardWidgetSize?.getUserOrDefaultCompareToNamedOfValues('small') ?? false);
        final bool isBig = cardWidgetSize?.getUserOrDefaultCompareToNamedOfValues('big') ?? false;

        return notSmall
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...isBig ? widgets : middleWidgets ?? widgets,
                  TextButton(
                    onPressed: () {
                      FunctionsHelper.setNextSettingsVariantByEnum(cardWidgetSizeSetting);
                    },
                    child: isBig
                        ? IconsHelper.getIconByEnum(IconSettingsEnum.dropUp)
                        : IconsHelper.getIconByEnum(IconSettingsEnum.dropDown),
                  ),
                ],
              )
            : TextButton(
                onPressed: () {
                  FunctionsHelper.setNextSettingsVariantByEnum(cardWidgetSizeSetting);
                },
                child: IconsHelper.getIconByEnum(IconSettingsEnum.dropDown),
              );
      },
    );
  }
}

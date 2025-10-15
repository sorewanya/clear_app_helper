import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/rfw/rfw_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/icon_true_false.dart';
import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rfw/rfw.dart';

class RfwHelper {
  (String, Map<String, Object>) values;
  final void Function(String, Map<String, Object?>)? onEvent;
  final SettingsBloc settingsBloc;
  RfwHelper({required this.values, required this.settingsBloc, this.onEvent});
  //TODO use decodeLibraryBlob ?
  WidgetLibrary localWidgets = LocalWidgetLibrary(<String, LocalWidgetBuilder>{
    'CircleAvatar': (BuildContext context, DataSource source) {
      return CircleAvatar(child: Text(source.v<String>(<Object>['text']) ?? ''));
    },
    'IconTrueFalse': (BuildContext context, DataSource source) {
      return IconTrueFalse(check: source.v<bool>(<Object>['check']) ?? false);
    },
    //TODOLATE когда добавят в rfw fontPackage заменить на обычный Icon
    'MdiIcon': (BuildContext context, DataSource source) {
      return Icon(MdiIconData(source.v<int>(<Object>['icon']) ?? 0xf1136));
    },
    'IconFromSettingsName': (BuildContext context, DataSource source) {
      return IconsHelper.getIcon(source.v<String>(<Object>['settingName']) ?? '');
    },
    //FIXME
    // 'ItemDeleteIcon': (BuildContext context, DataSource source) {
    //   return ItemDeleteIcon(
    //     isDeleted: item.isDeleted,
    //     onPressed: () => itemBloc.add(
    //       TaskBlocEvent.remove(
    //         item: item.copyWith(isDeleted: !item.isDeleted),
    //         pop: () {},
    //       ),
    //     ),
    //   );
    // },
  });

  Widget getRfwWidgetBySettings(String rfwStringSettings) {
    final String? rfwString = settingsBloc.getByNamed(rfwStringSettings)?.getUserOrDefaultValueAsString;
    return rfwString != null ? getRfwWidget(rfwString) : Text('Rfw:$rfwStringSettings!');
  }

  Widget getRfwWidgetBySettingsEnum(EnumsOfSettings settings) {
    return getRfwWidgetBySettings(settings.name);
  }

  Widget getRfwWidget(String rfwString) {
    return RfwWidget(rfwString: rfwString, values: values, localWidgets: localWidgets, onEvent: onEvent);
  }
}

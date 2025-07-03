import 'package:clear_app_helper/settings/domain/entities/enums_of_settings.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ItemActionEnum {
  makeCopy,
  lock, //1
  share,
  delete, //3
  export,
}

///ItemActions - swipe actions of item
class ItemActions {
  final EnumsOfSettings itemSwipeLeftToRightSetting;
  final EnumsOfSettings itemSwipeRightToLeftSetting;
  final ItemActionEnum? itemDismissAction;
  final Function(int itemId) makeCopy;
  final Function(int itemId) lock;
  final Function(int itemId) share;
  final Function(int itemId) delete;
  final Function(int itemId) export;

  //FIXME make Functions Future?
  dismiss(int itemId) {
    if (itemDismissAction == null) return;
    switch (itemDismissAction!) {
      case ItemActionEnum.makeCopy:
        makeCopy(itemId);
      case ItemActionEnum.lock:
        lock(itemId);
      case ItemActionEnum.share:
        share(itemId);
      case ItemActionEnum.delete:
        delete(itemId);
      case ItemActionEnum.export:
        export(itemId);
    }
  }

  ItemActions({
    required this.itemSwipeLeftToRightSetting,
    required this.itemSwipeRightToLeftSetting,
    required this.itemDismissAction,
    required this.makeCopy,
    required this.lock,
    required this.share,
    required this.delete,
    required this.export,
  });

  List<String>? getItemSwipeLeftToRight(BuildContext context) {
    final blocGet = context.read<SettingsBloc>().getByNamed;
    return (blocGet(itemSwipeLeftToRightSetting.name)?.toType() as SettingsListOfValuesExtend?)
        ?.getUserOrDefaultAsListOfString(blocGet);
  }

  List<int>? getItemSwipeLeftToRightIndexes(BuildContext context) {
    final blocGet = context.read<SettingsBloc>().getByNamed;
    return (blocGet(itemSwipeLeftToRightSetting.name)?.toType() as SettingsListOfValuesExtend?)
        ?.getUserOrDefaultAsListOfIndexes;
  }

  List<String>? getItemSwipeRightToLeft(BuildContext context) {
    final blocGet = context.read<SettingsBloc>().getByNamed;
    return (blocGet(itemSwipeRightToLeftSetting.name)?.toType() as SettingsListOfValuesExtend?)
        ?.getUserOrDefaultAsListOfString(blocGet);
  }

  List<int>? getItemSwipeRightToLeftIndexes(BuildContext context) {
    final blocGet = context.read<SettingsBloc>().getByNamed;
    return (blocGet(itemSwipeRightToLeftSetting.name)?.toType() as SettingsListOfValuesExtend?)
        ?.getUserOrDefaultAsListOfIndexes;
  }
}

import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/flash_messenger.dart';
import 'package:clear_app_helper/core/presentation/theme_data.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_padded_decorated_box_with_opacity.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_scaffold_widget.dart';
import 'package:flutter/material.dart';

/// wraper arround [PopScope] and [MyScaffoldWidget] for DetailPage's
class MyDetailPageWidget extends StatelessWidget {
  const MyDetailPageWidget({
    required this.getShouldPop,
    required this.entityInfo,
    required this.body,
    required this.floatingActionButtonList,
    required this.saveForm,
    required this.pop,
    required this.formkey,
    super.key,
    this.appBarTitle,
    this.singleChildScrollViewController,
    this.isDelete,
    this.notScrollUpperWidgets,
    this.checkToPopMessage,
  });

  final bool Function() getShouldPop;

  final void Function()? checkToPopMessage;

  /// short entity name used in [`showSaveBottomFlash`]
  final String entityInfo;

  /// send to [MyScaffoldWidget]
  final Widget? appBarTitle;

  final Widget body;

  /// A button displayed floating above [body], in the bottom right corner. Передаётся в [MyScaffoldWidget]
  final List<Widget> floatingActionButtonList;

  /// sended to [`showSaveBottomFlash`]
  final Function() saveForm;

  /// sended to [`showSaveBottomFlash`]
  final Function() pop;

  /// used in [MyPaddedDecoratedBoxWithOpacity]
  final bool? isDelete;

  /// send to [Form]
  final GlobalKey<FormState> formkey;

  final List<Widget>? notScrollUpperWidgets;
  final ScrollController? singleChildScrollViewController;

  @override
  Widget build(BuildContext context) {
    void check({Function()? elseDo}) {
      if (!getShouldPop()) {
        checkToPopMessage != null
            ? checkToPopMessage!()
            : FlashMessengerHelper.showSaveBottomFlash(entityInfo: entityInfo, ifYes: saveForm, pop: pop);
      } else {
        if (elseDo != null) {
          elseDo();
        }
      }
    }

    return PopScope(
      canPop: getShouldPop(),
      onPopInvokedWithResult: (didPop, _) {
        check();
      },
      child: MyScaffoldWidget(
        appBarTitle: appBarTitle,
        appBarLeading: TextButton(
          onPressed: () {
            check(elseDo: pop);
          },
          child: IconsHelper.getIconByEnum(IconSettingsEnum.goBack),
        ),
        body: Column(
          children: [
            ...(notScrollUpperWidgets ?? []),
            Expanded(
              child: SingleChildScrollView(
                controller: singleChildScrollViewController,
                child: Form(
                  key: formkey,
                  child: MyPaddedDecoratedBoxWithOpacity(
                    color: getColorByBoolIsDeleted(isDelete != null && isDelete == true, context),
                    padding: const EdgeInsets.all(8),
                    child: body,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.center, children: floatingActionButtonList),
      ),
    );
  }
}

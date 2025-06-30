import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

///
/// Widget wrapper around [Scaffold]
///
class MyScaffoldWidget extends StatelessWidget {
  MyScaffoldWidget({
    required this.body,
    this.floatingActionButton,
    this.appBarTitle,
    this.appBarLeading,
    this.appBarActions,
    this.drawer,
    this.endDrawer,
    super.key,
  });

  /// Scaffold body
  final Widget body;

  /// A button displayed floating above [body], in the bottom right corner.
  /// Typically a [FloatingActionButton].
  final Widget? floatingActionButton;

  /// [AppBar] title
  final Widget? appBarTitle;

  /// Leading in Scaffold's [AppBar]
  final Widget? appBarLeading;

  /// by default actions contain [SearchButtonWidget], replaced by this
  final List<Widget>? appBarActions;

  /// Widget as child of [Scaffold]=> [Drawer]=> [SafeArea]=> [SingleChildScrollView]
  ///
  /// setup [appBarActions] if [endDrawer] is not for search
  final Widget? endDrawer;

  /// [Scaffold] drawer
  final Widget? drawer;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitHeight,
          child: appBarTitle ?? Text(GetIt.instance<CoreI18n>().defaultAppBarTitle),
        ),
        leading: appBarLeading,
        actions:
            appBarActions ??
            (endDrawer != null
                ? [SearchButtonWidget(onPressed: () => scaffoldKey.currentState!.openEndDrawer())]
                : null),
      ),
      drawer: drawer,
      endDrawer: endDrawer != null
          ? Drawer(
              child: SafeArea(child: SingleChildScrollView(child: endDrawer)),
            )
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/presentation/widgets/floating_plus_icon_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/list_view_of_items.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_scaffold_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_drawer_title_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/views_pages_empty_checker_widget.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:flutter/material.dart';

///
/// wrapper around [MyScaffoldWidget], for ListPage's,
class MyScaffoldListWidget<AppEntityType extends AppEntity> extends StatelessWidget {
  MyScaffoldListWidget({
    required this.onTapRouteName,
    required this.currentIdsList,
    required this.currentSearchEntity,
    required this.appBarTitle,
    required this.listSearchWidget,
    required this.drawer,
    required this.emptySearchEntity,
    required this.cardWidget,
    required this.resetSearch,
    required this.controller,
    this.appBarLeading,
    this.topInBodyColumn,
    this.endDrawer,
    super.key,
    this.addButton = true,
    this.onLongPress,
  });

  final Function()? resetSearch;

  /// send to [ListViewOfItems]
  final Widget Function(int id, Function removeItemFromListView) cardWidget;

  /// send to [ListViewOfItems]
  final String onTapRouteName;

  /// send to [ViewsPagesEmptyCheckerWidget] and [ListViewOfItems]
  final List<int> currentIdsList;

  /// send to [MyScaffoldWidget]
  final String appBarTitle;

  /// send to [FloatingPlusIconButton] and [ViewsPagesEmptyCheckerWidget]
  final SearchEntity currentSearchEntity;

  /// send to [ViewsPagesEmptyCheckerWidget] and [ListViewOfItems]
  final SearchEntity emptySearchEntity;

  /// send to [MyScaffoldWidget] as top widget in Column
  final Widget? topInBodyColumn;

  /// send to [MyScaffoldWidget]
  final Widget? appBarLeading;

  /// send to [MyScaffoldWidget]
  final Widget? drawer;

  /// send to [MyScaffoldWidget]
  final Widget? endDrawer;

  /// send to [MyScaffoldWidget]
  final Widget listSearchWidget;

  /// if true add [FloatingPlusIconButton]
  final bool addButton;

  /// send to [ListViewOfItems]
  final Function(int itemId)? onLongPress;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return MyScaffoldWidget(
      appBarTitle: Text(appBarTitle),
      appBarLeading: appBarLeading,
      body: Column(
        children: [
          if (topInBodyColumn != null) topInBodyColumn!,
          ViewsPagesEmptyCheckerWidget(
            currentListIsEmpty: currentIdsList.isEmpty,
            searchEntity: currentSearchEntity,
            resetSearch: resetSearch,
          ),
          ListViewOfItems(
            currentIdsList: currentIdsList,
            onTapRouteName: onTapRouteName,
            onLongPress: onLongPress,
            emptySearchEntity: emptySearchEntity,
            cardWidget: cardWidget,
            controller: controller,
          ),
        ],
      ),
      drawer: drawer,
      floatingActionButton: addButton
          ? FloatingPlusIconButton(onPressed: () => RouteHelper.toNamed(onTapRouteName, arguments: emptySearchEntity))
          : const SizedBox(),
      endDrawer: endDrawer ?? Column(children: [const SearchDrawerTitleWidget(), listSearchWidget]),
    );
  }
}

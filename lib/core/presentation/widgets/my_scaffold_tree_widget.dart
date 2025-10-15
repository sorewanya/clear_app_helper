import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/presentation/widgets/floating_plus_icon_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_scaffold_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_drawer_title_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/tree_view_of_items.dart';
import 'package:clear_app_helper/core/presentation/widgets/views_pages_empty_checker_widget.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:flutter/material.dart';

/// wrapper around [MyScaffoldWidget]
class MyScaffoldTreeWidget<AppEntityType extends AppEntity> extends StatelessWidget {
  MyScaffoldTreeWidget({
    required this.onTapRouteName,
    required this.curentTree,
    required this.curentSearchEntity,
    required this.appBarTitle,
    required this.listSearchWidget,
    required this.drawer,
    required this.emptySearchEntity,
    required this.cardWidget,
    required this.resetSearch,
    this.appBarLeading,
    this.topInBodyColumn,
    this.endDrawer,
    super.key,
    this.addButton = true,
    this.onLongPress,
  });

  final Function()? resetSearch;

  /// send to [TreeViewOfItems]
  final Widget Function(int id, Function removeItemFromListView) cardWidget;

  /// send to [TreeViewOfItems]
  final String onTapRouteName;

  /// send to [ViewsPagesEmptyCheckerWidget], [TreeViewOfItems]
  final TreeNode<int?> curentTree;

  /// send to [MyScaffoldWidget]
  final String appBarTitle;

  /// send to [FloatingPlusIconButton], [ViewsPagesEmptyCheckerWidget]
  final SearchEntity curentSearchEntity;

  /// send to [ViewsPagesEmptyCheckerWidget], [TreeViewOfItems]
  final SearchEntity emptySearchEntity;

  /// send to [MyScaffoldWidget]
  final Widget? topInBodyColumn;

  /// send to [MyScaffoldWidget]
  final Widget? appBarLeading;

  /// send to [MyScaffoldWidget]
  final Widget? drawer;

  /// send to [MyScaffoldWidget]
  final Widget? endDrawer;

  /// send to [MyScaffoldWidget]'s [endDrawer]
  final Widget listSearchWidget;

  /// if true add [FloatingPlusIconButton]
  final bool addButton;

  /// send to [TreeViewOfItems]
  final Function(int itemId)? onLongPress;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MyScaffoldWidget(
      appBarTitle: Text(appBarTitle),
      appBarLeading: appBarLeading,
      body: Column(
        children: [
          if (topInBodyColumn != null) topInBodyColumn!,
          ViewsPagesEmptyCheckerWidget(
            curentListIsEmpty: curentTree.childrenAsList.isEmpty,
            searchEntity: curentSearchEntity,
            resetSearch: resetSearch,
          ),
          TreeViewOfItems(
            tree: curentTree,
            onTapRouteName: onTapRouteName,
            onLongPress: onLongPress,
            emptySearchEntity: emptySearchEntity,
            cardWidget: cardWidget,
          ),
        ],
      ),
      drawer: drawer,
      floatingActionButton: addButton
          ? FloatingPlusIconButton(onPressed: () => RouteHelper.toNamed(onTapRouteName, arguments: curentSearchEntity))
          : const SizedBox(),
      endDrawer: endDrawer ?? Column(children: [const SearchDrawerTitleWidget(), listSearchWidget]),
    );
  }
}

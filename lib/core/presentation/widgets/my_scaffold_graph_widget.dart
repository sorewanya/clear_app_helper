import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/presentation/widgets/floating_plus_icon_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/graph_view_of_items.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_scaffold_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_drawer_title_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/views_pages_empty_checker_widget.dart';
import 'package:clear_app_helper/core/route_helper.dart';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

///
/// Widget wrapper around [MyScaffoldWidget], created for ListPage's,
///
class MyScaffoldGraphWidget<AppEntityType extends AppEntity> extends StatelessWidget {
  MyScaffoldGraphWidget({
    required this.onTapRouteName,
    required this.curentGraph,
    required this.curentSearchEntity,
    required this.appBarTitle,
    required this.listSearchWidget,
    this.appBarLeading,
    required this.drawer,
    this.topInBodyColumn,
    this.endDrawer,
    super.key,
    required this.emptySearchEntity,
    required this.cardWidget,
    this.addButton = true,
    this.onLongPress,
    required this.resetSearch,
  });

  final Function()? resetSearch;

  /// callback to get cartWidget for item
  ///
  /// for example: StreamBuilder with [CardWidgetTable]
  final Widget Function(int itemId) cardWidget;

  /// Route name ([RouteHelper.toNamed]), sended to [GraphViewOfItems]
  final String onTapRouteName;

  /// curent list of objects, sended to [ViewsPagesEmptyCheckerWidget] and [GraphViewOfItems]
  final Graph curentGraph;

  /// see [MyScaffoldWidget]
  final String appBarTitle;

  /// sended to [FloatingPlusIconButton] and [ViewsPagesEmptyCheckerWidget]
  final SearchEntity curentSearchEntity;

  /// sended to [ViewsPagesEmptyCheckerWidget] and [GraphViewOfItems]
  final SearchEntity emptySearchEntity;

  /// Widget what added in top of body. sended to [MyScaffoldWidget]
  final Widget? topInBodyColumn;

  /// Leading for [AppBar]. sended to [MyScaffoldWidget]
  final Widget? appBarLeading;

  /// sended to [MyScaffoldWidget]
  final Widget? drawer;

  /// replace default search drawer with [SearchDrawerTitleWidget]. sended to [MyScaffoldWidget]
  final Widget? endDrawer;

  /// sended to [endDrawer] after [SearchDrawerTitleWidget] in [Column].
  /// [Drawer] widget not used
  final Widget listSearchWidget;

  /// add or not button [FloatingPlusIconButton]
  final bool addButton;

  /// Функция реакции на долгое нажатие. sended to [GraphViewOfItems]
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
            curentListIsEmpty: !curentGraph.hasNodes(),
            searchEntity: curentSearchEntity,
            resetSearch: resetSearch,
          ),
          GraphViewOfItems<AppEntityType>(
            graph: curentGraph,
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

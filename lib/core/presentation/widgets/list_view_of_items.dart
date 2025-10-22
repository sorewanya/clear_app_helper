import 'package:clear_app_helper/core/domain/entities/item_actions.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/widgets/builders/current_entity_builder.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// List widget, used [ListView.separated]
class ListViewOfItems extends StatefulWidget {
  const ListViewOfItems({
    required this.currentIdsList,
    required this.onTapRouteName,
    required this.emptySearchEntity,
    required this.cardWidget,
    required this.controller,
    super.key,
    this.onLongPress,
  });

  /// elements ids
  final List<int> currentIdsList;

  /// name of page [RouteHelper.toNamed]
  final String onTapRouteName;

  /// Search entity, what copyWith with selected id and send to [onTapRouteName] page
  final SearchEntity emptySearchEntity;

  /// callback to get cartWidget for item
  /// [`removeItemFromListView`] - callback to remove from listView.
  final Widget Function(int id, Function removeItemFromListView) cardWidget;

  /// Long tap callback
  final Function(int id)? onLongPress;

  final ScrollController controller;

  @override
  State<ListViewOfItems> createState() => _ListViewOfItemsState();
}

class _ListViewOfItemsState extends State<ListViewOfItems> with SingleTickerProviderStateMixin {
  List<int> currentIdsList = [];
  @override
  void initState() {
    currentIdsList.addAll(widget.currentIdsList);
    super.initState();
  }

  @override
  void dispose() {
    currentIdsList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        controller: widget.controller,
        itemBuilder: (context, index) {
          final body = Padding(
            padding: const EdgeInsets.all(1),
            child: GestureDetector(
              onTap: () {
                RouteHelper.toNamed(
                  widget.onTapRouteName,
                  // ignore: avoid_dynamic_calls
                  arguments: widget.emptySearchEntity.copyWith(id: currentIdsList[index]) as SearchEntity,
                );
              },
              onLongPress: () => widget.onLongPress?.call(widget.currentIdsList[index]),
              child: ListTile(
                title: widget.cardWidget(currentIdsList[index], () => setState(() => currentIdsList.removeAt(index))),
              ),
            ),
          );

          return CurrentEntityBuilder(
            childFunc: (currentBloc) => currentBloc.itemActions != null
                ? Builder(
                    builder: (context) {
                      SlidableAction getSlidableActions(ItemActionEnum id) => switch (id) {
                        ItemActionEnum.makeCopy => SlidableAction(
                          onPressed: (_) {
                            currentBloc.itemActions!.makeCopy(currentIdsList[index]);
                          },
                          backgroundColor: const Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: MdiIcons.contentSavePlusOutline, //TODO make icon setting
                          label: GetIt.instance<CoreI18n>().makeCopy,
                        ),
                        ItemActionEnum.lock => SlidableAction(
                          borderRadius: BorderRadius.circular(10),
                          padding: const EdgeInsets.all(4),
                          onPressed: (_) {
                            currentBloc.itemActions!.lock(currentIdsList[index]);
                          },
                          backgroundColor: const Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: GetIt.instance<CoreI18n>().lock,
                        ),
                        ItemActionEnum.share => SlidableAction(
                          onPressed: (_) {
                            currentBloc.itemActions!.share(currentIdsList[index]);
                          },
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.share,
                          label: GetIt.instance<CoreI18n>().share,
                        ),
                        ItemActionEnum.delete => SlidableAction(
                          onPressed: (_) {
                            currentBloc.itemActions!.delete(currentIdsList[index]);
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: GetIt.instance<CoreI18n>().delete,
                        ),
                        ItemActionEnum.export => throw UnimplementedError(),
                      };
                      final itemSwipeRightToLeftIndexes =
                          (currentBloc.itemActions!.getItemSwipeRightToLeftIndexes(context) ?? []).nonNulls
                              .map((e) => getSlidableActions(ItemActionEnum.values[e]))
                              .toList();
                      final itemSwipeLeftToRightIndexes =
                          (currentBloc.itemActions!.getItemSwipeLeftToRightIndexes(context) ?? []).nonNulls
                              .map((e) => getSlidableActions(ItemActionEnum.values[e]))
                              .toList();
                      return Slidable(
                        key: UniqueKey(),
                        startActionPane: itemSwipeLeftToRightIndexes.isNotEmpty
                            ? ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),

                                dismissible: currentBloc.itemActions!.itemDismissAction != null
                                    ? DismissiblePane(
                                        onDismissed: () {
                                          currentBloc.itemActions!.dismiss(currentIdsList[index]);
                                        },
                                      )
                                    : null,
                                children: itemSwipeLeftToRightIndexes,
                              )
                            : null,
                        // The end action pane is the one at the right or the bottom side.
                        endActionPane: itemSwipeRightToLeftIndexes.isNotEmpty
                            ? ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),
                                dismissible: currentBloc.itemActions!.itemDismissAction != null
                                    ? DismissiblePane(
                                        onDismissed: () {
                                          currentBloc.itemActions!.dismiss(currentIdsList[index]);
                                        },
                                      )
                                    : null,
                                children: itemSwipeRightToLeftIndexes,
                              )
                            : null,
                        child: body,
                      );
                    },
                  )
                : body,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.grey[400]);
        },
        itemCount: currentIdsList.length,
        padding: const EdgeInsets.only(bottom: 60, left: 4, right: 4, top: 4),
      ),
    );
  }
}

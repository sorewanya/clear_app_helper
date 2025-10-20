import 'dart:io';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:flutter/material.dart';

/// create [TreeView.simpleTyped]
class TreeViewOfItems extends StatefulWidget {
  const TreeViewOfItems({
    required this.onTapRouteName,
    required this.cardWidget,
    required this.tree,
    required this.emptySearchEntity,
    super.key,
    this.onLongPress,
  });

  /// TreeNode of id's
  final TreeNode<int?> tree;

  final String onTapRouteName;
  final Function(int id)? onLongPress;

  final SearchEntity emptySearchEntity;

  final Widget Function(int id, Function removeItemFromTreeView) cardWidget;

  @override
  State<TreeViewOfItems> createState() => _TreeViewOfItemsState();
}

class _TreeViewOfItemsState extends State<TreeViewOfItems> {
  @override
  Widget build(BuildContext context) {
    final TreeNode<int?> curentTree = widget.tree;
    return Expanded(
      child: TreeView.simpleTyped<int?, TreeNode<int?>>(
        expansionBehavior: ExpansionBehavior.snapToTop,
        showRootNode: false,
        shrinkWrap: true,
        builder: (context, node) => node.data == null
            ? (node.key.contains('ͺ'))
                  ? Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              height: 100,
                              child: Image.file(File(node.key.replaceAll(RegExp(r'\ͺ'), '.')), fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Card(child: ListTile(title: Text(node.key)))
            : GestureDetector(
                onTap: () {
                  RouteHelper.toNamed(
                    widget.onTapRouteName,
                    // ignore: avoid_dynamic_calls
                    arguments: widget.emptySearchEntity.copyWith(id: node.data!) as SearchEntity,
                  );
                },
                onLongPress: () => widget.onLongPress != null ? widget.onLongPress!(node.data!) : {},
                child: widget.cardWidget(
                  node.data!,
                  () => setState(() => curentTree.removeWhere((element) => element == node)),
                ),
              ),
        tree: curentTree,
      ),
    );
  }
}

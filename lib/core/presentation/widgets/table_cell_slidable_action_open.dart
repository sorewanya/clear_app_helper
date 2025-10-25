import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TableCellSlidableActionOpen extends StatelessWidget {
  const TableCellSlidableActionOpen({super.key, this.right = false});
  final bool right;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.fill,
      child: GestureDetector(
        onTap: () => right ? Slidable.of(context)?.openEndActionPane() : Slidable.of(context)?.openStartActionPane(),
        child: Align(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight.withValues(alpha: 0.3),
              borderRadius: right
                  ? const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                  : const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            ),
            child: Icon(IconsHelper.getIconDataOrNullByString(right ? '>' : '<')),
          ),
        ),
      ),
    );
  }
}

import 'package:clear_app_helper/core/presentation/table_consts.dart';
import 'package:clear_app_helper/core/presentation/widgets/builders/curent_entity_builder.dart';
import 'package:clear_app_helper/core/presentation/widgets/table_cell_slidable_action_open.dart';
import 'package:flutter/material.dart';

//TODO add shimmer
class CardWidgetTable extends StatelessWidget {
  const CardWidgetTable({
    required this.isDeleted,
    required this.leftWidgets,
    required this.centerWidgets,
    required this.centerExtendedWidgetsNames,
    required this.centerExtendedWidget,
    required this.rightWidgets,
    super.key,
  });

  final bool? isDeleted;
  final List<Widget> leftWidgets;
  final List<Widget> centerWidgets;
  final List<String> centerExtendedWidgetsNames;
  final Widget centerExtendedWidget;
  final List<Widget> rightWidgets;

  @override
  Widget build(BuildContext context) {
    return CurentEntityBuilder(
      childFunc: (curentBloc) => Table(
        columnWidths: columnWidthsWithBothActionOpen,
        children: [
          TableRow(
            decoration: tableDecoration(context, isDeleted),
            children: [
              if (curentBloc.itemActions?.getItemSwipeLeftToRight(context)?.isNotEmpty ?? false)
                const TableCellSlidableActionOpen()
              else
                const SizedBox(width: 20),
              ...leftWidgets,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [...centerWidgets, if (centerExtendedWidgetsNames.isNotEmpty) centerExtendedWidget],
              ),
              ...rightWidgets,
              if (curentBloc.itemActions?.getItemSwipeRightToLeft(context)?.isNotEmpty ?? false)
                const TableCellSlidableActionOpen(right: true)
              else
                const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}

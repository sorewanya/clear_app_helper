import 'package:flutter/material.dart';
import 'package:clear_app_helper/core/presentation/theme_data.dart';

const columnWidthsWithBothActionOpen = {
  0: FixedColumnWidth(20),
  1: IntrinsicColumnWidth(),
  2: FlexColumnWidth(),
  3: IntrinsicColumnWidth(),
  4: FixedColumnWidth(20),
};
const columnWidthsWithRightActionOpen = {
  1: IntrinsicColumnWidth(),
  2: FlexColumnWidth(),
  3: IntrinsicColumnWidth(),
  4: FixedColumnWidth(20),
};
tableDecoration(BuildContext context, bool? isDeleted) => BoxDecoration(
  border: Border.all(color: Theme.of(context).primaryColorLight.withValues(alpha: 0.3)),
  borderRadius: BorderRadius.circular(10),
  color: getColorByBoolIsDeleted(isDeleted ?? false, context),
);

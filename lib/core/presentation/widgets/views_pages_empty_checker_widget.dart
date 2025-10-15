import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/presentation/widgets/empty_list_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_reset_text_and_icon_button.dart';
import 'package:flutter/material.dart';

/// Check [`curentList`] and [searchEntity] : [`isEmpty`]
///
/// if [curentListIsEmpty] true - add [EmptyListWidget],
///
/// if [searchEntity] not empty - add [SearchResetTextAndIconButton] with [resetSearch]
class ViewsPagesEmptyCheckerWidget extends StatelessWidget {
  const ViewsPagesEmptyCheckerWidget({
    required this.curentListIsEmpty,
    required this.searchEntity,
    required this.resetSearch,
    super.key,
  });

  /// take curentList.isEmpty
  final bool curentListIsEmpty;

  /// searchEntity used to take curentList
  final SearchEntity searchEntity;

  /// send to [SearchResetTextAndIconButton]
  final Function()? resetSearch;

  @override
  Widget build(BuildContext context) {
    if (curentListIsEmpty) {
      return EmptyListWidget(onTap: resetSearch);
    } else if (!searchEntity.isEmpty()) {
      return SearchResetTextAndIconButton(onTap: resetSearch, openEndDrawer: true);
    }
    return const SizedBox();
  }
}

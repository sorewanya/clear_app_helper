import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// used in search endDrawer as topic
class SearchDrawerTitleWidget extends StatelessWidget {
  const SearchDrawerTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Text(GetIt.instance<CoreI18n>().search, textScaler: TextScaler.linear(2)),
    );
  }
}

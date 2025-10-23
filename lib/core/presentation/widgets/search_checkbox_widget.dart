import 'package:clear_app_helper/core/presentation/functions.dart';
import 'package:clear_app_helper/core/presentation/widgets/icon_true_false.dart';
import 'package:flutter/material.dart';

class SearchCheckboxWidget extends StatelessWidget {
  const SearchCheckboxWidget({
    required this.param,
    required this.setParam,
    required this.filtr,
    required this.setState,
    required this.text,
    super.key,
  });

  /// text befor checkbox
  final String text;

  /// initial checkbox value
  final bool? param;

  /// new value callback
  final Function(bool? b) setParam;

  /// search filtr
  final Function() filtr;

  /// ```
  /// setState: (f) => setState(() => f()),
  /// ```
  final Function(Function() f) setState;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => setState(() {
        param != null ? setParam(null) : setParam(true);
        FunctionsHelper.showResetUpdateInfoBarOrFilter(filterSearchResults: filtr);
      }),
      child: Row(
        children: [
          IconTrueFalse(check: param ?? false),
          const SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }
}

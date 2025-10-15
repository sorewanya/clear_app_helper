import 'package:clear_app_helper/core/domain/entities/search_element.dart';
import 'package:clear_app_helper/core/domain/entities/text_field_variant.dart';
import 'package:clear_app_helper/core/presentation/widgets/loading_indicator.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_multi_row.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_text_form_field_with_reset_widget.dart';
import 'package:flutter/material.dart';

///for [SearchElementIntSet] and [SearchElementStringSet]
class SearchElementMultiTextFormFieldWidget<T extends SearchElement> extends StatelessWidget {
  const SearchElementMultiTextFormFieldWidget({
    required this.label,
    required this.getElement,
    required this.setElement(T updatedElement),
    required this.filtr,
    required this.setState,
    super.key,
    this.defaultValue,
  });

  /// send to [SearchElementMultiRow], as "$label: "
  final String label;

  /// get searchElement
  final T Function() getElement;

  /// set searchElement
  final Function(T e) setElement;

  final String? defaultValue;

  final Function() filtr;

  /// ```
  /// setState: (f) => setState(() => f()),
  /// ```
  final Function(Function() f) setState;

  @override
  Widget build(BuildContext context) {
    final T searchElement = getElement();

    return SearchElementMultiRow(
      label: label,
      onPressedAdd: () => setState(() {
        if (searchElement is SearchElementIntSet) {
          final int idToAdd = searchElement.intSet.contains(defaultValue ?? 0)
              ? 0
              : int.tryParse(defaultValue ?? '') ?? 0;
          searchElement.intSet.add(idToAdd);
        } else if (searchElement is SearchElementStringSet) {
          final String stringToAdd = searchElement.stringSet.contains('') ? '' : defaultValue ?? '';
          searchElement.stringSet.add(stringToAdd);
        }
        setElement(searchElement);
      }),
      children: searchElement is SearchElementIntSet
          ? searchElement.intSet.map((index) {
              final TextEditingController controller = TextEditingController()..text = index.toString();
              return SizedBox(
                width: 250,
                child: SearchTextFormFieldResetResetWidget(
                  controller: controller,
                  labelAndHintText: label,
                  filtr: filtr,
                  setSearchParam: (i) {
                    searchElement.intSet.remove(index);
                    if (i != '') searchElement.intSet.add(int.tryParse(i) ?? 0);
                  },
                  setState: setState,
                  variant: TextFieldVariant.integer(),
                ),
              );
            }).toList()
          : searchElement is SearchElementStringSet
          ? searchElement.stringSet.map((string) {
              final TextEditingController controller = TextEditingController()..text = string;
              return SizedBox(
                width: 250,
                child: SearchTextFormFieldResetResetWidget(
                  controller: controller,
                  labelAndHintText: label,
                  filtr: filtr,
                  setSearchParam: (i) {
                    searchElement.stringSet.remove(string);
                    if (i != '') searchElement.stringSet.add(i);
                  },
                  setState: setState,
                ),
              );
            }).toList()
          : [loadingIndicator('SearchElementMultiTextFormFieldWidget: unimplemented type of SearchElement loaded')],
    );
  }
}

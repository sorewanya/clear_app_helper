import 'package:clear_app_helper/core/domain/entities/id_and_name.dart';
import 'package:clear_app_helper/core/domain/entities/search_element.dart';
import 'package:clear_app_helper/core/presentation/widgets/clear_icon_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/name_drop_down_form_field_string_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_multi_row.dart';
import 'package:flutter/material.dart';

class SearchElementMultiDropdownWidget<T extends SearchElementIntSet> extends StatelessWidget {
  const SearchElementMultiDropdownWidget({
    super.key,
    required this.label,
    required this.getElement,
    required this.setElement(T updatedElement),
    this.defaultValue,
    required this.filtr,
    required this.setState,
    required this.dropdownList,
  });

  /// send to [SearchElementMultiRow], as "$label: "
  final String label;

  /// get searchElement
  final T Function() getElement;

  /// set searchElement
  final Function(T e) setElement;

  final int? defaultValue;

  final Function() filtr;

  /// ```
  /// setState: (f) => setState(() => f()),
  /// ```
  final Function(Function f) setState;

  final List<IdAndName> dropdownList;

  @override
  Widget build(BuildContext context) {
    final T searchElement = getElement();
    return SearchElementMultiRow(
      label: label,
      onPressedAdd: () => setState(() {
        final int? idToAdd = searchElement.intSet.contains(defaultValue ?? 1)
            ? dropdownList.where((element) => !searchElement.intSet.contains(element.id)).firstOrNull?.id
            : defaultValue ?? 1;
        if (idToAdd != null) {
          searchElement.intSet.add(idToAdd);
          setElement(searchElement);
        }
      }),
      children: searchElement.intSet.map((index) {
        return Row(
          children: [
            SizedBox(
              width: 120,
              child: NameDropDownFormFieldStringWidget(
                dropdownNameValue: dropdownList.where((element) => element.id == index).firstOrNull?.name ?? "_",
                setDropdownNameValue: (_) {},
                setDropdownNameValueId: (i) {
                  searchElement.intSet.remove(index);
                  searchElement.intSet.add(i);
                  setElement(searchElement);
                },
                curentMap: {for (var e in dropdownList) e.name: e.id},
                setState: setState,
              ),
            ),
            ClearIconButton(
              onPressed: () => setState(() {
                searchElement.intSet.remove(index);
                setElement(searchElement);
              }),
            ),
          ],
        );
      }).toList(),
    );
  }
}

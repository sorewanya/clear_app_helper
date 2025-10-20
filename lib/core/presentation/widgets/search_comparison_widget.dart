import 'package:clear_app_helper/core/domain/entities/comparison.dart';
import 'package:clear_app_helper/core/domain/entities/comparison_types.dart';
import 'package:clear_app_helper/core/domain/entities/search_element.dart';
import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/domain/entities/text_field_variant.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:clear_app_helper/core/presentation/functions.dart';
import 'package:clear_app_helper/core/presentation/settings_helper.dart';
import 'package:clear_app_helper/core/presentation/widgets/animated_toggle_switch_comperison.dart';
import 'package:clear_app_helper/core/presentation/widgets/clear_icon_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_text_field_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_input_decorator.dart';
import 'package:clear_app_helper/core/presentation/widgets/set_date_time_icon_button_widget.dart';
import 'package:flutter/material.dart';

///for [SearchElementDateTimeComparisons], [SearchElementIntegerComparisons], [SearchElementDoubleComparisons]
class SearchElementComparisonWidget<T extends SearchElement> extends StatelessWidget {
  const SearchElementComparisonWidget({
    required this.label,
    required this.getElement,
    required this.setElement(T updatedElement),
    required this.filtr,
    required this.setState,
    super.key,
    this.defaultComparison,
  });

  /// send to [`SearchElementMultiRow`], as "$label: "
  final String label;

  final T Function() getElement;

  final Function(T e) setElement;

  final Comparison? defaultComparison;

  final Function() filtr;

  /// ```
  /// setState: (f) => setState(() => f()),
  /// ```
  final Function(Function() f) setState;

  @override
  Widget build(BuildContext context) {
    final T searchElement = getElement();

    final dateformat = SettingsHelper.getDefaultDateFormat;

    void filtrInfoBar() => FunctionsHelper.showResetUpdateInfoBarOrFilter(filterSearchResults: filtr);
    final defaultComparison = this.defaultComparison ?? Comparison.greaterThan;
    return Row(
      children: [
        Column(
          children: [
            SizedBox(width: 70, child: Text('$label: ')),
            TextButton(
              onPressed: () => setState(() {
                switch (searchElement) {
                  case SearchElementDateTimeComparisons():
                    searchElement.comparisonList.add(
                      ComparisonDateTime(value: DateTime.now(), comparison: defaultComparison),
                    );
                  case SearchElementIntegerComparisons():
                    searchElement.comparisonList.add(ComparisonInteger(value: 0, comparison: defaultComparison));
                  case _:
                    ;
                }
                setElement(searchElement);
              }),
              child: IconsHelper.getIconByEnum(IconSettingsEnum.add),
            ),
          ],
        ),
        Builder(
          builder: (context) {
            List<ComparisonTypes> curentList = [];
            if (searchElement is SearchElementDateTimeComparisons) {
              curentList = searchElement.comparisonList;
            } else if (searchElement is SearchElementIntegerComparisons) {
              curentList = searchElement.comparisonList;
            }
            return Column(
              children: curentList.indexed.map((map) {
                final int index = map.$1;
                final item = map.$2;
                return Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 40,
                          child: AnimatedToggleSwitchComparison(
                            values: searchElement is SearchElementDateTimeComparisons
                                ? const [Comparison.greaterThan, Comparison.lessThan, Comparison.equal]
                                : null,
                            comparison: curentList[index].comparison,
                            setComparison: (newComparison) => setState(() {
                              if (searchElement is SearchElementDateTimeComparisons) {
                                searchElement.comparisonList[index] = searchElement.comparisonList[index].copyWith(
                                  comparison: newComparison,
                                );
                              } else if (searchElement is SearchElementIntegerComparisons) {
                                searchElement.comparisonList[index] = searchElement.comparisonList[index].copyWith(
                                  comparison: newComparison,
                                );
                              }
                              setElement(searchElement);
                            }),
                          ),
                        ),
                        const SizedBox(height: 5),
                        ...(searchElement is SearchElementDateTimeComparisons)
                            ? [
                                SetDateTimeIconButtonWidget(
                                  dateTime: (item as ComparisonDateTime).value,
                                  label: label,
                                  dateTimeSet: (dateTime) => setState(() {
                                    searchElement.comparisonList[index] = ComparisonDateTime(
                                      value: dateTime,
                                      comparison: item.comparison,
                                    );
                                    setElement(searchElement);
                                    filtrInfoBar();
                                  }),
                                ),
                                Text(dateformat.format(item.value)),
                              ]
                            : (searchElement is SearchElementIntegerComparisons)
                            ? [
                                SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: MyTextFieldWidget(
                                    variant: const TextFieldVariant.integer(),
                                    text: label,
                                    formFieldKey: ValueKey('label #$index'),
                                    getValue: () => '${(item as ComparisonInteger).value}',
                                    setValue: (newValue) {
                                      searchElement.comparisonList[index] = ComparisonInteger(
                                        value: int.tryParse(newValue) ?? 0,
                                        comparison: item.comparison,
                                      );
                                      setElement(searchElement);
                                    },
                                    decoration: getDefaultSearchInputDecorator(
                                      labelAndHintText: label,
                                      onPressed: filtr,
                                    ),
                                  ),
                                ),
                              ]
                            : (searchElement is SearchElementDoubleComparisons)
                            ? [
                                SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: MyTextFieldWidget(
                                    variant: const TextFieldVariant.double(),
                                    text: label,
                                    formFieldKey: ValueKey('label #$index'),
                                    getValue: () => '${(item as ComparisonDouble).value}',
                                    setValue: (newValue) {
                                      searchElement.comparisonList[index] = ComparisonDouble(
                                        value: double.tryParse(newValue.replaceAll(',', '.')) ?? 0,
                                        comparison: item.comparison,
                                      );
                                      setElement(searchElement);
                                    },
                                    decoration: getDefaultSearchInputDecorator(
                                      labelAndHintText: label,
                                      onPressed: filtr,
                                    ),
                                  ),
                                ),
                              ]
                            : [],
                      ],
                    ),
                    ClearIconButton(
                      onPressed: () => setState(() {
                        if (searchElement is SearchElementDateTimeComparisons) {
                          searchElement.comparisonList.removeAt(index);
                        } else if (searchElement is SearchElementIntegerComparisons) {
                          searchElement.comparisonList.removeAt(index);
                        }
                        setElement(searchElement);
                      }),
                    ),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

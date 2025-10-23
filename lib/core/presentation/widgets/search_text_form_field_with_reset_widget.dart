import 'package:clear_app_helper/core/domain/entities/text_field_variant.dart';
import 'package:clear_app_helper/core/presentation/functions.dart';
import 'package:clear_app_helper/core/presentation/widgets/clear_icon_button.dart';
import 'package:clear_app_helper/core/presentation/widgets/search_input_decorator.dart';
import 'package:flutter/material.dart';

class SearchTextFormFieldResetResetWidget extends StatelessWidget {
  const SearchTextFormFieldResetResetWidget({
    required this.controller,
    required this.setSearchParam,
    required this.labelAndHintText,
    required this.setState,
    required this.filtr,
    super.key,
    this.autofocus = false,
    this.validator,
    this.variant = const TextFieldVariant.text(),
  });

  final bool autofocus;

  final TextEditingController controller;

  /// callback to set new value
  final Function(String newValue) setSearchParam;

  ///decorator label
  final String labelAndHintText;

  /// ```
  /// setState: (f) => setState(() => f()),
  /// ```
  final Function(Function() f) setState;

  final Function() filtr;

  final String? Function(String? value)? validator;

  final TextFieldVariant? variant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            autofocus: autofocus,
            decoration: getDefaultSearchInputDecorator(
              labelAndHintText: labelAndHintText,
              onPressed: () {
                setSearchParam(controller.text);
                filtr();
              },
            ),
            keyboardType: variant?.keyboardType,
            inputFormatters: variant?.inputFormatters,
            onSaved: (value) {
              setSearchParam(value ?? '');
              filtr();
            },
            onFieldSubmitted: (value) {
              setSearchParam(value);
              filtr();
            },
            onChanged: setSearchParam,
            validator: validator,
          ),
        ),
        ClearIconButton(
          onPressed: () {
            setState(() {
              setSearchParam('');
              controller.clear();
              FunctionsHelper.showResetUpdateInfoBarOrFilter(filterSearchResults: filtr);
            });
          },
        ),
      ],
    );
  }
}

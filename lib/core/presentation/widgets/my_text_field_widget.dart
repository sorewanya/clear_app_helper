import 'dart:async';

import 'package:clear_app_helper/core/domain/entities/text_field_variant.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class MyTextFieldWidget extends StatefulWidget {
  const MyTextFieldWidget({
    required this.text,
    required this.formFieldKey,
    //TODO remove getValue, add initialValue and use controllers
    required this.getValue,
    required this.setValue,
    super.key,
    this.setShouldPop,
    this.validator,
    this.canBeEmpty,
    this.maxLines,
    this.focusNode,
    this.autofocus,
    this.onFieldSubmitted,
    this.controller,
    this.decoration = const InputDecoration(),
    this.labelStyle,
    this.variant = const TextFieldVariant.text(),
  });

  final TextFieldVariant? variant;

  /// см. [TextFormField]
  final int? maxLines;

  ///decorator and validator label
  final String text;

  /// send to [TextFormField]
  final Key formFieldKey;

  /// result (or "" if null) is set as [`initialValue`] at [TextFormField], if [controller] == null
  final String? Function() getValue;

  /// if true validation =0 or ="" pass
  final bool? canBeEmpty;

  /// send to [TextFormField]
  final FocusNode? focusNode;

  /// send to [TextFormField]
  final bool? autofocus;

  /// callback updated value
  final Function(String value) setValue;

  /// shouldPop set callback
  final Function(bool shouldPop)? setShouldPop;

  /// validator started after >0 and empty checks
  final String? Function(String? value)? validator;

  /// send to [TextFormField]
  final Function(String)? onFieldSubmitted;

  /// send to [TextFormField], if null use [getValue] or set "" in [`initialValue`]
  final TextEditingController? controller;

  /// send to [TextFormField]
  final InputDecoration? decoration;

  /// style text decoration
  final TextStyle? labelStyle;

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  late TextEditingController controller;
  final Duration waitTime = const Duration(milliseconds: 500);
  Timer? timer;
  String sendedValue = '';

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController(text: widget.getValue() ?? '');
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _sendValue(String value) {
    sendedValue = controller.text;
    widget.setValue(controller.text);
  }

  void trySendValue() {
    if (timer == null) {
      _sendValue(controller.text);

      timer = Timer(waitTime, () {
        if (sendedValue != controller.text) {
          _sendValue(controller.text);
        }
        timer = null;
      });
    }
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData('text/plain');
    if (data != null && data.text != null) {
      final selection = controller.selection;
      final start = selection.start;
      final end = selection.end;

      controller.text = controller.text.replaceRange(start, end, data.text!);

      controller.selection = TextSelection.fromPosition(TextPosition(offset: start + data.text!.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.insert && HardwareKeyboard.instance.isShiftPressed) {
            _pasteFromClipboard();
          }
        }
      },
      child: TextFormField(
        controller: controller,
        key: widget.formFieldKey,
        maxLines: widget.maxLines,
        minLines: 1,
        focusNode: widget.focusNode,
        style: Get.theme.textTheme.headlineSmall,
        decoration: getDefaultInputDecorator(labelAndHintText: widget.text, labelStyle: widget.labelStyle),
        keyboardType: widget.variant?.keyboardType,
        inputFormatters: switch (widget.variant) {
          IntegerTextFieldVariant() => [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))],
          DoubleTextFieldVariant() => [FilteringTextInputFormatter.allow(RegExp(r'^[0-9\.,]+$'))],
          _ => null,
        },
        autofocus: widget.autofocus ?? false,
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: (value) {
          widget.setShouldPop?.call(false);
          if (value != null) {
            if (widget.variant is DoubleTextFieldVariant) {
              controller.text = value.replaceAll(',', '.');
              trySendValue();
            } else {
              trySendValue();
            }
          }
        },
        onChanged: (value) {
          widget.setShouldPop?.call(false);
          if (widget.variant is DoubleTextFieldVariant) {
            controller.text = value.replaceAll(',', '.');
            trySendValue();
          } else {
            trySendValue();
          }
        },
        validator: (value) {
          //TODO use package form_field_validator?
          if (widget.canBeEmpty == null || widget.canBeEmpty == false) {
            if (value == null || value == '') return '${widget.text} ${GetIt.instance<CoreI18n>().validatorNotEmpty}';
            switch (widget.variant) {
              case IntegerTextFieldVariant():
                if ((int.tryParse(value) ?? -1) < 0) return GetIt.instance<CoreI18n>().validatorIntegerNotLessZero;
              case DoubleTextFieldVariant():
                final v = value.replaceAll(',', '.');
                if ((double.tryParse(v) ?? -1) < 0) return GetIt.instance<CoreI18n>().validatorDoubleNotLessZero;
              default:
                break;
            }
          }
          return widget.validator?.call(value);
        },
      ),
    );
  }
}

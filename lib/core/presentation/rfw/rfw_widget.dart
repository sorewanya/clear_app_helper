import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class RfwWidget extends StatefulWidget {
  final String rfwString;
  final (String, Map<String, Object>) values;
  final WidgetLibrary localWidgets;
  final void Function(String name, Map<String, Object?> arguments)? onEvent;
  const RfwWidget({
    super.key,
    required this.rfwString,
    required this.values,
    required this.localWidgets,
    required this.onEvent,
  });

  @override
  State<RfwWidget> createState() => _RfwWidgetState();
}

class _RfwWidgetState extends State<RfwWidget> {
  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();

  late final RemoteWidgetLibrary _remoteWidgets = parseLibraryFile(widget.rfwString);

  static const LibraryName coreName = LibraryName(<String>['core', 'widgets']);
  static const LibraryName materialName = LibraryName(<String>['material', 'widgets']);
  static const LibraryName mainName = LibraryName(<String>['main']);
  static const LibraryName localName = LibraryName(<String>['local']);

  @override
  void initState() {
    super.initState();
    // Local widget library:
    _runtime.update(coreName, createCoreWidgets());
    _runtime.update(materialName, createMaterialWidgets());
    _runtime.update(localName, widget.localWidgets);
    // Remote widget library:
    _runtime.update(mainName, _remoteWidgets);
    // Configuration data:
    _data.update(widget.values.$1, widget.values.$2);
  }

  @override
  Widget build(BuildContext context) {
    _data.update(widget.values.$1, widget.values.$2);
    return RemoteWidget(
      runtime: _runtime,
      data: _data,
      widget: const FullyQualifiedWidgetName(mainName, 'root'),
      onEvent: widget.onEvent,
    );
  }
}

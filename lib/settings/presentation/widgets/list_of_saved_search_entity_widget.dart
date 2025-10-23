import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/icons_helper.dart';
import 'package:flutter/material.dart';

class IndexedString {
  final int index;
  final String str;
  IndexedString({required this.index, required this.str});
}

class ListOfSavedSearchEntityWidget extends StatefulWidget {
  final List<String> values;
  final Function(List<String> values) updateValues;

  const ListOfSavedSearchEntityWidget({required this.values, required this.updateValues, super.key});

  @override
  State<ListOfSavedSearchEntityWidget> createState() => _ListOfSavedSearchEntityWidgetState();
}

class _ListOfSavedSearchEntityWidgetState extends State<ListOfSavedSearchEntityWidget> {
  List<IndexedString> list = [];
  @override
  void initState() {
    for (int index = 0; index < widget.values.length; index += 1) {
      list.add(IndexedString(index: index, str: widget.values[index]));
    }
    super.initState();
  }

  @override
  void dispose() {
    list.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withValues(alpha: 0.05);
    final Color evenItemColor = colorScheme.primary.withValues(alpha: 0.15);
    void updateUserValue() {
      widget.updateValues(list.map((e) => e.str).toList());
    }

    return SizedBox(
      height: 400,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColorLight.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor.withValues(alpha: 0.6),
        ),
        child: ReorderableListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              key: Key('$index'),
              tileColor: index.isOdd ? oddItemColor : evenItemColor,
              title: Row(
                children: [
                  Text(list[index].str),
                  IconButton(
                    onPressed: () => setState(() {
                      list.removeAt(index);
                      updateUserValue();
                    }),
                    icon: IconsHelper.getIconByEnum(IconSettingsEnum.delete),
                  ),
                ],
              ),
            );
          },
          onReorder: (oldIndex, newIndex) => setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final IndexedString item = list.removeAt(oldIndex);
            list.insert(newIndex, item);
            updateUserValue();
          }),
        ),
      ),
    );
  }
}

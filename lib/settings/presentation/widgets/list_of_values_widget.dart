import 'package:clear_app_helper/core/presentation/widgets/icon_true_false.dart';
import 'package:flutter/material.dart';

class CheckedIndexedString {
  bool check;
  final int index;
  final String str;
  CheckedIndexedString({required this.index, required this.str, this.check = false});
}

///used in SettingsDetailPage
class ListOfValuesWidget extends StatefulWidget {
  final String userValue;
  final List<String> values;
  final Function(String userValue) updateUserValue;

  const ListOfValuesWidget({required this.userValue, required this.values, required this.updateUserValue, super.key});

  @override
  State<ListOfValuesWidget> createState() => _ListOfValuesWidgetState();
}

class _ListOfValuesWidgetState extends State<ListOfValuesWidget> {
  List<CheckedIndexedString> list = [];
  @override
  void initState() {
    final List<int> userValueList = widget.userValue.split(',').map(int.tryParse).whereType<int>().toList();
    for (final index in userValueList) {
      list.add(CheckedIndexedString(index: index, str: widget.values[index], check: true));
    }
    for (int index = 0; index < widget.values.length; index += 1) {
      if (!userValueList.contains(index)) {
        list.add(CheckedIndexedString(index: index, str: widget.values[index]));
      }
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
      widget.updateUserValue(
        list
            .map((e) {
              if (e.check) return e.index;
            })
            .whereType<int>()
            .toList()
            .join(','),
      );
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
                  IconButton(
                    onPressed: () => setState(() {
                      list[index].check = !list[index].check;
                      updateUserValue();
                    }),
                    icon: IconTrueFalse(check: list[index].check),
                  ),
                  Text(list[index].str),
                ],
              ),
            );
          },
          onReorder: (oldIndex, newIndex) => setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final CheckedIndexedString item = list.removeAt(oldIndex);
            list.insert(newIndex, item);
            updateUserValue();
          }),
        ),
      ),
    );
  }
}

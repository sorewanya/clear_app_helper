import 'dart:convert';
import 'dart:io';

import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

///export item to 'filename ${item.id}.$fileExtension'
class ExportItem extends StatelessWidget {
  const ExportItem({
    required this.filename,
    required this.items,
    super.key,
    this.showIconOnly = false,
    this.fileExtension = 'xml',
  });

  final String filename;
  final List<AppEntity> items;
  final bool showIconOnly;
  final String fileExtension;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDownloadsDirectory(),
      builder: (context, future) {
        if (!future.hasData && future.data == null) {
          return loadingIndicator('load getDownloadsDirectory');
        }
        final Directory directory = future.data!;
        return IconButton(
          onPressed: () {
            for (final item in items) {
              final String fullpath = join(directory.path, '$filename ${item.id}.$fileExtension');
              final File file = File(fullpath);
              final exportString = '${item.runtimeType}:::${json.encode(item.toJson())}\n';
              file.writeAsStringSync(exportString);
            }
          },
          icon: Row(
            children: [
              const Icon(Icons.save_as_outlined),
              if (!showIconOnly)
                Text(
                  '${GetIt.instance<CoreI18n>().exportElements} ($filename) ${GetIt.instance<CoreI18n>().exportElementsInDiffFiles} $fileExtension',
                ),
            ],
          ),
        );
      },
    );
  }
}

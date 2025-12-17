// export_item_test.dart
import 'dart:io';

import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/app_path_provider.dart';
import 'package:clear_app_helper/core/functions/export_item.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'export_item_test.mocks.dart';

@GenerateMocks([AppPathProvider, AppEntity])
void main() {
  late MockAppPathProvider mockPathProvider;
  late Directory mockDirectory;

  setUpAll(() {
    mockPathProvider = MockAppPathProvider();
    mockDirectory = Directory('/mock/downloads');

    // Register dependencies in GetIt
    GetIt.instance
      ..registerSingleton<CoreI18n>(CoreI18n())
      ..registerSingleton<AppPathProvider>(mockPathProvider);
  });

  setUp(() {
    // Reset mocks before each test
    reset(mockPathProvider);
  });

  testWidgets('ExportItem shows loading indicator while directory is loading', (tester) async {
    when(mockPathProvider.getDownloadsDirectory()).thenAnswer((_) async => null);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExportItem(filename: 'test', items: []),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('loading indicator: load getDownloadsDirectory')), findsOneWidget);
  });

  testWidgets('ExportItem shows icon button when directory is loaded', (tester) async {
    when(mockPathProvider.getDownloadsDirectory()).thenAnswer((_) async => mockDirectory);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExportItem(filename: 'test', items: []),
        ),
      ),
    );

    await tester.pump(); // resolve future

    expect(find.byIcon(Icons.save_as_outlined), findsOneWidget);
    expect(
      find.text(
        '${GetIt.instance<CoreI18n>().exportElements} (test) ${GetIt.instance<CoreI18n>().exportElementsInDiffFiles} xml',
      ),
      findsOneWidget,
    );
  });

  testWidgets('ExportItem shows only icon when showIconOnly is true', (tester) async {
    when(mockPathProvider.getDownloadsDirectory()).thenAnswer((_) async => mockDirectory);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExportItem(filename: 'test', items: [], showIconOnly: true),
        ),
      ),
    );

    await tester.pump();

    expect(find.byIcon(Icons.save_as_outlined), findsOneWidget);
    expect(find.textContaining('Export elements'), findsNothing);
  });

  testWidgets('Export button exports each item to separate file', (tester) async {
    final mockItem1 = MockAppEntity();
    final mockItem2 = MockAppEntity();

    when(mockItem1.id).thenReturn(1);
    when(mockItem1.toJson()).thenReturn({'id': '1'});

    when(mockItem2.id).thenReturn(2);
    when(mockItem2.toJson()).thenReturn({'id': '2'});

    final List<AppEntity> items = [mockItem1, mockItem2];

    when(mockPathProvider.getDownloadsDirectory()).thenAnswer((_) async => mockDirectory);
    when(mockPathProvider.join('/mock/downloads', 'test 1.xml')).thenReturn('/mock/downloads/test 1.xml');
    when(mockPathProvider.join('/mock/downloads', 'test 2.xml')).thenReturn('/mock/downloads/test 2.xml');

    // Mock File.writeAsStringSync using real File but avoid actual I/O
    final writtenFiles = <String, String>{};

    when(mockPathProvider.writeFile(any, any)).thenAnswer((invocation) async {
      final String path = invocation.positionalArguments[0] as String;
      final String data = invocation.positionalArguments[1] as String;
      writtenFiles[path] = data;
    });

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExportItem(filename: 'test', items: items),
        ),
      ),
    );

    await tester.pump();

    // Tap the export button
    await tester.tap(find.byType(IconButton));
    await tester.pump();

    // Verify two files were "written"
    expect(writtenFiles.length, 2);
    expect(writtenFiles['/mock/downloads/test 1.xml'], 'MockAppEntity:::{"id":"1"}\n');
    expect(writtenFiles['/mock/downloads/test 2.xml'], 'MockAppEntity:::{"id":"2"}\n');
  });
}

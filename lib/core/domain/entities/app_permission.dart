import 'dart:developer';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

abstract class AppPermission {
  Future<bool> canWriteToDirectory(String directoryPath);
  Future<PermissionStatus?> storageRequest();
}

class AppPermissionImpl implements AppPermission {
  @override
  Future<bool> canWriteToDirectory(String directoryPath) async {
    final testFile = File(
      '$directoryPath${Platform.pathSeparator}.write_test_${DateTime.now().millisecondsSinceEpoch}',
    );
    try {
      await testFile.writeAsString('test');
      await testFile.delete();
      return true;
    } catch (e) {
      log('Cannot write to $directoryPath: $e');
      return false;
    }
  }

  @override
  Future<PermissionStatus?> storageRequest() => Permission.storage.request();
}

import 'package:permission_handler/permission_handler.dart';

abstract class AppPermission {
  Future<PermissionStatus?> request();
}

class AppPermissionImpl implements AppPermission {
  @override
  Future<PermissionStatus?> request() => Permission.storage.request();
}

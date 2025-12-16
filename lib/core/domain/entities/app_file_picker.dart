import 'package:file_picker/file_picker.dart';

abstract class AppFilePicker {
  Future<String?> getDirectoryPath();
}

class AppFilePickerImpl implements AppFilePicker {
  @override
  Future<String?> getDirectoryPath() => FilePicker.platform.getDirectoryPath();
}

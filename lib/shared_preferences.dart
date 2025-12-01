import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  factory SharedPreferencesHelper() => _instance ?? SharedPreferencesHelper._internal();
  SharedPreferencesHelper._internal() {
    _init();
    _instance = this;
  }
  static SharedPreferencesHelper? _instance;
  int id = 0;

  bool _inited = false;

  late SharedPreferences prefs;

  ///GETs
  bool get inited => _inited;

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    _inited = true;
  }
}

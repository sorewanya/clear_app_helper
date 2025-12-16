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

  late SharedPreferences _prefs;

  ///GETs
  bool get inited => _inited;

  String? getString(String key) => _prefs.getString(key);
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _inited = true;
  }
}

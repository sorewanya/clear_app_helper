import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  int id = 0;
  bool _inited = false;
  late SharedPreferences prefs;
  static SharedPreferencesHelper? _instance;

  SharedPreferencesHelper._internal() {
    _init();
    _instance = this;
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
    _inited = true;
  }

  ///GETs
  bool get inited => _inited;

  factory SharedPreferencesHelper() => _instance ?? SharedPreferencesHelper._internal();
}

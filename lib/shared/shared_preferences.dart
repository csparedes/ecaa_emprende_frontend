import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _preferences;
  static bool _isDarkMode = false;

  static Future init() async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    _preferences = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode {
    return _preferences.getBool('isDarkmode') ?? _isDarkMode;
  }

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _preferences.setBool('isDarkmode', value);
  }
}

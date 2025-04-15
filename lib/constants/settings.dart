import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static Settings? _settings;
  static SharedPreferences? preferences;

  static Future<Settings?> getInstance() async {
    if (_settings == null) {
      final secureStorage = Settings._();
      await secureStorage._init();
      _settings = secureStorage;
    }
    return _settings;
  }

  Settings._();
  Future _init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static bool get isUserLoggedIn =>
      preferences?.getBool("isUserLoggedIn") ?? false;
  static set isUserLoggedIn(bool value) =>
      preferences?.setBool("isUserLoggedIn", value);

  static String get accessToken => preferences?.getString("accessToken") ?? "";
  static set accessToken(String value) =>
      preferences?.setString("accessToken", value);

  static String get step => preferences?.getString("step") ?? "";
  static set step(String value) => preferences?.setString("step", value);

  static String get userName => preferences?.getString("userName") ?? "User";
  static set userName(String value) =>
      preferences?.setString("userName", value);

  static int get userId => preferences?.getInt("userId") ?? 0;
  static set userId(int value) => preferences?.setInt("userId", value);

  static void clear() async {
    Settings.isUserLoggedIn = false;
    await preferences?.clear();
  }
}

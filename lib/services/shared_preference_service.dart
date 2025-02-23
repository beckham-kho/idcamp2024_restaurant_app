import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final SharedPreferences _preferences;

  SharedPreferenceService(this._preferences);

  static const String keyAppThemeMode = "THEME_MODE";
  static const String keyNotificationSetting = "NOTIFICATION";


  Future<void> saveThemeMode(String value) async {
    try {
      await _preferences.setString(keyAppThemeMode, value);
    } catch(e) {
      throw Exception("Terjadi kesalahan saat menyimpan tema");
    }
  }

  Future<void> saveNotificationSetting(bool value) async {
    try {
      await _preferences.setBool(keyNotificationSetting, value);
    } catch(e) {
      throw Exception("Terjadi kesalahan saat menyimpan pengaturan notifikasi");
    }
  }


  String getThemeModeValue() {
    return _preferences.getString(keyAppThemeMode) ?? "";
  }

  bool getNotificationSetting() {
    return _preferences.getBool(keyNotificationSetting) ?? false;
  } 
}
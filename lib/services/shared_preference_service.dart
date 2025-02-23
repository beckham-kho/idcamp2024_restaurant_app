import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final SharedPreferences _preferences;

  SharedPreferenceService(this._preferences);

  static const String keyAppThemeMode = "THEME_MODE";


  Future<void> saveThemeMode(String appThemeMode) async {
    try {
      await _preferences.setString(keyAppThemeMode, appThemeMode);
    } catch(e) {
      throw Exception("Terjadi kesalahan saat menyimpan tema");
    }
  }


  String getThemeModeValue() {
    return _preferences.getString(keyAppThemeMode) ?? "";
  } 
}
import 'package:flutter/material.dart';
import 'package:restaurant_app/services/shared_preference_service.dart';

class SharedPreferenceProvider extends ChangeNotifier {
  final SharedPreferenceService _service;

  SharedPreferenceProvider(this._service);

  String _message = "";
  String get message => _message;

  ThemeMode _appThemeMode = ThemeMode.light;
  ThemeMode get appThemeMode => _appThemeMode;

  final List<bool> _isThemeModeSelected = [false, false, false];
  List<bool> get isThemeModeSelected => _isThemeModeSelected;

  bool _isOn = false;
  bool get isOn => _isOn;

  Future<void> saveAppThemeModeValue(String value) async {
    try {
      await _service.saveThemeMode(value);
      _message = "Berhasil menyimpan data shared preference";
    } catch (e) {
      _message = "Gagal menyimpan data shared preference";
    }
    notifyListeners();
  }

  void getAppThemeModeValue() async {
    try {
      final selectedTheme = _service.getThemeModeValue();
      switch (selectedTheme) {
        case "light":
          _appThemeMode = ThemeMode.light;
          _isThemeModeSelected[0] = true;
          break;
        case "dark":
          _appThemeMode = ThemeMode.dark;
          _isThemeModeSelected[1] = true;
          break;
        default:
          _appThemeMode = ThemeMode.system;
          _isThemeModeSelected[2] = true;
      }
      _message = "Berhasil memuat data shared preference";
    } catch (e) {
      _message = "Gagal memuat data shared preference";
    }
    notifyListeners();
  }

  Future<void> saveNotificationSettingValue(bool value) async {
    try {
      await _service.saveNotificationSetting(value);
      _message = "Berhasil menyimpan data shared preference";
    } catch (e) {
      _message = "Gagal menyimpan data shared preference";
    }
    notifyListeners();
  }

  void getNotificationSettingValue() async {
    try {
      _isOn = _service.getNotificationSetting();
      _message = "Berhasil memuat data shared preference";
    } catch (e) {
      _message = "Gagal memuat data shared preference";
    }
    notifyListeners();
  }
}

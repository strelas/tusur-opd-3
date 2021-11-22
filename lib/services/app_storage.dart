
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStorage {
  static const String _themeKey = "OPD_THEME";
  static const String _notificationKey = "OPD_NOTIFICATION";
  final _flutterStorage = const FlutterSecureStorage();


  static AppStorage? _storage;

  static AppStorage get shared {
    final storage = _storage ?? AppStorage._();
    _storage = storage;
    return storage;
  }

  void saveTheme(CustomTheme theme) {
    String value = theme is LightTheme ? "light" : "dark";
    _flutterStorage.write(key: _themeKey, value: value);
  }
  
  Future<CustomTheme> getTheme() {
    return _flutterStorage.read(key: _themeKey).then((value) {
      if (value == "dark") {
        return DarkTheme();
      } else {
        return LightTheme();
      }
    });
  }
  
  Future<bool> getIsNotificationEnabled() async {
    final value = await _flutterStorage.read(key: _notificationKey);
    return value == "true";
  }
  
  void saveIsNotificationEnabled({required bool enabled}) {
    _flutterStorage.write(key: _notificationKey, value: enabled.toString());
  }

  AppStorage._();
}
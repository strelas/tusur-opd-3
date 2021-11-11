
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStorage {
  static const String themeKey = "OPD_THEME";
  final _flutterStorage = const FlutterSecureStorage();


  static AppStorage? _storage;

  static AppStorage get shared {
    final storage = _storage ?? AppStorage._();
    _storage = storage;
    return storage;
  }

  void saveTheme(CustomTheme theme) {
    String value = theme is LightTheme ? "light" : "dark";
    _flutterStorage.write(key: themeKey, value: value);
  }
  
  Future<CustomTheme> getTheme() {
    return _flutterStorage.read(key: themeKey).then((value) {
      if (value == "dark") {
        return DarkTheme();
      } else {
        return LightTheme();
      }
    });
  }

  AppStorage._();
}
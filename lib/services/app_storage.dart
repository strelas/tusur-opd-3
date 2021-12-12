import 'dart:convert';
import 'dart:developer';

import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_app/entity/goal.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStorage {
  static const String _themeKey = "OPD_THEME";
  static const String _notificationKey = "OPD_NOTIFICATION";
  static const String _goalsKey = "OPD_GOALS_KEY";
  final _flutterStorage = const FlutterSecureStorage();

  static AppStorage? _storage;

  static AppStorage get shared {
    final storage = _storage ?? AppStorage._();
    _storage = storage;
    return storage;
  }

  Future saveTheme(CustomTheme theme) {
    String value = theme is LightTheme ? "light" : "dark";
    return _flutterStorage.write(key: _themeKey, value: value);
  }

  Future saveGoals(List<Goal> goals) {
    log(goals.toString());
    final value = jsonEncode(goals.map((e) => e.toJson()).toList());
    log(value);
    return _flutterStorage.write(key: _goalsKey, value: value);
  }

  Future<List<Goal>> getGoals() async {
    try {
      return _flutterStorage.read(key: _goalsKey).then((value) {
        if (value == null) {
          return [];
        }
        log(value);
        return (jsonDecode(value) as List)
            .map((e) => Goal.fromJson(e))
            .toList();
      }).then((value) {
        log(value.toString());
        return value.map((e) => e as Goal).toList();
      });
    } catch(err, stacktrace) {
      log("$err\n$stacktrace");
      return [];
    }
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

  Future saveIsNotificationEnabled({required bool enabled}) {
    return _flutterStorage.write(
      key: _notificationKey,
      value: enabled.toString(),
    );
  }

  AppStorage._();
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CustomThemeNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  late CustomTheme _theme;
  CustomTheme get theme => _theme;

  CustomThemeNotifier({required CustomTheme initTheme}) {
    _theme = initTheme;
  }

  void changeTheme() {
    if (_theme is DartTheme) {
      _theme = CustomTheme.light();
    } else {
      _theme = CustomTheme.dark();
    }
    notifyListeners();
  }

}
abstract class CustomTheme {
  factory CustomTheme.light() => const LightTheme._();

  factory CustomTheme.dark() => const DartTheme._();

  Color get color1;

  Color get color2;

  Color get color3;

  Color get color4;

  Color get color5;

  static CustomTheme of(BuildContext context) {
    return context.watch<CustomThemeNotifier>().theme;
  }
}

class LightTheme implements CustomTheme {
  const LightTheme._();

  @override
  Color get color1 => const Color(0xFFD3D9DE);

  @override
  Color get color2 => const Color(0xFF323640);

  @override
  Color get color3 => const Color(0xFF005BAC);

  @override
  Color get color4 => const Color(0xFF848E9C);

  @override
  Color get color5 => const Color(0xFFFF0000);
}

class DartTheme implements CustomTheme {
  const DartTheme._();

  @override
  Color get color1 => const Color(0xFF15161C);

  @override
  Color get color2 => const Color(0xFF22282E);

  @override
  Color get color3 => const Color(0xFF007DBE);

  @override
  Color get color4 => const Color(0xFF848E9C);

  @override
  Color get color5 => const Color(0xFFFF0000);
}

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
      _theme = LightTheme();
    } else {
      _theme = DartTheme();
    }
    notifyListeners();
  }

}
abstract class CustomTheme {

  Color get color1;

  Color get color2;

  Color get color3;

  Color get color4;

  Color get color5;

  Color get defaultColor1 => Colors.black;

  Color get defaultColor2 => Colors.white;

  Color get defaultColor3 => const Color(0xFF0C0E11).withOpacity(0.5);

  Color get defaultColor4 => Colors.white.withOpacity(0.1);

  Color get defaultColor5 => Colors.red;

  static CustomTheme of(BuildContext context) {
    return context.watch<CustomThemeNotifier>().theme;
  }
}

class LightTheme extends CustomTheme {

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

class DartTheme extends CustomTheme {

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

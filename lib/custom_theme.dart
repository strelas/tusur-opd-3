import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/app_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class CustomThemeCubit extends Cubit<CustomTheme> {

  CustomThemeCubit({required CustomTheme initTheme}) : super(LightTheme());

  void changeTheme() {
    CustomTheme newState;

    if (state is DarkTheme) {
      newState = LightTheme();
    } else {
      newState = DarkTheme();
    }
    emit(newState);
    AppStorage.shared.saveTheme(newState);
  }

}
abstract class CustomTheme {

  Color get fontColor;

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
    return context.watch<CustomThemeCubit>().state;
  }
}

class LightTheme extends CustomTheme {

  @override
  Color get fontColor => Colors.black;

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

class DarkTheme extends CustomTheme {
  @override
  Color get fontColor => Colors.white;

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

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

  Color get color6;

  Color get color7;

  Color get color8 => const Color(0xFFF92B2B);

  Color get color9;

  Color get color11;


  static CustomTheme of(BuildContext context) {
    return context.watch<CustomThemeCubit>().state;
  }
}

class LightTheme extends CustomTheme {

  @override
  Color get fontColor => Colors.black;

  @override
  Color get color1 => Colors.white;

  @override
  Color get color2 => Colors.black.withOpacity(0.06);

  @override
  Color get color3 => Colors.black.withOpacity(0.1);

  @override
  Color get color4 => const Color(0xFFC8CDD2);

  @override
  Color get color5 => const Color(0xFF005BAC);

  @override
  Color get color6 => Colors.black;

  @override
  Color get color7 => Color.fromARGB((255*0.45).floor(),12, 14, 17);

  @override
  Color get color9 => Color.fromARGB((255*0.4).floor(), 12, 14, 17);

  @override
  Color get color11 => Colors.white.withOpacity(0.85);
}

class DarkTheme extends CustomTheme {
  @override
  Color get fontColor => Colors.white;

  @override
  Color get color1 => const Color(0xFF22282E);

  @override
  Color get color2 => Color.fromARGB((255/2).floor(), 12, 14, 17);

  @override
  Color get color3 => Color.fromARGB((255*7/10).floor(), 12, 14, 17);

  @override
  Color get color4 => const Color(0xFF15161C);

  @override
  Color get color5 => const Color(0xFF007DBE);

  @override
  Color get color6 => Colors.white;

  @override
  Color get color7 => const Color(0xFF848E9C);

  @override
  Color get color9 => Color.fromARGB((255*0.5).floor(), 12, 14, 17);

  @override
  Color get color11 => Color.fromARGB((255*0.6).floor(), 132, 142, 156);
}

import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_app/screens/main_screen/main_screen.dart';
import 'package:flutter_app/screens/settings_screen/notification_bloc.dart';
import 'package:flutter_app/services/app_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: AppStorage.shared.getIsNotificationEnabled(),
        builder: (context, isNotificationEnabled) {
          return FutureBuilder<CustomTheme>(
            future: AppStorage.shared.getTheme(),
            builder: (context, snapshot) {
              final initTheme = snapshot.data;
              final notificationEnabled = isNotificationEnabled.data;
              if (initTheme == null || notificationEnabled == null) {
                return Container(); // TODO: make loading screen
              } else {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (_) => CustomThemeCubit(initTheme: initTheme)),
                    BlocProvider(
                        create: (_) => NotificationBloc(notificationEnabled)),
                  ],
                  child: MaterialApp(
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    title: "ОПД 3",
                    home: Builder(builder: (context) {
                      return DefaultTextStyle(
                        style:
                            TextStyle(color: CustomTheme.of(context).fontColor),
                        child: const MainScreen(),
                      );
                    }),
                  ),
                );
              }
            },
          );
        });
  }
}

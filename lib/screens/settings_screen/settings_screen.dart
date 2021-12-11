import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_scaffold.dart';
import 'package:flutter_app/components/custom_switcher.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_app/screens/settings_screen/notification_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPageBody extends StatefulWidget {
  const SettingsPageBody({Key? key}) : super(key: key);

  @override
  _SettingsPageBodyState createState() => _SettingsPageBodyState();
}

class _SettingsPageBodyState extends State<SettingsPageBody> {
  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 105),
          height: 2,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25),
              )
            ],
            borderRadius: BorderRadius.circular(5),
            color: theme.color5,
          ),
        ),
        const SizedBox(
          height: 23,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 35, left: 25),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.notifications,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              BlocBuilder<NotificationBloc, bool>(builder: (context, snapshot) {
                return CustomSwitcher(
                  initValue: snapshot,
                  onSwitch: (value) {
                    final event = value
                        ? NotificationBlocEvents.enable
                        : NotificationBlocEvents.disable;
                    context.read<NotificationBloc>().add(event);
                  },
                );
              }),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 35, left: 25),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.theme,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              CustomSwitcher(
                initValue: BlocProvider.of<CustomThemeCubit>(context).state
                    is DarkTheme,
                onSwitch: (_) {
                  BlocProvider.of<CustomThemeCubit>(context).changeTheme();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_logo.dart';
import 'package:flutter_app/components/custom_nav_bar.dart';
import 'package:flutter_app/components/custom_scaffold.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_app/screens/calendar_screen/calendar_provider.dart';
import 'package:flutter_app/screens/calendar_screen/calendar_screen.dart';
import 'package:flutter_app/screens/goals_screen/goals_page.dart';
import 'package:flutter_app/screens/settings_screen/settings_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = CustomTheme.of(context);
    return CustomScaffold(
      child: Column(
        children: [
          Expanded(child: mainPage),
          CustomNavBar(
            items: [
              Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset('assets/planner.svg'),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context)!.planner,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset('assets/calendar.svg'),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context)!.calendar,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset('assets/settingsIcon.svg'),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context)!.settings,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
            onItemTap: (index) {
              setState(() {
                this.index = index;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget get mainPage {
    if (index == 0) {
      return const GoalsPage();
    } else if (index == 1) {
      return CalendarProvider();
    } else if (index == 2) {
      return const SettingsPageBody();
    }
    return Container();
  }
}

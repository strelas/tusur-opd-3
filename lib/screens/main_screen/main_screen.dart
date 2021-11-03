import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_logo.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Scaffold(
        backgroundColor: theme.defaultColor2,
        body: Column(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Stack(children: [
                    CustomLogo(),
                    SvgPicture.asset(
                      'assets/figure.svg',
                      width: 600,
                      height: 600,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 480, left: 320, right: 20),
                      child: Container(
                          width: 70,
                          height: 70,
                          child: IconButton(
                            iconSize: 70,
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/plusButton.svg',
                                width: 70,
                                height: 70,
                              ))),
                    )
                  ]),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/planner.svg'),
                label: 'Планировщик'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/calendar.svg'),
                label: 'Календарь'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/settingsIcon.svg'),
                label: 'Настройки'),
          ],
          backgroundColor: theme.color1,
        ));
  }
}

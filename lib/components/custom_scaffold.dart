import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_logo.dart';

class CustomScaffold extends StatelessWidget {
  final Widget widget;
  final bool haveFloatingButton;
  const CustomScaffold({this.haveFloatingButton = false, this.widget = const SizedBox(width: 0, height: 0,), Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = CustomTheme.of(context);
    return Scaffold(
      floatingActionButton: haveFloatingButton ? IconButton(
          iconSize: 70,
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/plusButton.svg',
            width: 60,
            height: 60,
          )) : null,
      body: SafeArea(
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(children: [
            const CustomLogo(),
            SvgPicture.asset(
              'assets/figure.svg',
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            ),
            widget
          ]);
        },
        ),
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
        )
    );
  }
}


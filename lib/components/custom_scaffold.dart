import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_logo.dart';

class CustomScaffold extends StatefulWidget {
  final Widget child;
  final bool haveFloatingButton;
  final Function(int)? onNavBarTap;

  const CustomScaffold({
    this.onNavBarTap,
    this.haveFloatingButton = false,
    this.child = const SizedBox(
      width: 0,
      height: 0,
    ),
    Key? key,
  }) : super(key: key);

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      Container(),
      Container(),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 105, left: 20),
            child: Container(
              width: 320,
              height: 2,
              color: CustomTheme.of(context).color3,
            ),
          ),
        ],
      ),
    ];
    CustomTheme theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.color1,
        floatingActionButton: widget.haveFloatingButton
            ? IconButton(
                iconSize: 70,
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/plusButton.svg',
                  width: 60,
                  height: 60,
                ))
            : null,
        body: Builder(
          builder: (context) {
            return DefaultTextStyle(
              style: TextStyle(color: theme.fontColor),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(children: [
                      const CustomLogo(),
                      SvgPicture.asset(
                        'assets/figure.svg',
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        color: theme.color3,
                      ),
                      widget.child,
                    ]);
                  },
                ),
              ),
            );
          }
        ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

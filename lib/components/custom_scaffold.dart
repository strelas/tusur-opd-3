import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = CustomTheme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: theme is DarkTheme
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Builder(builder: (context) {
            return DefaultTextStyle(
              style: TextStyle(color: theme.fontColor),
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(children: [
                      SvgPicture.asset(
                        'assets/figure.svg',
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        color: Colors.black,
                      ),
                      Positioned.fill(
                        child: Column(
                          children: [
                            const CustomLogo(),
                            Expanded(child: widget.child),
                          ],
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

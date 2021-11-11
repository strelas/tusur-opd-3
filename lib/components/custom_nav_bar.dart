import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';

class CustomNavBar extends StatefulWidget {
  final List<Widget> items;
  final Function(int)? onItemTap;

  const CustomNavBar({Key? key, required this.items, this.onItemTap}) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Container(
      height: 50,
      color: theme.color1,
      child: Row(
        children: [
          for (int i = 0; i < widget.items.length; i++)
            Expanded(
              child: InkWell(
                onTap: (){
                  widget.onItemTap?.call(i);
                  log(i.toString());
                },
                child: Center(
                  child: widget.items[i],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

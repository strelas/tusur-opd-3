import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';

class CustomNavBar extends StatefulWidget {
  final List<Widget> items;
  final Function(int)? onItemTap;

  const CustomNavBar({Key? key, required this.items, this.onItemTap})
      : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Container(
      height: 50 + MediaQuery.of(context).padding.bottom,
      color: theme.color4,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                for (int i = 0; i < widget.items.length; i++)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = i;
                        });
                        widget.onItemTap?.call(i);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected == i ? theme.color3 : null,
                          borderRadius: BorderRadius.horizontal(
                            left: i != 0
                                ? const Radius.circular(10)
                                : Radius.zero,
                            right: i != widget.items.length
                                ? const Radius.circular(10)
                                : Radius.zero,
                          ),
                        ),
                        child: Center(
                          child: widget.items[i],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

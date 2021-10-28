import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';

class CustomSwitcher extends StatefulWidget {
  final Function(bool)? onSwitch;
  final bool initValue;

  const CustomSwitcher({
    Key? key,
    this.onSwitch,
    this.initValue = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomSwitcherState();
  }
}

class _CustomSwitcherState extends State<CustomSwitcher> {
  late bool value;

  @override
  void initState() {
    value = widget.initValue;
    super.initState();
  }

  Duration get duration => const Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          value = !value;
          widget.onSwitch?.call(value);
        });
      },
      child: Container(
        width: 75,
        height: 30,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: value ? theme.color3 : theme.color4,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              top: 0,
              bottom: 0,
              right: value ? 0 : 75,
              duration: duration,
              child: onState,
            ),
            AnimatedPositioned(
              top: 0,
              bottom: 0,
              left: value ? 75 : 0,
              duration: duration,
              child: offState,
            ),
            AnimatedPositioned(
              duration: duration,
              top: 1,
              bottom: 1,
              left: value ? 46 : 1,

              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: theme.defaultColor2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get offState {
    final theme = CustomTheme.of(context);
    return Container(
      width: 75,
      height: 30,
      color: theme.color4,
      child: Row(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              "OFF",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: theme.defaultColor2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get onState {
    final theme = CustomTheme.of(context);
    return Container(
      width: 75,
      height: 30,
      color: theme.color3,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "ON",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: theme.defaultColor2,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

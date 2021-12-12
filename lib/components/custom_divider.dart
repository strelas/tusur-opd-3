import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 2),
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
    );
  }
}

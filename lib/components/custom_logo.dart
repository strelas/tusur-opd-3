import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Container(
      width: 380,
      height: 80,
      child: CustomPaint(
        size: Size(380, (325*0.25666666666666665).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: MyPainter(theme: theme),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 25, bottom: 30.5, top: 16),
          child: SvgPicture.asset('lib/assets/svg/logo.svg', color: Colors.white,),
        ),
      ),
    );
  }
}


class MyPainter extends CustomPainter {
  CustomTheme theme;
  MyPainter({required this.theme});
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width,0);
    path_0.lineTo(0,0);
    path_0.lineTo(0,size.height*0.5974026);
    path_0.lineTo(0,size.height*0.9935065);
    path_0.lineTo(size.width*0.04448100,size.height*0.8246753);
    path_0.lineTo(size.width*0.5700167,size.height*0.8246753);
    path_0.lineTo(size.width*0.9100000,size.height*0.8246753);
    path_0.lineTo(size.width,size.height*0.4870130);
    path_0.lineTo(size.width,0);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = theme.color3;
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
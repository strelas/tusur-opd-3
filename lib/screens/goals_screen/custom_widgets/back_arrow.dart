import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 12,
      child: CustomPaint(
        painter: _ArrowPainter(CustomTheme.of(context)),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final CustomTheme theme;

  _ArrowPainter(this.theme);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height / 2);
    canvas.drawPath(path, Paint()..color = theme.color5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

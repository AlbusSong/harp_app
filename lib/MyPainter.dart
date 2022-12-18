import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:harp_app/Others/Constants/GeneralConstants.dart';
import 'package:harp_app/Others/Tool/GlobalTool.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // print('paint size: ${size}');

    var rect = Offset.zero & size;

    var _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.stroke;
    _paint.color = Colors.yellow;
    _paint.strokeWidth = 10;
    // _paint.maskFilter = MaskFilter.blur(BlurStyle.inner, 10.0);
    // _paint.blendMode = BlendMode.src;

    // var points1 = [
    //   Offset(size.width / 2, size.height / 3),
    //   Offset(size.width, size.height),
    //   Offset(size.width * 2, size.height * 2),
    // ];
    // canvas.drawPoints(ui.PointMode.lines, points1, _paint);

    // var points2 = [
    //   // 原点(0, 0)为控件左上角
    //   Offset(0, 0),
    //   Offset(100, 100),
    //   Offset(100, 300), //被忽略
    // ];
    // _paint.color = Colors.black;
    // //PointMode.lines只2个点有效，后面参数被忽略
    // canvas.drawPoints(ui.PointMode.lines, points2, _paint);

    // var points3 = [
    //   Offset(100, 100),
    //   Offset(200, 100),
    //   Offset(100, 50),
    // ];
    // _paint.color = Colors.blueAccent;
    // //PointMode.polygon N个点连成线
    // canvas.drawPoints(ui.PointMode.polygon, points3, _paint);

    _paint.color = hexColor("723030");
    _paint.strokeWidth = 26;
    var path = Path()
      ..moveTo(150, 0)
      ..lineTo(size.width - 200, size.height)
      ..lineTo(size.width - 450, size.height)
      ..lineTo(150 - 250, 0)
      ..close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

import 'dart:math';

import 'package:agemob/Pages/midTerm.dart';
import 'package:flutter/material.dart';

class MidTermPointer extends CustomPainter{

  final double sliderPosition;
  final double dragPercentage;

  final Color color;

  final Paint fillPainter;
  final Paint termPainter;

  MidTermPointer({
    @required this.sliderPosition,
    @required this.dragPercentage,
    @required this.color,
}): fillPainter = Paint()
  ..color = color
  ..style = PaintingStyle.fill,
  termPainter = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5;

  @override
  void paint(Canvas canvas, Size size){
    _paintAnchors(canvas, size);
    _paintLine(canvas, size);
    _paintBlock(canvas, size);
  }


  _paintAnchors(Canvas canvas, Size size){
    //canvas.drawCircle(Offset(0.0, size.height), 5.0, fillPainter);
    //canvas.drawCircle(Offset(size.width, size.height), 5.0, fillPainter);
  }

  _paintBlock(Canvas canvas, Size size){
    Rect sliderRect = Offset(sliderPosition, size.height - 150.0) & Size(3.0, 200.0);
    canvas.drawRect(sliderRect, fillPainter);
  }
  _paintLine(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width/2, 0);
    //path.arcTo(rect, sliderPosition/2, sliderPosition, false);
    path.lineTo(sliderPosition, size.height - 150.0);
    path.lineTo(sliderPosition, size.height + 50.0);
    //path.close();
    canvas.drawPath(path, fillPainter);
    canvas.drawCircle(Offset(size.width/2,size.height- 50), 150, termPainter);
    Path path1 = Path();
    //Rect sliderRect1 = (Offset(size.width/2,size.height- 200))& Size(2.0, 300.0);
    Rect sliderRect1 = (Offset(0,0))& Size(300.0, 3.0);
    canvas.drawRect(sliderRect1, fillPainter);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
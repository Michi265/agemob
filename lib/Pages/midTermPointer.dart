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
    //Rect sliderRect = Offset(sliderPosition, size.height - 150.0) & Size(3.0, 200.0);
    //rotate(canvas, size.width / 2, size.height - 50, 22.5);
    //canvas.drawRect(sliderRect, fillPainter);
  }
  _paintLine(Canvas canvas, Size size) {
    /*
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    //path.arcTo(rect, sliderPosition/2, sliderPosition, false);
    path.lineTo(sliderPosition, size.height - 150.0);
    path.lineTo(sliderPosition, size.height + 50.0);
    //path.close();
    rotate(canvas, size.width / 2, size.height - 50, -22.5);
    canvas.drawPath(path, fillPainter);
    rotate(canvas, size.width / 2, size.height - 50, 22.5);
    Path path1 = Path();
    //Rect sliderRect1 = (Offset(size.width/2,size.height- 200))& Size(2.0, 300.0);
    Rect sliderRect1 = (Offset(0, 0)) & Size(300.0, 3.0);
    canvas.drawRect(sliderRect1, fillPainter);

    */
    canvas.drawCircle(
        Offset(size.width / 2, size.height - 50), 150, termPainter);

    canvas.drawLine(Offset(size.width / 2,size.height-50),Offset(0,0) , Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0);

  }
  /*
  _paintLine1(Canvas canvas1, Size size){
    Rect sliderRect2 = (Offset(0, 0)) & Size(300.0, 3.0);
    rotate(canvas1, size.width / 2, size.height - 50, 45);
    canvas1.drawRect(sliderRect2, fillPainter);
    rotate(canvas1, size.width / 2, size.height - 50, -45);
  }
  _paintLine2(Canvas canvas2, Size size){
    Rect sliderRect2 = (Offset(0, 0)) & Size(300.0, 3.0);
    rotate(canvas2, size.width/2, size.height-50, -45);
    //rotate(canvas2, size.width / 2, size.height - 50, 180);
    canvas2.drawRect(sliderRect2, fillPainter);
    rotate(canvas2, size.width/2, size.height-50, 45);
  }

  void rotate(Canvas canvas1, double cx, double cy, double angle) {
    canvas1.translate(cx, cy);
    canvas1.rotate(angle);
    canvas1.translate(-cx, -cy);
  }

   */

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
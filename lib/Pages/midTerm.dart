import 'dart:math';
import 'dart:ui';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:agemob/Pages/midTermPointer.dart';
import 'package:flutter/material.dart';

class MidTerm extends StatefulWidget {

  @override
  _MidTermState createState() => _MidTermState();
}

class _MidTermState extends State<MidTerm> {

  Color selectedColor = Colors.black;
  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;
  List<DrawingPoints> points = List();
  bool showBottomList = false;
  double opacity = 1.0;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20.0),
            Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icon.png')),),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width - 218.0),
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
                color: Colors.red,
                iconSize: 30.0,
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            points.add(DrawingPoints(
                points: details.globalPosition,
                //renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanStart: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            points.add(DrawingPoints(
                points: details.globalPosition,
                paint: Paint()
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanEnd: (details) {
          setState(() {
            points.add(null);
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: DrawingPainter(
            pointsList: points,
          ),
        ),
      ),
    );
  }
}


class DrawingPainter extends CustomPainter {
  DrawingPainter({
    this.pointsList,

  });
  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = List();

  bool init = false;
  var workLeftX = new List(10);
  var workLeftY= new List(10);
  var workRightX = new List(10);
  var workRightY = new List(10);

  void paintCerchio(Canvas canvas, Size size){
    double stepWorkY = (((size.width/2)-15)*sin(pi/3))/10;
    double stepWorkX = (((size.width/2)-15)*cos(pi/3))/10;

    for(int i= 0; i < 10; i++) {
      this.workRightX[i] = (size.width / 2) - (i * stepWorkX);
      this.workLeftX[i] = (size.width / 2) + (i * stepWorkX);

      this.workRightY[i] = (size.height / 2) - (i * stepWorkY);
      this.workLeftY[i] = (size.height / 2) - (i * stepWorkY);
    }
      canvas.drawLine(Offset(size.width / 2, size.height / 2),
          Offset(this.workRightX[this.workRightX.length-1], this.workRightY[this.workRightY.length-1]), Paint()
            ..color = Colors.black
            ..strokeWidth = 10);

      canvas.drawLine(Offset(size.width / 2, size.height / 2),
          Offset(this.workLeftX[this.workLeftX.length-1], this.workLeftY[this.workLeftY.length-1]), Paint()
            ..color = Colors.black
            ..strokeWidth = 10);
  }
  double distance( double x1, double y1, double x2, double y2){
    return sqrt(pow((x1-x2), 2)+ pow((y1-y2), 2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    /*
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        //canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            //pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        //canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }

     */
    if(this.init == false){
      paintCerchio(canvas, size);
      this.init = true;
    }
    if (pointsList != null && pointsList.length >= 2) {

      double best_distance = 10000;
      var best_index;

      for(int i= 0; i < 10; i++) {
        double d = distance(pointsList[pointsList.length - 1].points.dx,pointsList[pointsList.length - 1].points.dy, this.workRightX[i],this.workRightY[i])
            + distance(pointsList[pointsList.length - 1].points.dx,pointsList[pointsList.length - 1].points.dy, this.workLeftX[i],this.workLeftY[i]);
        if (d < best_distance){
          best_distance = d;
          best_index = i;
        }
      }

      Path path = new Path();
      path.moveTo(size.width / 2, size.height / 2);
      path.lineTo(this.workRightX[best_index],
          this.workRightY[best_index]);
      path.lineTo(this.workLeftX[best_index],
          this.workLeftY[best_index]);
      canvas.drawPath(path, Paint()
        ..color = Colors.pinkAccent);
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint paint;
  Offset points;
  DrawingPoints({this.points, this.paint});
}

enum SelectedMode { StrokeWidth, Opacity, Color }

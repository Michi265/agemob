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


  bool init = false;

  var cultureX = new List(10);
  var cultureY = new List(10);

  var workX = new List(10);
  var workY = new List(10);

  var healthX = new List(10);
  var healthY = new List(10);

  var axisWorkX;
  var axisWorkY;
  var axisHealthX;
  var axisHealthY;
  var axisCultureX;
  var axisCultureY;

  var workRefRightX;
  var workRefRightY;
  var workRefLeftX;
  var workRefLeftY;

  var cultureRefRightX;
  var cultureRefRightY;
  var cultureRefLeftX;
  var cultureRefLeftY;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
      child:AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 20.0),
            Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icon.png')),),
            ),
            SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 218.0),
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
      ),),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            computeSectors(new Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height));
            points.add(DrawingPoints(
                points: renderBox.localToGlobal(details.localPosition),
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
                points: renderBox.localToGlobal(details.localPosition),
                paint: Paint()
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanEnd: (details) {
          setState(() {
            //points.add(null);
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: DrawingPainter(
            pointsList: points,
            axisWorkX : this.axisWorkX,
            axisWorkY: this.axisWorkY,
            axisHelthX: this.axisHealthX,
            axisHelthY: this.axisHealthY,
            axisCultureX: this.axisCultureX,
            axisCultureY: this.axisCultureY,
            workRefRightX: this.workRefRightX,
            workRefRightY: this.workRefRightY,
            workRefLeftX: this.workRefLeftX,
            workRefLeftY: this.workRefLeftY,
            cultureRefRightX: this.cultureRefRightX,
            cultureRefRightY: this.cultureRefRightY,
            cultureRefLeftX: this.cultureRefLeftX,
            cultureRefLeftY: this.cultureRefLeftY
          ),
        ),
      ),
    );
  }

  void paintCerchio(Canvas canvas, Size size) {
    double stepWorkY = (((size.width / 2) - 15) * sin(pi / 3)) / 10;
    double stepWorkX = (((size.width / 2) - 15) * cos(pi / 3)) / 10;
    double stepCulture = ((size.width / 2) - 15) / 10;

    for (int i = 0; i < 10; i++) {
      this.workX[i] = (size.width / 2) + (i * stepWorkX);
      this.healthX[i] = (size.width / 2) - (i * stepWorkX);

      this.workY[i] = (size.height / 2) - (i * stepWorkY);
      this.healthY[i] = (size.height / 2) - (i * stepWorkY);

      this.cultureX[i] = (size.width / 2) + (i * stepCulture);
      this.cultureY[i] = size.height / 2 ;
    }

    this.axisWorkX = this.workX[9];
    this.axisWorkY = this.workY[9];
    this.axisHealthX = this.healthX[9];
    this.axisHealthY = this.healthY[9];
    this.axisCultureX = this.cultureX[9];
    this.axisCultureY = this.cultureY[9];


  }

  double distance(double x1, double y1, double x2, double y2) {
    return sqrt(pow((x1 - x2), 2) + pow((y1 - y2), 2));
  }

  void computeSectors(Size size) {
    Canvas canvas;
    if (this.init == false) {
      paintCerchio(canvas, size);
      this.init = true;
    }
    if (this.points != null && this.points.length >= 2) {
      double best_distanceWork = 10000;
      double best_distanceCulture = 10000;
      var best_indexWork;
      var best_indexCulture;
      var sector = "nessuno";

      for (int i = 0; i < 10; i++) {
        double distanceWork = distance(
            this.points[this.points.length - 1].points.dx,
            this.points[this.points.length - 1].points.dy, this.workX[i],
            this.workY[i])
            + distance(this.points[this.points.length - 1].points.dx,
                this.points[this.points.length - 1].points.dy, this.healthX[i],
                this.healthY[i]);

        double distanceCulture = distance(
            this.points[this.points.length - 1].points.dx,
            this.points[this.points.length - 1].points.dy, this.cultureX[i],
            this.cultureY[i])
            + distance(this.points[this.points.length - 1].points.dx,
                this.points[this.points.length - 1].points.dy, this.workX[i],
                this.workY[i]);

        if (distanceWork < best_distanceWork) {
          best_distanceWork = distanceWork;
          best_indexWork = i;
        }

        if (distanceCulture < best_distanceCulture) {
          best_distanceCulture = distanceCulture;
          best_indexCulture = i;
        }

        if (best_distanceCulture < best_distanceWork) {
          sector = 'Culture';
        } else {
          sector = 'Work';
        }
      }

      if (sector == 'Work') {
        this.workRefRightX = this.workX[best_indexWork];
        this.workRefRightY = this.workY[best_indexWork];
        this.workRefLeftX = this.healthX[best_indexWork];
        this.workRefLeftY = this.healthY[best_indexWork];
      }
      if (sector == 'Culture') {
        this.cultureRefRightX = this.cultureX[best_indexCulture];
        this.cultureRefRightY = this.cultureY[best_indexCulture];
        this.cultureRefLeftX = this.workX[best_indexCulture];
        this.cultureRefLeftY = this.workY[best_indexCulture];
      }
    }
  }
}


class DrawingPainter extends CustomPainter {
  DrawingPainter({
    this.pointsList,
    this.workRefRightX,
    this.workRefRightY,
    this.workRefLeftX,
    this.workRefLeftY,

    this.cultureRefRightX,
    this.cultureRefRightY,
    this.cultureRefLeftX,
    this.cultureRefLeftY,

    this.axisWorkX,
    this.axisWorkY,
    this.axisHelthX,
    this.axisHelthY,
    this.axisCultureX,
    this.axisCultureY

  });
  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = List();

  var axisWorkX;
  var axisWorkY;
  var axisHelthX;
  var axisHelthY;
  var axisCultureX;
  var axisCultureY;

  var workRefRightX;
  var workRefRightY;
  var workRefLeftX;
  var workRefLeftY;

  var cultureRefRightX;
  var cultureRefRightY;
  var cultureRefLeftX;
  var cultureRefLeftY;




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


    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisWorkX,
            this.axisWorkY), Paint()
          ..color = Colors.black
          ..strokeWidth = 10);


    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisHelthX,
            this.axisHelthY), Paint()
          ..color = Colors.black
          ..strokeWidth = 10);

    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisCultureX, size.height / 2),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10);


    Path pathWork = new Path();
        pathWork.moveTo(size.width / 2, size.height / 2);
        pathWork.lineTo(this.workRefRightX,
            this.workRefRightY);
        pathWork.lineTo(this.workRefLeftX,
            this.workRefLeftY);

        canvas.drawPath(pathWork, Paint()
          ..color = Colors.pinkAccent);


        Path pathCulture = new Path();
        pathCulture.moveTo(size.width / 2, size.height / 2);
        pathCulture.lineTo(this.cultureRefRightX,
            this.cultureRefRightY);
        pathCulture.lineTo(this.cultureRefLeftX,
            this.cultureRefLeftY);

        canvas.drawPath(pathCulture, Paint()
          ..color = Colors.green);

      print('work '+ this.workRefRightX.toString());
      print('culture '+ this.cultureRefRightX.toString());

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

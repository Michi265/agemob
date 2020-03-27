import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:agemob/Pages/midTermPointer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MidTerm extends StatefulWidget {

  String project, country, destination, date, student,midTerm, finalTerm;
  MidTerm({this.project, this.country, this.destination, this.date, this.student, this.midTerm, this.finalTerm,


  });


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


  final Firestore firestore = Firestore.instance;

  var culture = 0;
  var fun = 0;
  var health = 0;
  var organization = 0;
  var social_relations = 0;
  var work = 0;


  bool init = false;

  var cultureX = new List(10);
  var cultureY = new List(10);

  var workX = new List(10);
  var workY = new List(10);

  var work1X = new List(10);
  var work1Y = new List(10);

  var healthX = new List(10);
  var healthY = new List(10);

  var health1X = new List(10);
  var health1Y = new List(10);

  var funX = new List(10);
  var funY = new List(10);

  var relationsX = new List(10);
  var relationsY = new List(10);

  var relations1X = new List(10);
  var relations1Y = new List(10);

  var organizationX = new List(10);
  var organizationY = new List(10);

  var organization1X = new List(10);
  var organization1Y = new List(10);


  var endX = new List(10);
  var endY = new List(10);

  var end1X = new List(10);
  var end1Y = new List(10);

  var axisCultureX;
  var axisCultureY;
  var axisWorkX;
  var axisWorkY;
  var axisWork1X;
  var axisWork1Y;
  var axisHealthX;
  var axisHealthY;
  var axisHealth1X;
  var axisHealth1Y;
  var axisFunX;
  var axisFunY;
  var axisRelationsX;
  var axisRelationsY;
  var axisRelations1X;
  var axisRelations1Y;
  var axisOrganizationX;
  var axisOrganizationY;
  var axisOrganization1X;
  var axisOrganization1Y;

  var workRefRightX;
  var workRefRightY;
  var workRefLeftX;
  var workRefLeftY;

  var cultureRefRightX;
  var cultureRefRightY;
  var cultureRefLeftX;
  var cultureRefLeftY;

  var healthRefRightX;
  var healthRefRightY;
  var healthRefLeftX;
  var healthRefLeftY;

  var funRefRightX;
  var funRefRightY;
  var funRefLeftX;
  var funRefLeftY;

  var relationsRefRightX;
  var relationsRefRightY;
  var relationsRefLeftX;
  var relationsRefLeftY;

  var organizationRefRightX;
  var organizationRefRightY;
  var organizationRefLeftX;
  var organizationRefLeftY;

  final double radius = 162;
  final String text = '        '+'HEALTH'+'                   '+'WORK'+'                    '+'CULTURE'+'           '+'ORGANIZATION'+'        '+'RELATIONS'+'                    '+'FUN'+'      ';
  final double startAngle= -pi / 2;
  final textStyle =  TextStyle(fontSize: 20, color: Colors.black);

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
      body:
      Stack(
        children: <Widget>[
      Column(
      children: <Widget>[
        Container(height: 30.0,
        width: MediaQuery.of(context).size.width-14,),
      Text('Drag your finger over the slices of the',
        style: TextStyle(fontSize: 20.0),textAlign: TextAlign.justify,),
      Text('wheel to express your satisfaction ',
          style: TextStyle(fontSize: 20.0),textAlign: TextAlign.justify,),
      Text(' about various aspects of your',
          style: TextStyle(fontSize: 20.0),textAlign: TextAlign.justify,),
      Text(' experience abroad.',
            style: TextStyle(fontSize: 20.0),textAlign: TextAlign.justify,),],),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                computeSectors(new Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height - 74));
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
                axisCultureX: this.axisCultureX,
                axisCultureY: this.axisCultureY,
                axisWorkX : this.axisWorkX,
                axisWorkY: this.axisWorkY,
                axisWork1X : this.axisWork1X,
                axisWork1Y: this.axisWork1Y,
                axisHelthX: this.axisHealthX,
                axisHelthY: this.axisHealthY,
                axisHelth1X: this.axisHealth1X,
                axisHelth1Y: this.axisHealth1Y,
                axisFunX: this.axisFunX,
                axisFunY: this.axisFunY,
                axisRelationsX: this.axisRelationsX,
                axisRelationsY: this.axisRelationsY,
                axisRelations1X: this.axisRelations1X,
                axisRelations1Y: this.axisRelations1Y,
                axisOrganizationX: this.axisOrganizationX,
                axisOrganizationY: this.axisOrganizationY,
                axisOrganization1X: this.axisOrganization1X,
                axisOrganization1Y: this.axisOrganization1Y,

                workRefRightX: this.workRefRightX,
                workRefRightY: this.workRefRightY,
                workRefLeftX: this.workRefLeftX,
                workRefLeftY: this.workRefLeftY,

                cultureRefRightX: this.cultureRefRightX,
                cultureRefRightY: this.cultureRefRightY,
                cultureRefLeftX: this.cultureRefLeftX,
                cultureRefLeftY: this.cultureRefLeftY,

                healthRefRightX : this.healthRefRightX,
                healthRefRightY : this.healthRefRightY,
                healthRefLeftX: this.healthRefLeftX,
                healthRefLeftY: this.healthRefLeftY,

                funRefRightX : this.funRefRightX,
                funRefRightY : this.funRefRightY,
                funRefLeftX : this.funRefLeftX,
                funRefLeftY : this.funRefLeftY,

                relationsRefRightX : this.relationsRefRightX,
                relationsRefRightY : this.relationsRefRightY,
                relationsRefLeftX : this.relationsRefLeftX,
                relationsRefLeftY : this.relationsRefLeftY,

                organizationRefRightX: this.organizationRefRightX,
                organizationRefRightY: this.organizationRefRightY,
                organizationRefLeftX: this.organizationRefLeftX,
                organizationRefLeftY: this.organizationRefLeftY,

                radius: this.radius,
                text: this.text,
                initialAngle: this.startAngle,
                textStyle: this.textStyle

              ),
            ),
          ),
          PreferredSize(
          //widthFactor: double.infinity,
          //heightFactor: double.infinity,
          preferredSize: Size.fromWidth(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
                new Align(
                  alignment: Alignment.bottomLeft,
                ),
                 SizedBox(
                  width:MediaQuery.of(context).size.width - 240,
                  child:RaisedButton(
                  onPressed: uploadTerm,
                  elevation: 105,
                  color:Colors.red[900],
                    child: Text('Save'),
                    textColor: Colors.white,
                ),
                ),
            ],
          ),
          ),
  ],
      ),

      );
  }
void uploadTerm(){

  if(this.culture == 0 || this.work == 0 || this.fun == 0 || this.health == 0 || this.organization == 0 || this.social_relations ==0){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 150,
            width: 200.0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextField(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Please complete!'),
                  ),
                  SizedBox(
                    width: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:Column(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(Icons.check, color:Colors.white)
                          ),
                        ],
                      ),
                      color:Colors.red[900],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );},);
  }else {
    DocumentReference documentReferenceProject = firestore.collection(
        'projects').document(widget.project.toString()).collection('Countries')
        .document(widget.country.toString()).collection('Destinations')
        .document(widget.destination.toString()).collection('Date')
        .document(widget.date.toString()).collection('Students')
        .document(widget.student.toString());
    documentReferenceProject.get().then((datasnapshot) async {
      if (datasnapshot.exists) {
        if (widget.midTerm == 'midTerm') {
          documentReferenceProject.updateData({'midTerm': "green"});

          documentReferenceProject.collection('feedbacks')
              .document('feedback1')
              .updateData({
            'culture': this.culture,
            'work': this.work,
            'health': this.health,
            'fun': this.fun,
            'organization': this.organization,
            'social_relations': this.social_relations
          });
          Navigator.of(context).pop();
        } else {
          documentReferenceProject.updateData({'finalTerm': "green"});

          documentReferenceProject.collection('feedbacks')
              .document('feedback2')
              .updateData({
            'culture': this.culture,
            'work': this.work,
            'health': this.health,
            'fun': this.fun,
            'organization': this.organization,
            'social_relations': this.social_relations
          });
          Navigator.of(context).pop();
        }
      } else {
        print('No such user');
      }
    });
  }
}

  void paintCerchio(Canvas canvas, Size size) {
    double stepCulture = ((size.width / 2) - 15) / 10;
    double stepWorkY = (((size.width / 2) - 15) * sin(pi / 3)) / 10;
    double stepWorkX = (((size.width / 2) - 15) * cos(pi / 3)) / 10;
    double stepHealthY = (((size.width / 2) - 15) * sin(pi / 3)) / 10;
    double stepHealthX = (((size.width / 2) - 15) * cos(pi / 3)) / 10;
    double stepFunY = (((size.width / 2) - 15) * sin(pi / 3)) / 10;
    double stepFunX = ((size.width / 2) - 15) / 10;
    double stepRelationsY = (((size.width / 2) - 15) * sin(pi / 3)) / 10;
    double stepRelationsX = (((size.width / 2) - 15) * cos(pi / 3)) / 10;
    double stepOrganizationY = (((size.width / 2) - 15) * sin(pi / 3)) / 10;
    double stepOrganizationX = (((size.width / 2) - 15) * cos(pi / 3)) / 10;

    for (int i = 0; i < 10; i++) {
      this.cultureX[i] = (size.width / 2) + (i * stepCulture);
      this.cultureY[i] = size.height / 2 ;

      this.workX[i] = (size.width / 2) + (i * stepWorkX);
      this.work1X[i] = (size.width / 2) - (i * stepWorkX);

      this.workY[i] = (size.height / 2) - (i * stepWorkY);
      this.work1Y[i] = (size.height / 2) - (i * stepWorkY);

      this.healthX[i] = (size.width / 2) - (i * stepHealthX);
      this.health1X[i] = (size.width / 2) - (i * stepHealthX);

      this.healthY[i] = (size.height / 2) - (i * stepHealthY);
      this.health1Y[i] = (size.height / 2) - (i * stepHealthY);

      this.funX[i] = (size.width / 2) - (i * stepFunX);
      this.funY[i] = size.height / 2 ;

      this.relationsX[i] = (size.width / 2) - (i * stepRelationsX);
      this.relations1X[i] = (size.width / 2) + (i * stepRelationsX);

      this.relationsY[i] = (size.height / 2) + (i * stepRelationsY);
      this.relations1Y[i] = (size.height / 2) + (i * stepRelationsY);

      this.organizationX[i] = (size.width / 2) + (i * stepOrganizationX);
      this.organization1X[i] = (size.width / 2) - (i * stepOrganizationX);

      this.organizationY[i] = (size.height / 2) + (i * stepOrganizationY);
      this.organization1Y[i] = (size.height / 2) + (i * stepOrganizationY);

    }

    this.axisCultureX = this.cultureX[9];
    this.axisCultureY = this.cultureY[9];
    this.axisWorkX = this.workX[9];
    this.axisWorkY = this.workY[9];
    this.axisWork1X = this.work1X[9];
    this.axisWork1Y = this.work1Y[9];
    this.axisHealthX = this.healthX[9];
    this.axisHealthY = this.healthY[9];
    this.axisHealth1X = this.health1X[9];
    this.axisHealth1Y = this.health1Y[9];
    this.axisFunX = this.funX[9];
    this.axisFunY = this.funY[9];
    this.axisRelationsX = this.relationsX[9];
    this.axisRelationsY = this.relationsY[9];
    this.axisRelations1X = this.relations1X[9];
    this.axisRelations1Y = this.relations1Y[9];
    this.axisOrganizationX = this.organizationX[9];
    this.axisOrganizationY = this.organizationY[9];
    this.axisOrganization1X = this.organization1X[9];
    this.axisOrganization1Y = this.organization1Y[9];

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
      double best_distanceHealth = 10000;
      double best_distanceFun = 10000;
      double best_distanceRelations = 10000;
      double best_distanceOrganization = 10000;

      var best_d = new List(6);
      var best_indexWork;
      var best_indexCulture;
      var best_indexHealth;
      var best_indexFun;
      var best_indexRelations;
      var best_indexOrganization;
      var sectorIndex = 0;

      for (int i = 0; i < 10; i++) {
        double distanceCulture = distance(
            this.points[this.points.length - 1].points.dx,
            this.points[this.points.length - 1].points.dy, this.cultureX[i],
            this.cultureY[i])
            + distance(this.points[this.points.length - 1].points.dx,
                this.points[this.points.length - 1].points.dy, this.workX[i],
                this.workY[i]);

        double distanceWork = distance(
            this.points[this.points.length - 1].points.dx,
            this.points[this.points.length - 1].points.dy, this.workX[i],
            this.workY[i])
            + distance(this.points[this.points.length - 1].points.dx,
                this.points[this.points.length - 1].points.dy, this.work1X[i],
                this.work1Y[i]);

        double distanceHealth = distance(
            this.points[this.points.length - 1].points.dx,
            this.points[this.points.length - 1].points.dy, this.healthX[i],
            this.healthY[i])
            + distance(this.points[this.points.length - 1].points.dx,
                this.points[this.points.length - 1].points.dy, this.health1X[i],
                this.health1Y[i]);

        double distanceFun = distance(
            this.points[this.points.length - 1].points.dx,
            this.points[this.points.length - 1].points.dy, this.funX[i],
            this.funY[i])
            + distance(this.points[this.points.length - 1].points.dx,
                this.points[this.points.length - 1].points.dy, this.relationsX[i],
                this.relationsY[i]);

        double distanceRelations = distance(
            this.points[this.points.length - 1].points.dx,
            this.points[this.points.length - 1].points.dy, this.relationsX[i],
            this.relationsY[i])
            + distance(this.points[this.points.length - 1].points.dx,
                this.points[this.points.length - 1].points.dy, this.relations1X[i],
                this.relations1Y[i]);

        double distanceOrganization = distance(
            this.points[this.points.length - 1].points.dx,
            this.points[this.points.length - 1].points.dy, this.organizationX[i],
            this.organizationY[i])
            + distance(this.points[this.points.length - 1].points.dx,
                this.points[this.points.length - 1].points.dy, this.cultureX[i],
                this.cultureY[i]);


        if (distanceCulture < best_distanceCulture) {
          best_distanceCulture = distanceCulture;
          print(best_distanceCulture);
          best_d[0] = best_distanceCulture;
          best_indexCulture = i;
        }

        if (distanceWork < best_distanceWork) {
          best_distanceWork = distanceWork;
          best_d[1] = best_distanceWork;
          best_indexWork = i;
        }


        if (distanceHealth < best_distanceHealth) {
          best_distanceHealth = distanceHealth;
          best_d[2] = best_distanceHealth;
          best_indexHealth = i;
        }

        if (distanceFun < best_distanceFun){
          best_distanceFun = distanceFun;
          best_d[3] = best_distanceFun;
          best_indexFun = i;
        }

        if (distanceRelations < best_distanceRelations){
          best_distanceRelations = distanceRelations;
          best_d[4] = best_distanceRelations;
          best_indexRelations = i;
        }

        if (distanceOrganization < best_distanceOrganization){
          best_distanceOrganization = distanceOrganization;
          best_d[5] = best_distanceOrganization;
          best_indexOrganization = i;
        }
      }
        var tmpBest = best_d[0];

        for (int i = 0; i < 5; i++) {
          if (tmpBest > best_d[i + 1]) {
            tmpBest = best_d[i + 1];
            sectorIndex = i+1;
          }
        }
      if (sectorIndex == 0) {
        this.cultureRefRightX = this.cultureX[best_indexCulture];
        this.cultureRefRightY = this.cultureY[best_indexCulture];
        this.cultureRefLeftX = this.workX[best_indexCulture];
        this.cultureRefLeftY = this.workY[best_indexCulture];

        this.culture = (best_indexCulture+1)*10;
      }

      if (sectorIndex == 1) {
        this.workRefRightX = this.workX[best_indexWork];
        this.workRefRightY = this.workY[best_indexWork];
        this.workRefLeftX = this.work1X[best_indexWork];
        this.workRefLeftY = this.work1Y[best_indexWork];

        this.work = (best_indexWork+1)*10;

      }

      if (sectorIndex == 2) {
        this.healthRefRightX = this.healthX[best_indexHealth];
        this.healthRefRightY = this.healthY[best_indexHealth];
        this.healthRefLeftX = this.funX[best_indexHealth];
        this.healthRefLeftY = this.funY[best_indexHealth];

        this.health = (best_indexHealth+1)*10;

      }

      if (sectorIndex == 3) {
        this.funRefRightX = this.funX[best_indexFun];
        this.funRefRightY = this.funY[best_indexFun];
        this.funRefLeftX = this.relationsX[best_indexFun];
        this.funRefLeftY = this.relationsY[best_indexFun];

        this.fun = (best_indexFun+1)*10;

      }

      if (sectorIndex == 4) {
        this.relationsRefRightX = this.relationsX[best_indexRelations];
        this.relationsRefRightY  = this.relationsY[best_indexRelations];
        this.relationsRefLeftX = this.relations1X[best_indexRelations];
        this.relationsRefLeftY = this.relations1Y[best_indexRelations];

        this.social_relations = (best_indexRelations+1)*10;

      }

      if (sectorIndex == 5) {
        this.organizationRefRightX = this.organizationX[best_indexOrganization];
        this.organizationRefRightY  =  this.organizationY[best_indexOrganization];
        this.organizationRefLeftX = this.cultureX[best_indexOrganization];
        this.organizationRefLeftY = this.cultureY[best_indexOrganization];

        this.organization = (best_indexOrganization+1)*10;

      }
    }
  }
}


class DrawingPainter extends CustomPainter {
  DrawingPainter({
    this.pointsList,
    this.cultureRefRightX,
    this.cultureRefRightY,
    this.cultureRefLeftX,
    this.cultureRefLeftY,

    this.workRefRightX,
    this.workRefRightY,
    this.workRefLeftX,
    this.workRefLeftY,

    this.healthRefRightX,
    this.healthRefRightY,
    this.healthRefLeftX,
    this.healthRefLeftY,

    this.funRefRightX,
    this.funRefRightY,
    this.funRefLeftX,
    this.funRefLeftY,

    this.relationsRefRightX,
    this.relationsRefRightY,
    this.relationsRefLeftX,
    this.relationsRefLeftY,

    this.organizationRefRightX,
    this.organizationRefRightY,
    this.organizationRefLeftX,
    this.organizationRefLeftY,

    this.axisCultureX,
    this.axisCultureY,
    this.axisWorkX,
    this.axisWorkY,
    this.axisWork1X,
    this.axisWork1Y,
    this.axisHelthX,
    this.axisHelthY,
    this.axisHelth1X,
    this.axisHelth1Y,
    this.axisFunX,
    this.axisFunY,
    this.axisRelationsX,
    this.axisRelationsY,
    this.axisRelations1X,
    this.axisRelations1Y,
    this.axisOrganizationX,
    this.axisOrganizationY,
    this.axisOrganization1X,
    this.axisOrganization1Y,

  this.radius, this.text, this.textStyle, this.initialAngle = 0,
  });
  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = List();

  var axisCultureX;
  var axisCultureY;
  var axisWorkX;
  var axisWorkY;
  var axisWork1X;
  var axisWork1Y;
  var axisHelthX;
  var axisHelthY;
  var axisHelth1X;
  var axisHelth1Y;
  var axisFunX;
  var axisFunY;
  var axisRelationsX;
  var axisRelationsY;
  var axisRelations1X;
  var axisRelations1Y;
  var axisOrganizationX;
  var axisOrganizationY;
  var axisOrganization1X;
  var axisOrganization1Y;

  var workRefRightX;
  var workRefRightY;
  var workRefLeftX;
  var workRefLeftY;

  var cultureRefRightX;
  var cultureRefRightY;
  var cultureRefLeftX;
  var cultureRefLeftY;

  var healthRefRightX;
  var healthRefRightY;
  var healthRefLeftX;
  var healthRefLeftY;

  var funRefRightX;
  var funRefRightY;
  var funRefLeftX;
  var funRefLeftY;

  var relationsRefRightX;
  var relationsRefRightY;
  var relationsRefLeftX;
  var relationsRefLeftY;

  var organizationRefRightX;
  var organizationRefRightY;
  var organizationRefLeftX;
  var organizationRefLeftY;


  final num radius;
  final String text;
  final double initialAngle;
  final TextStyle textStyle;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {

    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisCultureX, size.height / 2),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10);

    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisWorkX,
            this.axisWorkY), Paint()
          ..color = Colors.black
          ..strokeWidth = 10);

    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisWork1X,
            this.axisWork1Y), Paint()
          ..color = Colors.black
          ..strokeWidth = 10);


    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisHelthX,
            this.axisHelthY), Paint()
          ..color = Colors.black
          ..strokeWidth = 10);

    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisHelth1X,
            this.axisHelth1Y), Paint()
          ..color = Colors.black
          ..strokeWidth = 10);

    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisFunX, size.height / 2),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10);

    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisRelationsX, this.axisRelationsY),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10);

    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(this.axisOrganizationX, this.axisOrganizationY),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10);


    Path pathCulture = new Path();
    pathCulture.moveTo(size.width / 2, size.height / 2);
    pathCulture.lineTo(this.cultureRefRightX,
        this.cultureRefRightY);
    pathCulture.lineTo(this.cultureRefLeftX,
        this.cultureRefLeftY);

    canvas.drawPath(pathCulture, Paint()
      ..color = Colors.green);

    Path pathWork = new Path();
    pathWork.moveTo(size.width / 2, size.height / 2);
    pathWork.lineTo(this.workRefRightX,
        this.workRefRightY);
    pathWork.lineTo(this.workRefLeftX,
        this.workRefLeftY);

    canvas.drawPath(pathWork, Paint()
      ..color = Colors.pinkAccent);

    Path pathHealth = new Path();
    pathHealth.moveTo(size.width / 2, size.height / 2);
    pathHealth.lineTo(this.healthRefRightX,
        this.healthRefRightY);
    pathHealth.lineTo(this.healthRefLeftX,
        this.healthRefLeftY);

    canvas.drawPath(pathHealth, Paint()
      ..color = Colors.lightBlueAccent);

    Path pathFun = new Path();
    pathFun.moveTo(size.width / 2, size.height / 2);
    pathFun.lineTo(this.funRefRightX,
        this.funRefRightY);
    pathFun.lineTo(this.funRefLeftX,
        this.funRefLeftY);

    canvas.drawPath(pathFun, Paint()
      ..color = Colors.yellow);

    Path pathRelations = new Path();
    pathRelations.moveTo(size.width / 2, size.height / 2);
    pathRelations.lineTo(this.relationsRefRightX,
        this.relationsRefRightY);
    pathRelations.lineTo(this.relationsRefLeftX,
        this.relationsRefLeftY);

    canvas.drawPath(pathRelations, Paint()
      ..color = Colors.purpleAccent);


    Path pathOrganization = new Path();
    pathOrganization.moveTo(size.width / 2, size.height / 2);
    pathOrganization.lineTo(this.organizationRefRightX,
        this.organizationRefRightY);
    pathOrganization.lineTo(this.organizationRefLeftX,
        this.organizationRefLeftY);

    canvas.drawPath(pathOrganization, Paint()
      ..color = Colors.deepOrange);


    canvas.translate(size.width / 2, size.height / 2 - radius);

    if (initialAngle != 0) {
      final d = 2 * radius * math.sin(initialAngle / 2);
      final rotationAngle = _calculateRotationAngle(0, initialAngle);
      canvas.rotate(rotationAngle);
      canvas.translate(d, 0);
    }

    double angle = initialAngle;
    for (int i = 0; i < text.length; i++) {
      angle = _drawLetter(canvas, text[i], angle);
    }
    }

  double _drawLetter(Canvas canvas, String letter, double prevAngle) {
    _textPainter.text = TextSpan(text: letter, style: textStyle);
    _textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

    final double d = _textPainter.width;
    final double alpha = 2 * math.asin(d / (2 * radius));

    final newAngle = _calculateRotationAngle(prevAngle, alpha);
    canvas.rotate(newAngle);

    _textPainter.paint(canvas, Offset(0, -_textPainter.height));
    canvas.translate(d, 0);

    return alpha;
  }
  double _calculateRotationAngle(double prevAngle, double alpha) =>
      (alpha + prevAngle) / 2;



  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint paint;
  Offset points;
  DrawingPoints({this.points, this.paint});
}

enum SelectedMode { StrokeWidth, Opacity, Color }

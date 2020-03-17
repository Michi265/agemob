import 'package:agemob/Pages/midTermPointer.dart';
import 'package:flutter/material.dart';

class MidTerm extends StatefulWidget {
  final double width;
  final double height;
  final Color color;

  const MidTerm({
    this.width = 300.0,
    this.height = 50.0,
    this.color = Colors.black,
  });
  @override
  _MidTermState createState() => _MidTermState();
}

class _MidTermState extends State<MidTerm> {

  double _dragPosition = 0;
  double _dragPercentage = 0;

  void _updateDragPosition(Offset val){
   double newDragPosition = 0;

   if(val.dx <= 0){
     newDragPosition = 0;
   }else if (val.dx >= widget.width){
     newDragPosition = widget.width;
   }else{
     newDragPosition = val.dx;
   }

   setState(() {
     _dragPosition = newDragPosition;
     _dragPercentage = _dragPosition/ widget.width;
   });

  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update){
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(update.globalPosition);
    _updateDragPosition(offset);
  }
  void _onDragStart(BuildContext context, DragStartDetails start){
    RenderBox box = context.findRenderObject();
    Offset localOffset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(localOffset);
  }
  void _onDragEnd(BuildContext context, DragEndDetails end){
    setState(() {
    });
  }


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
      body:  Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
            child: GestureDetector(
              child: Container(
                width: widget.width,
                height: widget.height,
                //qui c'era il colore rosso quindi probabilmente quelli
                //sopra sono i parametri per creare il rettangolo e te farai un triangolo
                child: CustomPaint(
                  painter: MidTermPointer(
                    color: widget.color,
                    dragPercentage: _dragPercentage,
                    sliderPosition: _dragPosition,
                  ),
                ),
              ),
              onHorizontalDragUpdate: (DragUpdateDetails update) =>
                  _onDragUpdate(context, update),
              onHorizontalDragStart: (DragStartDetails start) =>
                  _onDragStart(context, start),
              onHorizontalDragEnd: (DragEndDetails end) =>
                  _onDragEnd(context, end),
            ),
          ),
        ),
      );


  }
}

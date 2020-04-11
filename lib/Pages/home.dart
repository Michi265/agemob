import 'package:agemob/Setup/size_config.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agemob/Pages/cameraState.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'midTerm.dart';


class MyData{
  String _title, _body;
  bool _expanded;
  IconData icon;


  MyData(this._title,this.icon, this._body, this._expanded);
  @override
  String toString() {
    return 'MyData{_title: $_title,_icon: $icon, _body: $_body, _expanded: $_expanded}';
  }

  bool get expanded => _expanded;
  set expanded(bool value){
    _expanded = value;
  }

  get body => _body;
  set body(value){
    _body = value;
  }
  set title(String value){
    _title = value;
  }
}

class Home extends StatefulWidget{

  String project, country, destination, date, student,documentReferenceProject;

  Home({Key key,this.project, this.country, this.destination, this.date, this.student,
  }): super(key: key);
  @override
  _HomeState createState() => _HomeState([
    MyData("Step 1: Documents ", Icons.check, "bo", false),
    MyData("Step 2: OLS test ",Icons.check,"fkfjdb", false),
    MyData("Step 3: Tickets ",Icons.check,"fkfjdb", false),
    MyData("Step 4: Mid-term check ",Icons.check,"fkfjdb", false),
    MyData("Step 5: final check ",Icons.check,"fkfjdb", false),
    MyData("Step 6: Tickets ",Icons.check,"fkfjdb", false),
    MyData("Step 7: OLS test ",Icons.check,"fkfjdb", false),
    MyData("Step 8: Final report ",Icons.check,"fkfjdb", false),

  ]);

}

class _HomeState extends State<Home> {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => checkColors());
    //checkColors();
  }

  List<MyData> _list;
  List<Color> listColor = new List(8);
  List<Color> listIconColor = new List(8);

  _HomeState(this._list);
  String ols1 = 'yellow';
  final databaseReference = Firestore.instance;
  final Firestore firestore = Firestore.instance;

  bool changeColorOls1 = false;
  bool changeTextOls1 = false;
  bool changeColorOls2 = false;
  bool changeTextOls2 = false;
  bool changeColorReport = false;
  bool changeTextReport = false;



  int getColorHexFromStr(String colorStr){
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for(int i = 0; i< len; i++){
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }


    return val;

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    checkColors();
    List<ExpansionPanel> myList0 = [];
    List<ExpansionPanel> myList1 = [];
    List<ExpansionPanel> myList2 = [];
    List<ExpansionPanel> myList3 = [];
    List<ExpansionPanel> myList4 = [];
    List<ExpansionPanel> myList5 = [];
    List<ExpansionPanel> myList6 = [];
    List<ExpansionPanel> myList7 = [];

   //listColor[0] = Colors.green;


    //checkColors();
    var expansionDataDocument = _list[0];
    myList0.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
              children: <Widget>[
                Text(expansionDataDocument._title,
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),),

                  Icon(expansionDataDocument.icon, color: listIconColor[0],),
                ],
          ),);
        },
        body: Column(
            children: <Widget>[
              Text('Upload photos of your identity card.', style: TextStyle(fontSize: 18.0),),
              Text(''),
              RaisedButton(
                onPressed: uploadDocument,
                child: Text('Upload document',style: TextStyle(fontSize: 16.0,color: Colors.white)),color: Colors.red[900],)

        ],),
        isExpanded:(expansionDataDocument._expanded)));

    var expansionDataOls1 = _list[1];
    myList1.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                Text(expansionDataOls1._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),),
                Icon(expansionDataOls1.icon,color: listIconColor[1])
              ],
          ));},

        body: Column(
          children: <Widget>[
          Text(' You have received the login credentials for the '+' '+' OLS platform in your inbox.', style: TextStyle(fontSize: 18.0),textAlign: TextAlign.left,),
            Text(''),
          Text(' Use them to complete the test.', style: TextStyle(fontSize: 18.0)),
          Text(''),
          Text(' Once you have done the test, click the button below to allow the operator to verify that everything is ok and upload your flight tickets.', style: TextStyle(fontSize: 18.0),),
          Text(''),
          RaisedButton(

            child:changeTextOls1? Text('Submitted',
            style: TextStyle(fontSize: 16.0, color: Colors.white)):Text('Submitt',
            style: TextStyle(fontSize: 16.0,color: Colors.white)),
            onPressed: uploadOls1,
            color: changeColorOls1? Colors.grey[800]:Colors.red[900],

          ),],),
        isExpanded:(expansionDataOls1._expanded)));

    var expansionDataDownloadTickets = _list[2];

    myList2.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Text(expansionDataDownloadTickets._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),),
                Icon(expansionDataDownloadTickets.icon,color: listIconColor[2])
              ],
            ),);
        },
        body:Column(
          children: <Widget>[
          Text(' Click the button below to download your flight tickets.', style: TextStyle(fontSize: 18.0),textAlign: TextAlign.left,),
          Text(''),
          RaisedButton(
            onPressed: downloadTickets,
            child: Text('Download tickets',style: TextStyle(fontSize: 16.0,color: Colors.white)),color: Colors.red[900],),],),
        isExpanded: expansionDataDownloadTickets._expanded));

    var expansionDataMidTermCheck = _list[3];
    myList3.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Text(expansionDataMidTermCheck._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),),
                Icon(expansionDataMidTermCheck.icon,color: listIconColor[3])
              ],
            ),);
        },
        body: Column(
          children: <Widget>[
          Text(' Click the button below to be able to fill your "internship wheel" and give us feedback on your experience. ', style: TextStyle(fontSize: 18.0),textAlign: TextAlign.left,),
          Text(''),
          RaisedButton(
            onPressed: uploadMidTermCheck,
            child: Text('Upload Mid-Term check',style: TextStyle(fontSize: 16.0,color: Colors.white)),color: Colors.red[900],),],),
        isExpanded: expansionDataMidTermCheck._expanded));

    var expansionDataFinalCheck = _list[4];
    myList4.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Text(expansionDataFinalCheck._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),),
                Icon(expansionDataFinalCheck.icon,color: listIconColor[4])
              ],
            ),);
        },
        body: Column(
          children: <Widget>[
          Text(' Click the button below to be able to fill your "internship wheel" and give us feedback on your experience. ', style: TextStyle(fontSize: 18.0),textAlign: TextAlign.left,),
          Text(''),
          RaisedButton(
            onPressed: uploadFinalCheck,
            child: Text('Upload final check',style: TextStyle(fontSize: 16.0,color: Colors.white)),color: Colors.red[900],),],),
        isExpanded: expansionDataFinalCheck._expanded));


    var expansionDataDownloadTicketsR = _list[5];
    myList5.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Text(expansionDataDownloadTicketsR._title,
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),),
                  Icon(expansionDataDownloadTicketsR.icon,color: listIconColor[5])
                ],
              ),);
        },
        body:  Column(
          children: <Widget>[
          Text(' Click the button below to download your flight tickets.', style: TextStyle(fontSize: 18.0),textAlign: TextAlign.left,),
          Text(''),
          RaisedButton(
            onPressed: downloadTicketsR,
            child: Text('Download tickets',style: TextStyle(fontSize: 16.0,color: Colors.white)),color: Colors.red[900],),],),
        isExpanded: expansionDataDownloadTicketsR._expanded));


    var expansionDataOls2 = _list[6];
    myList6.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Text(expansionDataOls2._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),),
                Icon(expansionDataOls2.icon,color: listIconColor[6])
              ],
            ),);
        },
        body:Column(
          children: <Widget>[
        Text(' You have received the login credentials for the '+' '+' OLS platform in your inbox.', style: TextStyle(fontSize: 18.0),textAlign: TextAlign.left,),
        Text(''),
        Text(' Use them to complete the test.', style: TextStyle(fontSize: 18.0)),
        Text(''),
        Text(' Once you have done the test, click the button below to allow the operator to verify that everything is ok and upload your flight tickets.', style: TextStyle(fontSize: 18.0),),
        Text(''),
        RaisedButton(

          child:changeTextOls2? Text('Submitted',
              style: TextStyle(fontSize:16.0,color: Colors.white)):Text('Submitt',
              style: TextStyle(fontSize:16.0,color: Colors.white)),
          onPressed: uploadOls2,
          color: changeColorOls2? Colors.grey[800]:Colors.red[900],
        ),],),
        isExpanded: expansionDataOls2._expanded));


    var expansionDataReport = _list[7];
    myList7.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Text(expansionDataReport._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),),
                Icon(expansionDataReport.icon,color: listIconColor[7])
              ],
            ),);
        },
        body: Column(
          children: <Widget>[
        Text(' You have received the login credentials for the '+' '+' Erasmus platform in your inbox.', style: TextStyle(fontSize: 18.0),textAlign: TextAlign.left,),
        Text(''),
        Text(' Use them to complete the final report on your experience.', style: TextStyle(fontSize: 18.0)),
        Text(''),
        Text('  Once you have complete the report, click the button below to allow the operator to verify that everything is ok.', style: TextStyle(fontSize: 18.0),),
        Text(''),
        RaisedButton(

          child:changeTextReport? Text('Submitted',
              style: TextStyle(fontSize:16.0,color: Colors.white)):Text('Submitt',
              style: TextStyle(fontSize:16.0,color: Colors.white)),
          onPressed: report,
          color: changeColorReport? Colors.grey[800]:Colors.red[900],
        ),],),
        isExpanded: expansionDataReport._expanded));

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
              ),],),),

        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      width: double.infinity,
                      color: Color(getColorHexFromStr('#FFB71C1C')),
                    ),
                    Positioned(
                      bottom: 50.0,
                      right: 100.0,
                      child: Container(
                        height: 400.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Color(getColorHexFromStr('#FFD32F2F')).withOpacity(0.4),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 100.0,
                      left: 150.0,
                      child: Container(
                        height: 300.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: Color(getColorHexFromStr('#FFD32F2F')).withOpacity(0.5),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 30.0),
                            Container(
                              alignment: Alignment.topLeft,
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                image: DecorationImage(
                                    image: AssetImage('assets/user.png')),),
                            ),
                            SizedBox(height: 50.0),
                            Padding(
                              padding: EdgeInsets.only(left:15.0),
                              child: Text(widget.student.toString(),
                                style: TextStyle(
                                    fontFamily: 'QuickSand',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 50.0),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Column(
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.all(4.0),
                              child: Theme(
                                data: ThemeData(
                                  cardColor: listColor[0],
                                ),
                                child:new ExpansionPanelList(
                                  children: myList0,
                                  expansionCallback: (int index, bool isExpanded) {
                                  setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                  if (datasnapshot.exists) {
                                  setState(() {
                                  if((datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted')) {
                                  _list[0].expanded = (_list[0].expanded);
                                  _list[0].icon = Icons.check;
                                  }else{
                                    _list[0].expanded = !(_list[0].expanded);
                                  }
                                  });
                                  };});});},),),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: Theme(
                            data: ThemeData(
                            cardColor: listColor[1],
                            ),
                            child: new ExpansionPanelList(
                              children: myList1,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                  if (datasnapshot.exists) {
                                    setState(() {
                                    if(datasnapshot.data['ols1'].toString()== 'lightgreen') {
                                      _list[1].expanded = (_list[1].expanded);
                                      _list[1].icon = Icons.check;
                                      }else{
                                        _list[1].expanded = !(_list[1].expanded);
                                    }
                                });
                              };});});},),),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: Theme(
                            data: ThemeData(
                            cardColor: listColor[2],
                            ),
                            child:new ExpansionPanelList(
                              children: myList2,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if((datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted')&& datasnapshot.data['ols1'].toString()== 'lightgreen' && datasnapshot.data['departureTicket']=='Uploaded') {
                                          _list[2].expanded = !(_list[2].expanded);
                                          _list[2].icon = Icons.check;
                                        }else{
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
                                                                hintText: 'Please done the previous steps!'),
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
                                                );
                                              },);
                                            };
                                        },);
                                      };},);
                                  },);
                              },),),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: Theme(
                            data: ThemeData(
                            cardColor: listColor[3],
                            ),
                            child: new ExpansionPanelList(
                              children: myList3,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['midTerm']== 'lightgreen'&& isExpanded){
                                          _list[3].expanded = (_list[3].expanded);
                                          _list[3].icon = Icons.check;
                                        }
                                        if((datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted')&& datasnapshot.data['ols1'].toString()== 'lightgreen' && datasnapshot.data['midTerm']!= 'lightgreen'&& datasnapshot.data['departureTicket']=='Uploaded') {
                                          _list[3].expanded = !(_list[3].expanded);
                                        }else if ((datasnapshot.data['front'].toString() != 'accepted' || datasnapshot.data['back'].toString() != 'accepted') || datasnapshot.data['ols1'].toString() != 'lightgreen' || datasnapshot.data['departureTicket']!='Uploaded'){
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
                                                              hintText: 'Please done the previous steps!'),
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
                                              );
                                            },);
                                        };

                                      },);
                                    };},);
                                },);
                              },),),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: Theme(
                            data: ThemeData(
                            cardColor: listColor[4],
                            ),
                            child: new ExpansionPanelList(
                              children: myList4,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['finalTerm']== 'lightgreen'&& isExpanded){
                                          _list[4].expanded = (_list[4].expanded);
                                          _list[4].icon = Icons.check;
                                        }
                                        if((datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted')&& datasnapshot.data['ols1'].toString()== 'lightgreen' && datasnapshot.data['finalTerm']!= 'lightgreen'&& datasnapshot.data['departureTicket']=='Uploaded') {
                                          _list[4].expanded = !(_list[4].expanded);
                                        }else if ((datasnapshot.data['front'].toString() != 'accepted' || datasnapshot.data['back'].toString() != 'accepted')|| datasnapshot.data['ols1'].toString() != 'lightgreen' || datasnapshot.data['departureTicket']!= 'Uploaded'){
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
                                                              hintText: 'Please done the previous steps!'),
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
                                              );
                                            },);
                                        };
                                      },);
                                    };},);
                                },);
                              },),),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: Theme(
                            data: ThemeData(
                            cardColor: listColor[5],
                            ),
                            child: new ExpansionPanelList(
                              children: myList5,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['midTerm'].toString()=='lightgreen' && datasnapshot.data['finalTerm'].toString()=='lightgreen' && datasnapshot.data['returnTicket'] == 'Uploaded') {
                                          _list[5].expanded = !(_list[5].expanded);
                                        }else if(datasnapshot.data['midTerm'].toString() !='lightgreen' && datasnapshot.data['finalTerm'].toString() !='lightgreen'){
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
                                                              hintText: 'Please done the previous steps!'),
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
                                              );
                                            },);
                                        };
                                      },);
                                    };},);
                                },);
                              },),),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: Theme(
                            data: ThemeData(
                            cardColor: listColor[6],
                            ),
                            child: new ExpansionPanelList(
                              children: myList6,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['midTerm'].toString()=='lightgreen' && datasnapshot.data['finalTerm'].toString()=='lightgreen') {
                                          _list[6].expanded = !(_list[6].expanded);
                                          _list[6].icon = Icons.check;
                                        }else if (datasnapshot.data['midTerm'].toString() !='lightgreen' && datasnapshot.data['finalTerm'].toString() !='lightgreen'){
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
                                                              hintText: 'Please done the previous steps!'),
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
                                              );
                                            },);
                                        };
                                      },);
                                    };},);
                                },);
                              },),),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: Theme(
                            data: ThemeData(
                            cardColor: listColor[7],
                            ),
                            child: new ExpansionPanelList(

                              children: myList7,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['midTerm'].toString()=='lightgreen' && datasnapshot.data['finalTerm'].toString()=='lightgreen') {
                                          _list[7].expanded = !(_list[7].expanded);
                                          _list[7].icon = Icons.check;
                                        }else{
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
                                                              hintText: 'Please done the previous steps!'),
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
                                              );
                                            },);
                                        };
                                      },);
                                    };},);
                                },);
                              },),),),
                        ]
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
    );
  }

  Future<void> uploadDocument() async {
    DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CameraState(project: widget.project.toString(), country: widget.country.toString(), destination: widget.destination.toString(), date: widget.date.toString(), student: widget.student.toString(), documentReferenceProject: widget.documentReferenceProject.toString())));
  }

  Future<void> uploadOls1() async {
    setState(() {
      changeColorOls1 = !changeColorOls1;
      changeTextOls1 = !changeTextOls1;
      deactivate();
    });

    DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
    documentReferenceProject.updateData({'ols1': "yellow"});

  }

  Future<void> downloadTickets() async {
    DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString()).collection('tickets').document('departure');
    documentReferenceProject.get().then((datasnapshot) async {
      if (datasnapshot.exists) {
        var url = datasnapshot.data['downloadURL'];
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        print(datasnapshot.data['downloadURL']);
      }
  });

  }

  Future<void> uploadMidTermCheck() async {
    DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
    documentReferenceProject.get().then((datasnapshot) async {
      if (datasnapshot.exists){
        print(datasnapshot.data.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MidTerm(project: widget.project.toString(), country: widget.country.toString(), destination: widget.destination.toString(), date: widget.date.toString(), student: widget.student.toString(),midTerm: 'midTerm')));
      }
      else{
        print ('No such user');
      }
    }
    );
  }

  Future<void> uploadFinalCheck() async {
    DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
    documentReferenceProject.get().then((datasnapshot) async {
      if (datasnapshot.exists){
        print(datasnapshot.data.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MidTerm(project: widget.project.toString(), country: widget.country.toString(), destination: widget.destination.toString(), date: widget.date.toString(), student: widget.student.toString(),finalTerm: 'finalTerm')));
      }
      else{
        print ('No such user');
      }
    }
    );
  }

  Future<void> downloadTicketsR() async {
    DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString()).collection('tickets').document('return');
    documentReferenceProject.get().then((datasnapshot) async {
      if (datasnapshot.exists) {
        var url = datasnapshot.data['downloadURL'];
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        print(datasnapshot.data['downloadURL']);
      }
    });}

  Future<void> uploadOls2() async {

    setState(() {
      changeColorOls2 = !changeColorOls2;
      changeTextOls2 = !changeTextOls2;
      deactivate();
    });

    DocumentReference documentReference = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
    documentReference.updateData({'ols2': "yellow"});
  }

  Future<void> report() async {

    setState(() {
      changeColorReport = !changeColorReport;
      changeTextReport = !changeTextReport;
      deactivate();
    });

    DocumentReference documentReference = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
    documentReference.updateData({'report': "yellow"});
  }



  checkColors() {
    //await Future.delayed(Duration(milliseconds: 1));
    DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
    documentReferenceProject.get().then((datasnapshot) async {
      if (datasnapshot.exists){
        if((datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted')&& datasnapshot.data['ols1'].toString() == 'lightgreen'&& datasnapshot.data['departureTicket']=='Uploaded') {
          listColor[2] = Colors.white;
        } else{
          listColor[2] = Colors.grey;
        }
        if((datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted')&& datasnapshot.data['ols1'].toString()== 'lightgreen'&& datasnapshot.data['departureTicket']=='Uploaded') {
          listColor[3] = Colors.white;
        } else{
          listColor[3] = Colors.grey;
        }
        if((datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted')&& datasnapshot.data['ols1'].toString()== 'lightgreen'&& datasnapshot.data['departureTicket']=='Uploaded') {
          listColor[4] = Colors.white;
        } else{
          listColor[4] = Colors.grey;
        }
        if(datasnapshot.data['midTerm'].toString()=='lightgreen' && datasnapshot.data['finalTerm'].toString()=='lightgreen'&& datasnapshot.data['returnTicket']== 'Uploaded'){
          listColor[5] = Colors.white;
        }else{
          listColor[5] = Colors.grey;
        }
        if(datasnapshot.data['midTerm'].toString()=='lightgreen' && datasnapshot.data['finalTerm'].toString()=='lightgreen'&& datasnapshot.data['returnTicket']== 'Uploaded'){
          listColor[6] = Colors.white;
        }else{
          listColor[6] = Colors.grey;
        }
        if(datasnapshot.data['midTerm'].toString()=='lightgreen' && datasnapshot.data['finalTerm'].toString()=='lightgreen'&& datasnapshot.data['returnTicket']== 'Uploaded'){
          listColor[7] = Colors.white;
        }else{
          listColor[7] = Colors.grey;
        }

        listIconColor[0] = Colors.white;
        if(datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted') {
          listIconColor[0] = Colors.green;
        } else{

        }
        listIconColor[1] = Colors.white;
        if(datasnapshot.data['ols1'].toString() == 'lightgreen') {
          listIconColor[1] = Colors.green;
        } else{

        }
        listIconColor[2] = Colors.grey;
        if (datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted' && datasnapshot.data['departureTicket']== 'Uploaded') {
          listIconColor[2] = Colors.green;
        } else{

        }
        listIconColor[3] = Colors.grey;
        if(datasnapshot.data['midTerm'].toString() == 'lightgreen') {
          listIconColor[3] = Colors.green;
        } else if (datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted' && datasnapshot.data['departureTicket']== 'Uploaded'){
          listIconColor[3] = Colors.white;
        }

        listIconColor[4] = Colors.grey;
        if(datasnapshot.data['finalTerm'].toString() == 'lightgreen') {
          listIconColor[4] = Colors.green;
        } else if (datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted' && datasnapshot.data['departureTicket']== 'Uploaded'){
          listIconColor[4] = Colors.white;
        }

        listIconColor[5] = Colors.grey;
        if(datasnapshot.data['returnTicket'].toString() == 'Uploaded') {
          listIconColor[5] = Colors.green;
        } else{

        }
        listIconColor[6] = Colors.grey;
        if(datasnapshot.data['ols2'].toString() == 'lightgreen'&& datasnapshot.data['returnTicket']== 'Uploaded') {
          listIconColor[6] = Colors.green;
        } else if (datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted' && datasnapshot.data['returnTicket']== 'Uploaded'){
          listIconColor[6] = Colors.white;
        }

        listIconColor[7] = Colors.grey;
        if(datasnapshot.data['report'].toString() == 'lightgreen'&& datasnapshot.data['returnTicket']== 'Uploaded') {
          listIconColor[7] = Colors.green;
        } else if (datasnapshot.data['front'].toString() == 'accepted' && datasnapshot.data['back'].toString() == 'accepted' && datasnapshot.data['returnTicket']== 'Uploaded'){
          listIconColor[7] = Colors.white;
        }
      }
    });
  }




}


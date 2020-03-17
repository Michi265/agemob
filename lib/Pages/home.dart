import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agemob/Pages/cameraState.dart';
import 'package:url_launcher/url_launcher.dart';

import 'midTerm.dart';


class MyData{
  String _title, _body;
  bool _expanded;

  MyData(this._title, this._body, this._expanded);
  @override
  String toString() {
    return 'MyData{_title: $_title, _body: $_body, _expanded: $_expanded}';
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

class Home extends StatefulWidget {

  String project, country, destination, date, student,documentReferenceProject;

  Home({this.project, this.country, this.destination, this.date, this.student});
  @override
  _HomeState createState() => _HomeState([
    MyData("Step 1: Documents","bo", false),
    MyData("Step 2: OLS test","fkfjdb", false),
    MyData("Step 3: Tickets","fkfjdb", false),
    MyData("Step 4: Mid-term check","fkfjdb", false),
    MyData("Step 5: final check","fkfjdb", false),
    MyData("Step 6: Tickets","fkfjdb", false),
    MyData("Step 7: OLS test","fkfjdb", false),
    MyData("Step 8: Final report","fkfjdb", false)
  ]);
}

class _HomeState extends State<Home> {
  List<MyData> _list;
  _HomeState(this._list);
  String ols1 = 'yellow';
  final databaseReference = Firestore.instance;
  final Firestore firestore = Firestore.instance;

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

    List<ExpansionPanel> myList0 = [];
    List<ExpansionPanel> myList1 = [];
    List<ExpansionPanel> myList2 = [];
    List<ExpansionPanel> myList3 = [];
    List<ExpansionPanel> myList4 = [];
    List<ExpansionPanel> myList5 = [];
    List<ExpansionPanel> myList6 = [];
    List<ExpansionPanel> myList7 = [];

    var expansionDataDocument = _list[0];
    myList0.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(expansionDataDocument._title,
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),));
        },
        body: RaisedButton(
          onPressed: uploadDocument,
          child: Text('Upload document'),

        ),
        isExpanded:(expansionDataDocument._expanded)));

    var expansionDataOls1 = _list[1];
    myList1.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(expansionDataOls1._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)));
        },
        body: RaisedButton(
            onPressed: uploadOls1,
            child: Text('Upload ols1')
        ),
        isExpanded:(expansionDataOls1._expanded)));

    var expansionDataDownloadTickets = _list[2];
    myList2.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(expansionDataDownloadTickets._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)));
        },
        body: RaisedButton(
          onPressed: downloadTickets,
          child: Text('Download tickets'),
        ),
        isExpanded: expansionDataDownloadTickets._expanded));

    var expansionDataMidTermCheck = _list[3];
    myList3.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(expansionDataMidTermCheck._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)));
        },
        body: RaisedButton(
          onPressed: uploadMidTermCheck,
          child: Text('Upload Mid-Term check'),
        ),
        isExpanded: expansionDataMidTermCheck._expanded));

    var expansionDataFinalCheck = _list[4];
    myList4.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(expansionDataFinalCheck._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)));
        },
        body: RaisedButton(
          onPressed: uploadFinalCheck,
          child: Text('Upload final check'),
        ),
        isExpanded: expansionDataFinalCheck._expanded));


    var expansionDataDownloadTicketsR = _list[5];
    myList5.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(expansionDataDownloadTicketsR._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)));
        },
        body: RaisedButton(
          onPressed: downloadTicketsR,
          child: Text('Download tickets'),
        ),
        isExpanded: expansionDataDownloadTicketsR._expanded));


    var expansionDataOls2 = _list[6];
    myList6.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(expansionDataOls2._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)));
        },
        body: RaisedButton(
          onPressed: uploadOls2,
          child: Text('Upload ols2'),
        ),
        isExpanded: expansionDataOls2._expanded));


    var expansionDataReport = _list[7];
    myList7.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(expansionDataReport._title,
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)));
        },
        body: RaisedButton(
          onPressed: report,
          child: Text('Report'),
        ),
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
                            child: new ExpansionPanelList(
                              children: myList0,
                              expansionCallback: (int index, bool isExpanded) {
                                  setState(() {
                                    _list[0].expanded = !(_list[0].expanded);
                                  });
                                  },),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: new ExpansionPanelList(
                              children: myList1,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  _list[1].expanded = !(_list[1].expanded);
                                });
                              },),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: new ExpansionPanelList(
                              children: myList2,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['document'].toString() == 'green' && datasnapshot.data['ols1'].toString()== 'green') {
                                        _list[2].expanded = !(_list[2].expanded);
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
                              },),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: new ExpansionPanelList(
                              children: myList3,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['document'].toString() == 'green' && datasnapshot.data['ols1'].toString()== 'green') {
                                          _list[3].expanded = !(_list[3].expanded);
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
                              },),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: new ExpansionPanelList(
                              children: myList4,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['document'].toString() == 'green' && datasnapshot.data['ols1'].toString()== 'green') {
                                          _list[4].expanded = !(_list[4].expanded);
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
                              },),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: new ExpansionPanelList(
                              children: myList5,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['returnTicket'].toString()=='Uploaded') {
                                          _list[5].expanded = !(_list[5].expanded);
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
                              },),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: new ExpansionPanelList(
                              children: myList6,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['returnTicket'].toString()=='Uploaded') {
                                          _list[6].expanded = !(_list[6].expanded);
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
                              },),),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: new ExpansionPanelList(
                              children: myList7,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
                                  documentReferenceProject.get().then((datasnapshot) {
                                    if (datasnapshot.exists) {
                                      setState(() {
                                        if(datasnapshot.data['returnTicket'].toString()=='Uploaded') {
                                          _list[7].expanded = !(_list[7].expanded);
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
                              },),),
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
  });}

  Future<void> uploadMidTermCheck() async {
    DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString()).collection('tickets').document('departure');
    documentReferenceProject.get().then((datasnapshot) async {
      if (datasnapshot.exists){
        print(datasnapshot.data.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MidTerm()));
      }
      else{
        print ('No such user');
      }
    }
    );
  }

  Future<void> uploadFinalCheck() async {
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
    DocumentReference documentReference = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString());
    documentReference.updateData({'ols2': "yellow"});
  }

  Future<void> report() async {

  }
}

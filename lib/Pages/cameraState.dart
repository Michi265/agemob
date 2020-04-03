import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';


class CameraState extends StatefulWidget{
  String project, country, destination, date, student,documentReferenceProject;

  CameraState({this.project, this.country, this.destination, this.date, this.student, this.documentReferenceProject});
  @override
  _CameraState createState() => _CameraState();

}

class _CameraState extends State<CameraState> {

  File _imageFront;
  File _imageBack;
  String _uploadedFileURL;
  String _uploadedFileBackURL;
  final Firestore firestore = Firestore.instance;
  String front;


  Future chooseFrontFile() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((imageFront) {
      setState(() {
        _imageFront = imageFront;
      });
    });
  }

  Future chooseBackFile() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((imageBack) {
      setState(() {
        _imageBack = imageBack;
      });
    });
  }

  Future uploadFrontFile() async {
    DocumentReference documentReferenceProject = firestore.collection(
        'projects').document(widget.project.toString()).collection('Countries')
        .document(widget.country.toString()).collection('Destinations')
        .document(widget.destination.toString()).collection('Date').document(
        widget.date.toString()).collection('Students').document(
        widget.student.toString()).collection('document')
        .document('front');

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('document').child(
        widget.student.toString() + '/${Path.basename(_imageFront.path)}}');

    StorageUploadTask uploadTask = storageReference.putFile(_imageFront);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        documentReferenceProject.setData({
          'downloadUrl': _uploadedFileURL,
          'path': _imageFront.path,
        });
      });
    });
  }

  Future uploadBackFile() async {
    DocumentReference documentReferenceProject = firestore.collection(
        'projects').document(widget.project.toString()).collection('Countries')
        .document(widget.country.toString()).collection('Destinations')
        .document(widget.destination.toString()).collection('Date').document(
        widget.date.toString()).collection('Students').document(
        widget.student.toString()).collection('document')
        .document('back');

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('document').child(
        widget.student.toString() + '/${Path.basename(_imageBack.path)}}');

    StorageUploadTask uploadTask = storageReference.putFile(_imageBack);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURLBack) {
      setState(() {
        _uploadedFileBackURL = fileURLBack;
        documentReferenceProject.setData({
          'downloadUrl': _uploadedFileBackURL,
          'path': _imageBack.path,
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Firestore File Upload'),
        ),
        body:
        Column(
          children: <Widget>[
            Container(height:  MediaQuery.of(context).size.height* 0.05,
              width: MediaQuery.of(context).size.width* 0.08,),
            Text('Upload photos of your identity card',
              style: TextStyle(fontSize: 20.0),),
        Row(
          children: <Widget>[
            Container(height: MediaQuery.of(context).size.height* 0.2,
              width: MediaQuery.of(context).size.width* 0.08,),
         RaisedButton(
              child: Text('Choose front file',
                  style: TextStyle(color: Colors.white)),
              onPressed: chooseFrontFile,
              color: Colors.red[900],
            ) ,

            Container( width: MediaQuery.of(context).size.width*0.1,
            ),
            RaisedButton(
              child: Text('Choose back file',
                  style: TextStyle(color: Colors.white)),
              onPressed: chooseBackFile,
              color: Colors.red[900],
            ),
    ],),
            Row(
              children: <Widget>[
                Container(height: MediaQuery.of(context).size.height *0.3,
                  width: MediaQuery.of(context).size.width*0.02,),
                _imageFront != null
                    ? Image.asset(
                  _imageFront.path,
                  height: MediaQuery.of(context).size.height *0.3,
                  width: MediaQuery.of(context).size.width*0.5,
                )
                    : Container(),
                Container(height:MediaQuery.of(context).size.height *0.3,
                  width: MediaQuery.of(context).size.width*0.01,),
                _imageBack != null
                    ? Image.asset(
                  _imageBack.path,
                  height: MediaQuery.of(context).size.height *0.3,
                )
                    : Container(),

              ],),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.15),
                _imageFront != null
                    ? RaisedButton(
                  child: Text('Upload File',
                      style: TextStyle(color: Colors.white)),
                  onPressed: uploadFrontFile,
                  color: Colors.red[900],
                )
                    : Container(),
                Container( height: MediaQuery.of(context).size.height *0.1,
                  width:  MediaQuery.of(context).size.height *0.1),
                _imageBack != null
                    ? RaisedButton(
                  child: Text('Upload File',
                      style: TextStyle(color: Colors.white)),
                  onPressed: uploadBackFile,
                  color: Colors.red[900],
                )
                    : Container(),
              ],),
            Row(
              children: <Widget>[
                Container(  width: MediaQuery.of(context).size.width*0.08),
                _uploadedFileURL != null
                    ? Text('File is uploaded',style: TextStyle(fontSize: 20),)
                : Container(),
                Container( width: MediaQuery.of(context).size.width*0.12),
                _uploadedFileBackURL != null
                    ? Text('File is uploaded',style: TextStyle(fontSize: 20),)
                    : Container(),
                /*Image.network(
                  _uploadedFileURL,
                  height: 150,
                )
                    : Container(),

                _uploadedFileBackURL != null
                    ? Image.network(
                  _uploadedFileBackURL,
                  height: 150,
                )
                    : Container(),
              */],)
          ],
        )


      /*     Column(
        children: <Widget>[

          Text('Uploaded Image...'),
          _uploadedFileURL != null
              ? Image.network(
            _uploadedFileURL,
            height: 150,
          )
              : Container(),
        ],),*/
    );
  }
}

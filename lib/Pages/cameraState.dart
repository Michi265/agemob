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

  File _image;
  String _uploadedFileURL;
  final Firestore firestore = Firestore.instance;
  String front;

  
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {

    DocumentReference documentReferenceProject = firestore.collection('projects').document(widget.project.toString()).collection('Countries').document(widget.country.toString()).collection('Destinations').document(widget.destination.toString()).collection('Date').document(widget.date.toString()).collection('Students').document(widget.student.toString()).collection('document').document('front');


    
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('document').child(widget.student.toString()+'/${Path.basename(_image.path)}}');

    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        documentReferenceProject.setData({
          'downloadUrl': _uploadedFileURL,
          'path':_image.path,
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
      body: Center(
        child: Column(
          children: <Widget>[
            Text(''),
            _image != null
                ? Image.asset(
              _image.path,
              height: 150,
            )
                : Container(height: 150),
            _image == null
                ? RaisedButton(
              child: Text('Choose File',
                  style: TextStyle(color: Colors.white)),
              onPressed: chooseFile,
              color: Colors.red[900],
            )
                : Container(),
            _image != null
                ? RaisedButton(
              child: Text('Upload File',
                style: TextStyle(color: Colors.white)),
              onPressed: uploadFile,
              color: Colors.red[900],
            )
                : Container(),
            _image != null
                ? RaisedButton(
                child: Text('Clear Selection' ,
                    style: TextStyle(color: Colors.white)),
            )
                : Container(),
            Text('Uploaded Image...'),
            _uploadedFileURL != null
                ? Image.network(
              _uploadedFileURL,
              height: 150,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
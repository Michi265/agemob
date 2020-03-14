import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;


class CameraState extends StatefulWidget{
  @override
  _CameraState createState() => _CameraState();

}

class _CameraState extends State<CameraState> {

  File _image;
  String _uploadedFileURL;


  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('documents/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
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
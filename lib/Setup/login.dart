import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agemob/Pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';


enum AuthMode {Login}

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final databaseReference = Firestore.instance;
  final Firestore firestore = Firestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _email, _password;
  String project, country, destination, date, student;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool _validate = false;
  var emailField;
  bool valore = true;
//&& EmailValidator.validate(input , true)
  @override
  Widget build(BuildContext context) {

            this.emailField = TextFormField(
            autofocus: false,
            obscureText: false,
            style: style,
              validator: (input) => valore
                  ? null
                  :'Not a valid email.',
            onSaved: (input) => _email = input,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Email",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
          ),

          );

          final passwordField = TextFormField(
            obscureText: true,
            style: style,
            validator: (val) =>
            val.length < 4 ? 'Password too short..' : null,
            onSaved: (input) => _password = input,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Password",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              )
          ),
          );

          final loginButon = RaisedButton(
            padding: EdgeInsets.all(18.0),
            onPressed: signIn,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red[900])),
            color: Colors.red[900],
            textColor: Colors.white,
            child: Text("Log In".toUpperCase(),
                style: TextStyle(fontSize: 16)),
          );


    return Scaffold(
      body: Form(
        key: _formKey,
          child: new SingleChildScrollView(
             child: Container(
              color: Colors.white,
               child: Padding(
                 padding: const EdgeInsets.all(80.0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 150.0,
                        child: Image.asset(
                          "assets/icon.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 60.0),
                      this.emailField,
                      SizedBox(height: 25.0),
                      passwordField,
                      SizedBox(
                        height: 35.0,
                      ),
                      loginButon,
                      SizedBox( width: 200.0,height: 100.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
}

  void changeVal(){
    this.valore = false;
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (true) {
      formState.save();
      try {
        this.valore = true;
        AuthResult result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email.replaceAll(' ', ''), password: _password);
        this.valore = true;
        FirebaseUser user = result.user;
        final uid = user.uid;
        print(uid);

        DocumentReference documentReferenceUser = firestore.collection('users').document(uid);
        documentReferenceUser.get().then((datasnapshot){
          if (datasnapshot.exists){

            project = datasnapshot.data['project'].toString();
            country = datasnapshot.data['country'].toString();
            destination = datasnapshot.data['destination'].toString();
            date = datasnapshot.data['date'].toString();
            student = datasnapshot.data['student'].toString();
            print(project);

            DocumentReference documentReferenceProject = firestore.collection('projects').document(project).collection('Countries').document(country).collection('Destinations').document(destination).collection('Date').document(date).collection('Students').document(student);

            documentReferenceProject.get().then((datasnapshot){
              if (datasnapshot.exists){
                print(datasnapshot.data.toString());
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home(project: project, country: country, destination: destination, date: date, student: student,
                )));
              }
              else{
                print ('No such user');
              }
            }
            );
          } else{
            print ('No such user');
          }
        }
        );

        var token = _getToken(uid);

      } catch (e) {
       print(e.message);
       changeVal();
       formState.validate();
       }
       finally {

        formState.validate();
      }
      }
    }


  void getData() async {
    var b = databaseReference.collection("users").getDocuments().then((
        QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  _getToken(uid) {
    _firebaseMessaging.getToken().then((deviceToken) {
      print('Device Token: $deviceToken');
      firestore.collection('users').document(uid).updateData({'deviceToken': deviceToken});
    });

  }



}
import 'package:agemob/Setup/login.dart';
import 'package:agemob/Setup/size_config.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgeMob User',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: LoginPage(),
    );

  }
}



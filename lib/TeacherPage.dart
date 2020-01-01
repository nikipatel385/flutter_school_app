import 'package:flutter/material.dart';

class TeacherPage extends StatefulWidget {
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Parents App'),
        ),
        body: Center(
          child: Text('Hello Teacher'),
        ),
      ),
    );
  }
}

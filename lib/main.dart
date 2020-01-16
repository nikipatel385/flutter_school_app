import 'package:flutter/material.dart';

import 'Home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MyApp',
    home: Home(),
    theme: ThemeData(primaryColor: Colors.lightBlue,accentColor: Colors.lightBlueAccent),
  ));
}

import 'package:flutter/material.dart';
import 'package:flutter_school/LoginPage.dart';

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
          title: Text('Teacher App'),
        ),
        body: Center(
          child: Text('Hello Teacher'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Niki Patel'),
                accountEmail: Text('nikipatel385@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    'N',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ),
              ListTile(
                title: Text('Setting'),
                trailing: const Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                title: Text("Log Out"),
                trailing: const Icon(Icons.power_settings_new),
                onTap: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return LoginPage();
                })),
              )
            ],
          ),
        ),
      ),
    );
  }
}

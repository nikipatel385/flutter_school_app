import 'package:flutter/material.dart';

import 'package:flutter_school/ParentsPage.dart';

import 'package:flutter_school/TeacherPage.dart';

import 'package:flutter_school/AdminPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _loginName = ['Teacher', 'Parents', 'Admin'];

  var _currentItemSelected = 'Admin';

  TextEditingController nameController = TextEditingController();

  TextEditingController pswdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: ListView(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                  ),
                  Image.network(
                      'http:\/\/172.16.17.141\/mmiserp\/assets\/logo.png',
                      height: 100.0,
                      width: 100.0),

                  Padding(
                    padding: EdgeInsets.only(bottom: 80.0),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person_pin),
                      hintText: 'Enter Your User Name',
                      labelText: 'User Name',
                    ),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter User Name';
                      }
                    },
                  ),
                  TextFormField(
                    controller: pswdController,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock),
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                    ),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Password';
                      }
                    },
                  ),
                  FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          hintText: "Login As",
                          icon: const Icon(Icons.perm_identity),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            items: _loginName.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _currentItemSelected,
                            onChanged: (String newValueSelected) {
                              _onDropDownItemSelected(newValueSelected);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 40.0),
                    margin: EdgeInsets.only(left: 100.0, right: 100.0),
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_currentItemSelected == 'Teacher') {
                          if (_formKey.currentState.validate()) {
                            var route = MaterialPageRoute(
                              builder: (BuildContext context) => TeacherPage(),
                            );

                            Navigator.of(context).push(route);
                          }
                        } else if (_currentItemSelected == 'Parents') {
                          if (_formKey.currentState.validate()) {
                            var route = MaterialPageRoute(
                              builder: (BuildContext context) => ParentsPage(),
                            );

                            Navigator.of(context).push(route);
                          }
                        } else if (_currentItemSelected == 'Admin') {
                          if (_formKey.currentState.validate()) {
                            var route = MaterialPageRoute(
                              builder: (BuildContext context) => AdminPage(),
                            );

                            Navigator.of(context).push(route);
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}

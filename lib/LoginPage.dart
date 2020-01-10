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
  final _minpadding = 5.0;
  var _currentItemSelected = 'Admin';

  TextEditingController nameController = TextEditingController();

  TextEditingController pswdController = TextEditingController();

  String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // cekLogin();
  }

//  Future cekLogin() async {
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    if (pref.getBool('isLogin')) {
//      Navigator.of(context).pushAndRemoveUntil(
//          new MaterialPageRoute(
//              builder: (BuildContext context) => new LoginPage()),
//          (Route<dynamic> route) => false);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Padding(
              padding: EdgeInsets.all(_minpadding * 7),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Image.network(
                        'http:\/\/172.16.17.141\/mmiserp\/assets\/logo.png',
                        height: 100.0,
                        width: 100.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _minpadding * 20),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        prefixIcon: Icon(Icons.person_pin),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _minpadding * 3),
                    child: TextFormField(
                      controller: pswdController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Enter Your Password',
                        labelText: 'Password',
                      ),
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Password';
                        } else if (value.length < 6) {
                          return 'Invalid Password';
                        }
                      },
                      onSaved: (value) => _password = value,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _minpadding * 3),
                    child: FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            prefixIcon: Icon(Icons.perm_identity),
                            hintText: "Login As",
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
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: _minpadding * 3),
                      child: Container(
                        margin: EdgeInsets.only(left: 100.0, right: 100.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_currentItemSelected == 'Teacher') {
                              if (_formKey.currentState.validate()) {
//                                SharedPreferences pref = await SharedPreferences.getInstance();
//                                pref.setBool('isLogin', true);
                                var route = MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TeacherPage(),
                                );

                                Navigator.of(context).push(route);
                              }
                            } else if (_currentItemSelected == 'Parents') {
                              if (_formKey.currentState.validate()) {
//                                SharedPreferences pref = await SharedPreferences.getInstance();
//                                  pref.setBool('isLogin', true);
                                var route = MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ParentsPage(),
                                );

                                Navigator.of(context).push(route);
                              }
                            } else if (_currentItemSelected == 'Admin') {
                              if (_formKey.currentState.validate()) {
//                                SharedPreferences pref = await SharedPreferences.getInstance();
//                                pref.setBool('isLogin', true);
                                var route = MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AdminPage(),
                                );

                                Navigator.of(context).push(route);
                              }
                            } else {
//                              SharedPreferences pref = await SharedPreferences.getInstance();
//                              pref.setBool("isLogin", false);

                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  child: new AlertDialog(
                                    title: Text('Select'),
                                    content: new Text(
                                      "please select Your school",
                                      style: new TextStyle(fontSize: 16.0),
                                    ),
                                    actions: <Widget>[
                                      new FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: new Text("OK"))
                                    ],
                                  ));
                            }
                          },
                        ),
                      )),
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

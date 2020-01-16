import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';

class home extends StatefulWidget {
  home({Key key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  static final String url = 'http://172.16.17.141/app_teacher_school_list.php';
  static final auth = 'Trizinno2019';
  List data;

  Future<String> getJSONdata() async {
    var response =
        await http.get(Uri.encodeFull(url), headers: {"auth": "Trizinno2019"});
    print(response.body);

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      data = dataConvertedToJSON['data'];
    });

    return 'successful';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.getJSONdata();

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _typeAheadController = TextEditingController();
  final _minpadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
        key: this._formKey,
        child: Padding(
          padding: EdgeInsets.all(_minpadding * 7),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(_minpadding * 2),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: _minpadding),
                  child: Center(
                    child: Text(
                      'Academic',
                      style: TextStyle(
                          inherit: true,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FredokaOne-Regular',
                          shadows: [
                            Shadow(
                                color: Colors.black12,
                                blurRadius: 3.0,
                                offset: Offset(5.0, 5.0))
                          ],
                          color: Colors.teal),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: _minpadding * 30),
                child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      controller: this._typeAheadController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          prefixIcon: Icon(Icons.school),
                          hintText: 'Select Your School'),
                    ),
                    debounceDuration: const Duration(milliseconds: 300),
                    suggestionsCallback: (pattern) {
                      return data;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(title: Text(suggestion['SCHOOL_NAME']));
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController.text =
                          suggestion['SCHOOL_NAME'];
                      if (this._typeAheadController.text ==
                          suggestion['SCHOOL_NAME']) {
                        var route = MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LoginPage(logo: suggestion['SCHOOL_LOGO']));
                        Navigator.of(context).push(route);
                      }
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select a School';
                      }
                    }),
              ),
//              Padding(
//                  padding: EdgeInsets.only(top: _minpadding * 3),
//                  child: Container(
//                    margin: EdgeInsets.only(left: 100.0, right: 100.0),
//                    child: RaisedButton(
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(30.0)),
//                      color: Theme.of(context).accentColor,
//                      textColor: Theme.of(context).primaryColorDark,
//                      child: const Text(
//                        'Submit',
//                        style: TextStyle(color: Colors.white),
//                      ),
//                      onPressed: () {
//                        _navigator();
//                      },
//                    ),
//                  )),

//                    child: RaisedButton (
//                        color: Theme.of(context).accentColor,
//                        textColor: Theme.of(context).primaryColorDark,
//                        child: const Text(
//                          'Submit',
//                          style: TextStyle(color: Colors.white),
//                        ),
//                        onPressed: () {
//                          if (_formKey.currentState.validate()) {
//
//                            Future<SharedPreferences> pref = SharedPreferences.getInstance();
//
//
//
//                            var route = MaterialPageRoute(
//                              builder: (BuildContext context) => LoginPage(),
//                            );
//
//                            Navigator.of(context).push(route);
//                          }
//                        }),
            ],
          ),
        ),
      ),
    ));
  }

  void _navigator() async {
    if (_formKey.currentState.validate()) {
//      SharedPreferences pref = await SharedPreferences.getInstance();
//      pref.setBool('isLogin', true);

      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (BuildContext context) => new LoginPage()),
          (Route<dynamic> route) => false);
    } else {
//      SharedPreferences pref = await SharedPreferences.getInstance();
//      pref.setBool("isLogin", false);

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
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'LoginPage.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: Form(
            key: this._formKey,
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      controller: this._typeAheadController,
                      decoration:
                          InputDecoration(hintText: 'Select Your School'),
                    ),
                    suggestionsCallback: (pattern) async {
                      Completer<List<String>> completer = new Completer();

                      completer.complete(<String>[
                        "L.P.Savani",
                        "P.P.Savani",
                        "S.D.J.Jain",
                        "Samrat International",
                        "Little Flower"
                      ]);

                      return completer.future;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(title: Text(suggestion));
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController.text = suggestion;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Select a School';
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 100.0, right: 100.0),
                    child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            var route = MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage(),
                            );

                            Navigator.of(context).push(route);
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

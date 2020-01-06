import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'LoginPage.dart';

class home extends StatefulWidget {
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
  }

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
                    debounceDuration: const Duration(milliseconds: 300),
                    suggestionsCallback: (pattern)  {
                      return data;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(title: Text(suggestion['SCHOOL_NAME']));
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController.text = suggestion['SCHOOL_NAME'];
                    },
                    // ignore: missing_return
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

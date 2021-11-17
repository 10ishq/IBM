import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;
import 'package:neon/neon.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'device.dart';
import 'predict.dart';

class prediction extends StatefulWidget {
  const prediction({Key? key}) : super(key: key);

  @override
  _predictionState createState() => _predictionState();
}

class _predictionState extends State<prediction> {
  var _cough = false;
  var _fever = false;
  var _sore_throat = false;
  var _shortness_of_breath = false;
  var _head_ache = false;
  var _age_60 = false;
  var _gender = false;
  var _contact = false;
  String cough = '0';
  String fever = '0';
  String sore_throat = '0';
  String shortness_of_breath = '0';
  String head_ache = '0';
  String age_60 = 'None';
  String gender = 'male';
  String contact = 'Other';
  final boolItems = ['Yes', 'No'];

  String resultData = 'n/a';

  Map bodyData = {
    "Inputs": {
      "input1": [
        {
          'test_date': "2020-04-30T00:00:00Z",
          'cough': "0",
          'fever': "0",
          'sore_throat': "0",
          'shortness_of_breath': "0",
          'head_ache': "0",
          'corona_result': "negative",
          'age_60_and_above': "None",
          'gender': "female",
          'test_indication': "Other",
        }
      ],
    },
    "GlobalParameters": {}
  };

  var bodyData1 = {
    "input1": [
      {
        'test_date': "2020-04-30T00:00:00Z",
        'cough': "0",
        'fever': "0",
        'sore_throat': "0",
        'shortness_of_breath': "0",
        'head_ache': "0",
        'corona_result': "negative",
        'age_60_and_above': "None",
        'gender': "female",
        'test_indication': "Other",
      }
    ],
  };
  var rawFlask = {
    'test_date': "2020-04-30T00:00:00Z",
    'cough': "0",
    'fever': "0",
    'sore_throat': "0",
    'shortness_of_breath': "0",
    'head_ache': "0",
    'corona_result': "negative",
    'age_60_and_above': "None",
    'gender': "female",
    'test_indication': "Other",
  };

  final httpClient = http.Client();
  var url = Uri.parse('https://flasktestname.herokuapp.com/post');
  var headers = {'Content-Type': 'application/json'};
  void fetchData() async {
    try {
      http.Response response = await httpClient.post(url,
          headers: headers, body: jsonEncode(rawFlask));
      print(response.body);
      var jasonified = jsonDecode(response.body);
      print(jasonified["Results"]["output1"][0]["Scored Labels"]);
      resultData = jasonified["Results"]["output1"][0]["Scored Labels"];
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   _cough.dispose();
  //   _fever.dispose();
  //   _sore_throat.dispose();
  //   _shortness_of_breath.dispose();
  //   _head_ache.dispose();
  //   _age_60.dispose();
  //   _gender.dispose();
  //   _contact.dispose();

  //   super.dispose();
  // }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                value: _cough,
                title: Text('Suffering from Cough'),
                onChanged: (value) => setState(() {
                  this._cough = value!;

                  print("_cough = " + _cough.toString());
                  if (_cough == false) {
                    rawFlask['cough'] = '0';
                  } else {
                    rawFlask['cough'] = '1';
                  }

                  print(rawFlask["cough"]);
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                value: _fever,
                title: Text('Suffering from fever'),
                onChanged: (value) => setState(() {
                  this._fever = value!;
                  print("_fever = " + _fever.toString());
                  if (_fever == false) {
                    rawFlask['fever'] = '0';
                  } else {
                    rawFlask['fever'] = '1';
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                value: _sore_throat,
                title: Text('Sore throat'),
                onChanged: (value) => setState(() {
                  this._sore_throat = value!;
                  print("_sore_throat = " + _sore_throat.toString());
                  if (_sore_throat == false) {
                    rawFlask['sore_throat'] = '0';
                  } else {
                    rawFlask['sore_throat'] = '1';
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                value: _shortness_of_breath,
                title: Text('Shortness of Breath'),
                onChanged: (value) => setState(() {
                  this._shortness_of_breath = value!;
                  print("_shortness_of_breath = " +
                      _shortness_of_breath.toString());
                  if (_shortness_of_breath == false) {
                    rawFlask['shortness_of_breath'] = '0';
                  } else {
                    rawFlask['shortness_of_breath'] = '1';
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                value: _head_ache,
                title: Text('Head ache'),
                onChanged: (value) => setState(() {
                  this._head_ache = value!;
                  print("_head_ache = " + _head_ache.toString());
                  if (_head_ache == false) {
                    rawFlask['head_ache'] = '0';
                  } else {
                    rawFlask['head_ache'] = '1';
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                value: _age_60,
                title: Text('Age above 60 years'),
                onChanged: (value) => setState(() {
                  this._age_60 = value!;
                  print("_age_60 = " + _age_60.toString());
                  if (_age_60 == false) {
                    rawFlask['age_60_and_above'] = 'No';
                  } else {
                    rawFlask['age_60_and_above'] = 'Yes';
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                value: _gender,
                title: Text('Select if the if the sex is male'),
                onChanged: (value) => setState(() {
                  this._gender = value!;
                  print("_gender = " + _gender.toString());
                  if (_gender == false) {
                    rawFlask['gender'] = 'female';
                  } else {
                    rawFlask['gender'] = 'male';
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                value: _contact,
                title: Text(
                    'Select if there is confirmed recent contact with Positive Covid patient?'),
                onChanged: (value) => setState(() {
                  this._contact = value!;
                  print("_contact = " + _contact.toString());
                  if (_contact == false) {
                    rawFlask['test_indication'] = 'Other';
                  } else {
                    rawFlask['test_indication'] = 'Contact with confirmed';
                  }
                  print(rawFlask);
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Prediction Result= " + resultData,
                textAlign: TextAlign.center,
                textScaleFactor: 1,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width * .6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text("Make Prediction"),
                  elevation: 100.0,
                  onPressed: () {
                    fetchData();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

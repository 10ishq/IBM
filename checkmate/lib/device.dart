import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;
import 'package:neon/neon.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'device.dart';
import 'predict.dart';
import 'alert.dart';

class deviceView extends StatefulWidget {
  const deviceView({Key? key}) : super(key: key);

  @override
  _deviceViewState createState() => _deviceViewState();
}

class _deviceViewState extends State<deviceView> {
  double bpm = 0.0;
  double oxygen = 0.0;
  double temp = 0.0;
  String bpmText = "........";
  String oxygenText = "........";
  final httpClient = http.Client();

  var bodyData = {
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

  var url = Uri.parse('http://127.0.0.1:5000/post');
  var headers = {'Content-Type': 'application/json'};
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.height * .4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: 80,
                                endValue: 108,
                                startWidth: 0.1,
                                sizeUnit: GaugeSizeUnit.factor,
                                endWidth: 0.1,
                                gradient: SweepGradient(stops: <double>[
                                  0.2,
                                  0.5,
                                  0.75
                                ], colors: <Color>[
                                  Colors.green,
                                  Colors.yellow,
                                  Colors.red
                                ]))
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                                value: temp,
                                needleColor: Colors.cyan,
                                tailStyle: TailStyle(
                                    length: 0.18,
                                    width: 8,
                                    color: Colors.black,
                                    lengthUnit: GaugeSizeUnit.factor),
                                needleLength: 0.68,
                                needleStartWidth: 1,
                                needleEndWidth: 8,
                                knobStyle: KnobStyle(
                                    knobRadius: 0.07,
                                    color: Colors.white,
                                    borderWidth: 0.05,
                                    borderColor: Colors.black),
                                lengthUnit: GaugeSizeUnit.factor)
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Text(
                                  '°F',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                positionFactor: 0.8,
                                angle: 90)
                          ],
                          ticksPosition: ElementsPosition.outside,
                          labelsPosition: ElementsPosition.outside,
                          minorTicksPerInterval: 5,
                          axisLineStyle: AxisLineStyle(
                            thicknessUnit: GaugeSizeUnit.factor,
                            thickness: 0.1,
                          ),
                          axisLabelStyle: GaugeTextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          radiusFactor: 0.97,
                          majorTickStyle: MajorTickStyle(
                              length: 0.1,
                              thickness: 2,
                              lengthUnit: GaugeSizeUnit.factor),
                          minorTickStyle: MinorTickStyle(
                              length: 0.05,
                              thickness: 1.5,
                              lengthUnit: GaugeSizeUnit.factor),
                          minimum: 80,
                          maximum: 108,
                          interval: 2,
                          startAngle: 115,
                          endAngle: 65,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.height * .4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 150.0,
                      ),
                    ),
                    Neon(
                      text: bpmText + " BPM",
                      color: Colors.red,
                      fontSize: 30.0,
                      font: NeonFont.TextMeOne,
                      flickeringText: true,
                      flickeringLetters: [0, 1],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Neon(
                          text: oxygenText + "% SPO2",
                          color: Colors.red,
                          fontSize: 30.0,
                          font: NeonFont.TextMeOne,
                          flickeringText: false,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text("Get Data from device"),
                onPressed: () => {fetchDeviceData()},
              )
            ],
          ),
        ),
      ),
    );
  }

  void fetchDeviceData() async {
    var device_url = Uri.parse('http://192.168.29.253:8888/');

    try {
      http.Response response = await httpClient.get(device_url);
      oxygen = double.parse(jsonDecode(response.body)['oxygen']);
      bpm = double.parse(jsonDecode(response.body)['bpm']);
      temp = double.parse(jsonDecode(response.body)['temp']);

      print(oxygen.runtimeType);
      print(bpm);
      bpmText = bpm.toString();
      oxygenText = oxygen.toString();
      print(temp);
    } catch (e) {
      print(e.toString());
    }
    bpm = 74;
    oxygen = 98;
    setState(() {});
  }
}

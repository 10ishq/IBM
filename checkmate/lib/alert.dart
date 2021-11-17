import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;
import 'package:neon/neon.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'device.dart';
import 'predict.dart';

class alertDevice extends StatelessWidget {
  const alertDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .7,
        width: MediaQuery.of(context).size.height * .8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 150,
              child: Text(
            "The device needs to be connected for measurement. Please visit the devpost page of the project for the demo and details of the hardware device",
            textScaleFactor: 2,
          )),
        ),
      ),
    );
  }
}

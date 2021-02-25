import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowMan extends StatefulWidget {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  @override
  _ShowManState createState() => _ShowManState();
}

class _ShowManState extends State<ShowMan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ShowMan"),
    );
  }
}

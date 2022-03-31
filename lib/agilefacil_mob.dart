
import 'dart:async';

import 'package:flutter/services.dart';

class AgilefacilMob {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {

    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


}

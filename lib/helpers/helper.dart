import 'dart:io';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info/device_info.dart';


class Helper{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }







  static Map loja;
  static Map usuario;

  static String newGuid(){
    return Uuid().v1();
  }

  static Future<String> getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String id = "";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      id = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor;
    }
    return id;
  }

  static DateTime strToDateTime(String date){
    if (!(date.isEmpty || date == null))
      return DateTime.parse(date);
  }

  static String DateTimeToStr(DateTime date){
    return date.toString();
  }




}


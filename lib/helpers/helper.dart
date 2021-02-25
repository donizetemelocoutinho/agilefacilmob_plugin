import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:device_info/device_info.dart';


class Helper{

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

}


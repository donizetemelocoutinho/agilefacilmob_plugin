import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'api_helper.dart';
import 'helper.dart';


class Pdv{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>Check(@required String codloja, @required String device) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = Map();
    jo['id'] = await Helper.getId();
    jo['device'] = device;
    return await api.get("pdv/check", params : {"codloja": codloja,"device": device});
  }

  Future<Map> Store(@required String chave, @required String device) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = Map();
    jo['id'] = await Helper.loja.codloja.toString();
    jo['device'] = device;
    return await api.post("owner/store", jo);
  }


}

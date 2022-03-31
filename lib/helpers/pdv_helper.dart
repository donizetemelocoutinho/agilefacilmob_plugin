import 'package:flutter/services.dart';

import 'api_helper.dart';
import 'helper.dart';


class Pdv{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>Check({required int codloja}) async{
    ApiHelper api = ApiHelper();
    String device = await Helper.getId();
    return await api.get("loja/pdv/check", params : {"codloja": codloja.toString(),"device": device});
  }

  Future<Map> LinkDevice({required String chave}) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = Map();

    Map<String,dynamic>device = Map();

    jo['chave'] = chave;

    device["id"] = await Helper.getId();
    device["nome"] = await Helper.getNome();
    jo['device'] = device;

    return await api.post("loja/pdv/linkdevice", jo, params: {});
  }

  Future<Map>get({required int codloja, required int codpdv, required String api_token})async{
    ApiHelper api = ApiHelper();
    return await api.get("loja/pdv/get", params: {"codloja": codloja.toString(),"codpdv":codpdv.toString(),"api_token":api_token});
  }


}

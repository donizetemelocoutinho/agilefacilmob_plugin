
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'api_helper.dart';
import 'helper.dart';


class OwnerApi{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>Checked() async{
    ApiHelper api = ApiHelper();
    String id = await Helper.getId();
    return await api.get("owner/checked", params : {"id": id});
  }

  Future<Map>Resend({@required String fone}) async {
    ApiHelper api = ApiHelper();
    String id = await Helper.getId();

    return await api.get("owner/resend", params : {"id": id,"fone": fone });
  }

  Future<Map> Store(@required String fone, String descricao) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = Map();
    jo['id'] = await Helper.getId();
    jo['fone'] = fone;
    jo['descricao'] = descricao;
    return await api.post("owner/store", jo);
  }

  Future<Map> Validate(@required String code) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = Map();
    jo['id'] = await Helper.getId();
    jo['code'] = code;
    return await api.post("owner/validate", jo);
  }
}

class Owner{

}
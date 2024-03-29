import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:flutter/services.dart';

class BancoApi{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>getList({required String search,required int startrow})async{
    ApiHelper api = ApiHelper();
    return await api.get("common/banco/list", params:{"search":search, "startrow":startrow.toString()});
  }

}

class Banco{
  int codbanco = 0;
  String guid = "";
  int codigo = 0;
  String descricao = "";
  String linklogo = "";

  Banco();

  Banco.fromMap(Map map){
    codbanco = map['codbanco'] ?? 0;
    guid = map['guid'] ?? "";
    codigo = map['codigo'] ?? 0;
    descricao = map['descricao'] ?? "";
    linklogo = map['linklogo'] ?? "";
  }
}
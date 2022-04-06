import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:flutter/services.dart';

class MarcaApi {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>get({required int codloja, required int codmarca,required String api_token})async{
    ApiHelper api = ApiHelper();
    return await api.get("estoque/marca/edit", params: {"codloja":codloja.toString(),"codmarca": codmarca.toString(),"api_token":api_token});
  }

  Future<List>getList({required int codloja,required String api_token, required String search})async{
    ApiHelper api = ApiHelper();

    Map<String, dynamic> _params = {"codloja":codloja.toString(), "api_token": api_token};
    if (search != 0)
      _params['search'] = search;

    return await api.get("estoque/marca/list", params: _params);

  }

}


class Marca{
  int id = 0;
  String guid = '';
  int codmarca = 0;
  int codloja = 0;
  String idloja = '';
  String descricao = '';

  Marca();

  Marca.fromMap( Map map){
    id = map['id'] ?? 0;
    guid = map['guid'] ?? "";
    codmarca = map['codmarca'] ?? 0;
    codloja = map['codloja'] ?? 0;
    idloja = map['idloja'] ?? "";
    descricao = map['descricao'] ?? "";
  }
}

  class MarcaListItem{
    String guid = '';
    int codmarca = 0;
    int codloja = 0;
    String idloja = '';
    String descricao = '';

    MarcaListItem();

    MarcaListItem.fromMap( Map map){
      guid = map['guid'] ?? "";
      codmarca = map['codmarca'] ?? 0;
      codloja = map['codloja'] ?? 0;
      idloja = map['idloja'] ?? "";
      descricao = map['descricao'] ?? "";
    }
  }



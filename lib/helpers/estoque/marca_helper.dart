import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MarcaApi {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>get({@required int codloja, @required int codmarca,@required String api_token})async{
    ApiHelper api = ApiHelper();
    return await api.get("estoque/marca/edit", params: {"codloja":codloja.toString(),"codmarca": codmarca.toString(),"api_token":api_token});
  }

  Future<List>getList({@required int codloja,@required String api_token, String search})async{
    ApiHelper api = ApiHelper();

    Map<String, dynamic> _params = {"codloja":codloja.toString(), "api_token": api_token};
    if (search != null)
      _params['search'] = search;

    return await api.get("estoque/marca/list", params: _params);

  }

}


class Marca{
  int id;
  String guid;
  int codmarca;
  int codloja;
  String idloja;
  String descricao;

  Marca();

  Marca.fromMap( Map map){
    id = map['id'];
    guid = map['guid'];
    codmarca = map['codmarca'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    descricao = map['descricao'];
  }
}

  class MarcaListItem{
    String guid;
    int codmarca;
    int codloja;
    String idloja;
    String descricao;

    MarcaListItem();

    MarcaListItem.fromMap( Map map){
      guid = map['guid'];
      codmarca = map['codmarca'];
      codloja = map['codloja'];
      idloja = map['idloja'];
      descricao = map['descricao'];
    }
  }



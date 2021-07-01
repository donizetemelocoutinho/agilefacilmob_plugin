import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class GrupoApi{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

 Future<List>getGrupoList({@required int codloja,@required String api_token})async{
    ApiHelper api = ApiHelper();
    return await api.get("estoque/grupo/list", params:{"codloja":codloja.toString(), "api_token": api_token});
 }

}

class Grupo{
  int id;
  String guid;
  int codgrupo;
  int codloja;
  String idloja;
  String descricao;

  Grupo();

  Grupo.fromMap( Map map){
    id = map['id'];
    guid = map['guid'];
    codgrupo = map['codgrupo'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    descricao = map['descricao'];
  }
}

class GrupoListItem{
  String guid;
  int codgrupo;
  int codloja;
  String idloja;
  String descricao;

  GrupoListItem();

  GrupoListItem.fromMap( Map map){
    guid = map['guid'];
    codgrupo = map['codgrupo'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    descricao = map['descricao'];
  }
}
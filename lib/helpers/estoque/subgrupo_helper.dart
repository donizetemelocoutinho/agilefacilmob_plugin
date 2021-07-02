import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class SubGrupoApi{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<List>getSubGrupoList({@required int codloja,@required String api_token,int codgrupo})async{
    ApiHelper api = ApiHelper();

    _params = {"codloja": codloja.toString(),"api_token": api_token};

    if (codgrupo != null)
      _params["codgrupo"] = codgrupo.toString();

    return await api.get("estoque/subgrupo/list",params : _params);
  }

}

class SubGrupoComissao{
  double avista;
  double aprazo;

  SubGrupoComissao();

  SubGrupoComissao.fromMap(Map map){
    avista = map['avista'];
    aprazo = map['aprazo'];
  }
}


class SubGrupo{
  int id;
  String guid;
  int codsubgrupo;
  int codloja;
  String idloja;
  String descricao;
  int codgrupo;
  String idgrupo;
  String grupo;
  String linkicone;
  String favorito;
  SubGrupoComissao comissao;

  SubGrupo();

  SubGrupo.fromMap(Map map){
    id = map['id'];
    guid = map['guid'];
    codsubgrupo = map['codsubgrupo'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    descricao = map['descricao'];
    codgrupo = map['codgrupo'];
    idgrupo = map['idgrupo'];
    favorito = map['grupo'];
    comissao = SubGrupoComissao.fromMap(map['comissao']);
  }
}

class SubGrupoListItem{
  String guid;
  int codsubgrupo;
  int codloja;
  String idloja;
  String descricao;
  int codgrupo;
  String idgrupo;
  String grupo;
  String linkicone;
  String favorito;
  SubGrupoComissao comissao;

  SubGrupoListItem();

  SubGrupoListItem.fromMap(Map map){
    guid = map['guid'];
    codsubgrupo = map['codsubgrupo'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    descricao = map['descricao'];
    codgrupo = map['codgrupo'];
    idgrupo = map['idgrupo'];
    grupo = map['grupo'];
    linkicone = map['linkicone'];
    favorito = map['favorito'];
    comissao = SubGrupoComissao.fromMap(map['comissao']);
  }
}
import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:flutter/services.dart';

class SubGrupoApi{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<List>getSubGrupoList({required int codloja,required String api_token,String ?search,int ?codgrupo})async{
    ApiHelper api = ApiHelper();

    Map<String, String> _params = {"codloja": codloja.toString(),"api_token": api_token};

    if (codgrupo != null)
      _params["codgrupo"] = codgrupo.toString();

    if (search != null)
      _params['search'] = search;

    return await api.get("estoque/subgrupo/list", params : _params);
  }

}

class SubGrupoComissao{
  double avista = 0.00;
  double aprazo = 0.00;

  SubGrupoComissao();

  SubGrupoComissao.fromMap(Map map){
    avista = double.parse(map['avista']);
    aprazo = double.parse(map['aprazo']);
  }
}


class SubGrupo{
  int id = 0;
  String guid = '';
  int codsubgrupo = 0;
  int codloja = 0;
  String idloja = '';
  String descricao = '';
  int codgrupo = 0;
  String idgrupo = '';
  String grupo = '';
  String? linkicone;
  String favorito = 'N';
  SubGrupoComissao? comissao;

  SubGrupo();

  SubGrupo.fromMap(Map map){
    id = map['id'] ?? 0;
    guid = map['guid'] ?? "";
    codsubgrupo = map['codsubgrupo'] ?? 0;
    codloja = map['codloja'] ?? 0;
    idloja = map['idloja'] ?? "";
    descricao = map['descricao'] ?? "";
    codgrupo = map['codgrupo'] ?? 0;
    idgrupo = map['idgrupo'] ?? "";
    favorito = map['grupo'] ?? "N";
    comissao = SubGrupoComissao.fromMap(map['comissao']);
  }
}

class SubGrupoListItem{
  String guid = '';
  int codsubgrupo = 0;
  int codloja = 0;
  String idloja = '';
  String descricao = '';
  int codgrupo = 0;
  String idgrupo = '';
  String grupo = '';
  String? linkicone;
  String favorito = 'N';
  SubGrupoComissao ?comissao;

  SubGrupoListItem();

  SubGrupoListItem.fromMap(Map map){
    guid = map['guid'] ?? "";
    codsubgrupo = map['codsubgrupo'] ?? 0;
    codloja = map['codloja'] ?? 0;
    idloja = map['idloja'] ?? "";
    descricao = map['descricao'] ?? "";
    codgrupo = map['codgrupo'] ?? 0;
    idgrupo = map['idgrupo'] ?? "";
    grupo = map['grupo'] ?? "";
    linkicone = map['linkicone'] ?? "";
    favorito = map['favorito'] ?? "N";
    comissao = SubGrupoComissao.fromMap(map['comissao']);
  }
}
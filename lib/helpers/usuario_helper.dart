import 'package:flutter/services.dart';

import 'api_helper.dart';

class Usuario{
  int id;
  String guid;
  int codusuario;
  int codloja;
  String idloja;
  String login;
  String senha;
  String idgrupo;
  int codgrupo;
  String ativo;
  String celular;
  String alterarspl;
  String fotolink;
  String api_token;
  int codfuncionario;

  Usuario();

  Usuario.fromMap( Map map){
    id = map['id'];
    guid = map['guid'];
    codusuario = map['codusuario'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    login = map['login'];
    senha = map['senha'];
    idgrupo = map['idgrupo'];
    codgrupo = map['codgrupo'];
    ativo = map['ativo'];
    celular = map['celular'];
    alterarspl = map['alterarspl'];
    fotolink = map['fotolink'];
    api_token = map['api_token'];
    codfuncionario = map['codfuncionario'];


  }

}


class UsuarioApi{

  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map> Autenticar(String cpfcnpj,String login,String senha) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = Map();
    jo['cpfcnpj'] = cpfcnpj;
    jo['login'] = login;
    jo['senha'] = senha;
    //print("Envio...: $jo");
    return await api.post("usuario/autenticar", jo);
  }

}

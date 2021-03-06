import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'api_helper.dart';

class Usuario{
  int id;
  String guid;
  int codusuario;
  int codloja;
  String loja;
  String cnpj;
  String idloja;
  String login;
  String senha;
  String idgrupo;
  int codgrupo;
  String ativo;
  String email;
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
    loja = map['loja'];
    cnpj = map['cnpj'];
    login = map['login'];
    senha = map['senha'];
    idgrupo = map['idgrupo'];
    codgrupo = map['codgrupo'];
    ativo = map['ativo'];
    email = map['email'];
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
    return await api.post("usuario/autenticar", jo);
  }

  Future<Map> AtualizarPerfil({@required int codloja,@required int codusuario,@required String api_token, String foto, String celular, String email}) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = Map();
    jo['codloja'] = codloja;
    jo['codusuario'] = codusuario;
    jo['foto'] = foto;
    jo['celular'] = celular;
    jo['email'] = email;
    return await api.post("usuario/update", jo,params : {"codloja": codloja.toString(),"api_token":api_token});
  }

  Future<Map> AtualizarSenha({@required int codloja,@required int codusuario,@required String api_token, String senhaatual, String novasenha}) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = Map();
    jo['codloja'] = codloja;
    jo['codusuario'] = codusuario;
    jo['senhaatual'] = senhaatual;
    jo['novasenha'] = novasenha;

    return await api.post("usuario/updatesenha", jo,params : {"codloja": codloja.toString(),"api_token":api_token});
  }

}

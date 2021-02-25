import 'package:flutter/services.dart';

import 'api_helper.dart';

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
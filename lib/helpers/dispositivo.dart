import 'package:flutter/services.dart';
import 'api_helper.dart';

class DispositivoApi{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>storeDispostivo({required String api_token, required Dispositivo dispositivo})async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = dispositivo.toMap();
    return await api.post("dispositivo/cadastrar", jo,params:{"api_token": api_token});
  }

  Future<Map>get({required int codloja, required String device})async{
    ApiHelper api = ApiHelper();
    return await api.get("dispositivo/valid", params: {"codloja": codloja.toString(),"device":device});
  }

}

class Dispositivo{
  String cpfcnpj = "";
  String login = "";
  String senha = "";
  String celular = "";
  String id = "";
  String descricao = "";
  String guid = "";

  Dispositivo();

  Dispositivo.fromMap(Map map){
    cpfcnpj = map['cpfcnpj'];
    login = map['login'];
    senha = map['senha'];
    celular = map['celular'];
    id = map['id'];
    descricao = map['descricao'];
    guid = map['guid'];

  }

  @override
  Map<String,dynamic> toMap() {
    Map<String, dynamic> map = {
      'cpfcnpj': cpfcnpj,
      'login': login,
      'senha': senha,
      'celular': celular,
      'id': id,
      'descricao': descricao,
      'guid': guid,
    };
    return map;
  }
}
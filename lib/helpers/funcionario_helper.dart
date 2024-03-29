import 'package:agilefacil_mob/helpers/pessoa_helper.dart';
import 'package:flutter/services.dart';
import 'api_helper.dart';

class FuncionarioApi {

  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map> get({required int codloja, required int codfuncionario, required String api_token}) async{
    ApiHelper api = ApiHelper();
    return await api.get("funcionario/edit", params : {"codloja": codloja.toString(),"codfuncionario": codfuncionario.toString(),"api_token": api_token });
  }
}

class Funcionario extends PessoaFisica{
  int codigo = 0;
  DateTime? admissao;
  DateTime? demissao;
  String ativo = 'S';
  Comissao comissao = Comissao();
  String funcao = '';

  Funcionario.fromMap(Map map) {
    super.fromMap(map);

    codigo = map['codigo'] ?? 0;
    admissao = DateTime.tryParse(map['admissao'] ?? "");
    demissao = DateTime.tryParse(map['demissao'] ?? "");
    ativo = map['ativo'] ?? "S";
    comissao = Comissao.fromMap(map['comissao']);
    funcao = map['funcao'] ?? "";
  }

  @override
  Map<String,dynamic> toMap() {
    Map<String, dynamic> map = {
      'codigo' : codigo,
      'admissao' : admissao,
      'demissao' : demissao,
      'ativo' : ativo,
      'comissao' : comissao.toMap(),
      'funcao' : funcao,
    };
    return map;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'api_helper.dart';

class FormaPagamentoApi {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>getList({@required int codloja, @required int tipo, @required String api_token})async{
    ApiHelper api = ApiHelper();
    return await api.get("loja/pgto/list", params: {"codloja": codloja.toString(),"tipo": tipo.toString(),"api_token":api_token.toString()});
  }
}

class FormaPagamento{

  int id;
  String guid;
  int codformapagamento;
  int codloja;
  String idloja;
  int indice;
  int tipo;
  int tipoconta;
  bool padrao;
  int finalidade;
  int tpnfe;
  String descricao;
  String icone;

  FormaPagamento();

  FormaPagamento.fromMap(Map map){
    id = map['id'];
    guid = map['guid'];
    codformapagamento = map['codformapagamento'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    indice = map['indice'];
    tipo = map['tipo'];
    tipoconta = map['tipoconta'];
    padrao = map['padrao'];
    finalidade = map['finalidade'];
    tpnfe = map['tpnfe'];
    descricao = map['descricao'];
    icone = map['icone'];
  }
}


class FormaPagamentoListItem{
  String guid;
  int codformapagamento;
  int codloja;
  String idloja;
  int indice;
  int tipo;
  int tipoconta;
  bool padrao;
  int finalidade;
  int tpnfe;
  String descricao;
  String icone;

  FormaPagamentoListItem();

  FormaPagamentoListItem.fromMap(Map map){

    guid = map['guid'];
    codformapagamento = map['codformapagamento'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    indice = map['indice'];
    tipo = map['tipo'];
    tipoconta = map['tipoconta'];
    padrao = map['padrao'];
    finalidade = map['finalidade'];
    tpnfe = map['tpnfe'];
    descricao = map['descricao'];
    icone = map['icone'];
  }
}

import 'package:flutter/services.dart';
import 'api_helper.dart';

class FormaPagamentoApi {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>getList({required int codloja, required int tipo, required String api_token})async{
    ApiHelper api = ApiHelper();
    return await api.get("loja/pgto/list", params: {"codloja": codloja.toString(),"tipo": tipo.toString(),"api_token":api_token.toString()});
  }

  Future<List>FormaPagamentoCalcularParcelas({required int codloja, required double valor, required int codpgto, required String api_token})async{
    ApiHelper api = ApiHelper();

    Map result = await api.get("loja/pgto/parcelas/calcular", params: {"codloja": codloja.toString(),"valor": valor,"codpgto": codpgto.toString(),
      "api_token":api_token});
    List<SimularParcelaItem> parcelas = [];

    if (result['id'] == 0){
      for (var _item in result['parcelas']) {
        parcelas.add(SimularParcelaItem.fromMap(_item));
      }
    } else
      throw Exception("Não foi possivel calcular as parcelas: ${result["msg"]}");

    return parcelas;
  }
}

class FormaPagamento{

  int id = 0;
  String guid = '';
  int codformapagamento = 1;
  int codloja = 0;
  String idloja = '';
  int indice = 0;
  int tipo = 0;
  int tipoconta = 0;
  bool ?padrao;
  int finalidade = 0;
  int tpnfe = 0;
  String descricao  = '';
  String icone = '';

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
  String guid  = '';
  int codformapagamento = 1;
  int codloja = 0;
  String idloja = '';
  int indice = 0;
  int tipo = 0;
  int tipoconta = 0;
  bool ?padrao;
  int finalidade = 0;
  int tpnfe = 0;
  String descricao = '';
  String icone = '';

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

  class SimularParcelaItem{
    int numero  = 0;
    double parcela = 0.00;
    double total = 0.00;

    SimularParcelaItem.fromMap(Map map){
    numero = map['numero'];
    parcela = double.parse(map['parcela']);
    total = double.parse(map['total']);
  }
}


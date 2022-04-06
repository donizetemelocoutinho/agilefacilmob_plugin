import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:flutter/services.dart';


class SimulaParcelaItem{
  int numero  = 0;
  double parcela = 0.00;
  double total = 0.00;

  SimulaParcelaItem.fromMap(Map map){
    numero = map['numero'] ?? 0;
    parcela = double.parse(map['parcela'] ?? 0);
    total = double.parse(map['total'] ?? 0);
  }
}


class FinanceiroUtilApi {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<List<SimulaParcelaItem>>CalcularParcelas({required int codloja, required double valor, required String api_token})async{
    ApiHelper api = ApiHelper();

    Map result = await api.get("venda/parcelas/calcular", params: {"codloja": codloja.toString(),"valor": valor.toString(),"api_token":api_token.toString()});
    List<SimulaParcelaItem> parcelas = [];

    if (result['id'] == 0){
      for (var _item in result['parcelas']) {
        parcelas.add(SimulaParcelaItem.fromMap(_item));
      }
    } else
      throw Exception("Não foi possivel calcular as parcelas: ${result["msg"]}");

    return parcelas;
  }
}




import 'package:flutter/services.dart';
import 'api_helper.dart';

  class TituloApi{

    static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
    static Future<String> get platformVersion async {
      final String version = await _channel.invokeMethod('getPlatformVersion');
      return version;
    }

    Future<Map> getList({required int codloja, required int? tipo, DateTime? inicio, DateTime? fim, required bool cancelado, required int? periodo, required int? codcliente, required int startrow, required String api_token,}) async {
      ApiHelper api = ApiHelper();
      return await api.get("titulo/list",params: {"codloja": codloja.toString(), "tipo": tipo, "periodo": periodo, "codcliente": codcliente.toString(), "startrow": startrow.toString(),
        "cancelado": cancelado ? "S" : "N", "api_token": api_token});

    }

  }


  class Titulo {
    Titulo({
      int? count,
      int? total,
      List<TitulosListItem>? titulos,}){
      _count = count;
      _total = total;
      _titulos = titulos;
    }

    Titulo.fromMap(Map map) {
      _count = map['count'];
      _total = map['total'];
      if (map['titulos'] != null) {
        _titulos = [];
        map['titulos'].forEach((v) {
          _titulos?.add(TitulosListItem.fromMap(v));
        });
      }
    }
    int? _count;
    int? _total;
    List<TitulosListItem>? _titulos;

    int? get count => _count;
    int? get total => _total;
    List<TitulosListItem>? get titulos => _titulos;

    Map<String, dynamic> toMap() {
      final map = <String, dynamic>{
        'count' : _count,
        'total' : _total,
        if (_titulos != null)
          'titulos' : _titulos?.map((v) => v.toMap()).toList(),
      };
      return map;
    }

  }

  class TitulosListItem {
    TitulosListItem({
      int? codtitulo,
      int? codloja,
      int? codpessoa,
      String? nome,
      String? numerodoc,
      Data? data,
      Valor? valor,
      int? diasatraso,
      String? pgto,
      String? usuario,
      String? descricao,
      String? motivocancelamento,
      String? planocontas,}){
      _codtitulo = codtitulo;
      _codloja = codloja;
      _codpessoa = codpessoa;
      _nome = nome;
      _numerodoc = numerodoc;
      _data = data;
      _valor = valor;
      _diasatraso = diasatraso;
      _pgto = pgto;
      _usuario = usuario;
      _descricao = descricao;
      _motivocancelamento = motivocancelamento;
      _planocontas = planocontas;
    }

    TitulosListItem.fromMap(Map map) {
      _codtitulo = map['codtitulo'];
      _codloja = map['codloja'];
      _codpessoa = map['codpessoa'];
      _nome = map['nome'];
      _numerodoc = map['numerodoc'];
      _data = map['data'] != null ? Data.fromMap(map['data']) : null;
      _valor = map['valor'] != null ? Valor.fromMap(map['valor']) : null;
      _diasatraso = map['diasatraso'];
      _pgto = map['pgto'];
      _usuario = map['usuario'];
      _descricao = map['descricao'];
      _motivocancelamento = map['motivocancelamento'];
      _planocontas = map['planocontas'];
    }
    int? _codtitulo;
    int? _codloja;
    int? _codpessoa;
    String? _nome;
    String? _numerodoc;
    Data? _data;
    Valor? _valor;
    int? _diasatraso;
    String? _pgto;
    String? _usuario;
    String? _descricao;
    String? _motivocancelamento;
    String? _planocontas;

    int? get codtitulo => _codtitulo;
    int? get codloja => _codloja;
    int? get codpessoa => _codpessoa;
    String? get nome => _nome;
    String? get numerodoc => _numerodoc;
    Data? get data => _data;
    Valor? get valor => _valor;
    int? get diasatraso => _diasatraso;
    String? get pgto => _pgto;
    String? get usuario => _usuario;
    String? get descricao => _descricao;
    String? get motivocancelamento => _motivocancelamento;
    String? get planocontas => _planocontas;

    Map<String,dynamic> toMap() {
      Map<String, dynamic> map = {
        'codtitulo' : _codtitulo,
        'codloja' : _codloja,
        'codpessoa' : _codpessoa,
        'nome' : _nome,
        'numerodoc' : _numerodoc,
        if (_data != null)
          'data' : _data?.toMap(),

        if (_valor != null)
          'valor' : _valor?.toMap(),

        'diasatraso' : _diasatraso,
        'pgto' : _pgto,
        'usuario' : _usuario,
        'descricao' : _descricao,
        'motivocancelamento' : _motivocancelamento,
        'planocontas' : _planocontas,
      };
      return map;
    }

  }

  class Valor {
    Valor({
      String? nominal,
      String? restante,
      int? juro,
      int? multa,
      String? pago,
      int? atual,}){
      _nominal = nominal;
      _restante = restante;
      _juro = juro;
      _multa = multa;
      _pago = pago;
      _atual = atual;
    }

    Valor.fromMap(Map map) {
      _nominal = map['nominal'];
      _restante = map['restante'];
      _juro = map['juro'];
      _multa = map['multa'];
      _pago = map['pago'];
      _atual = map['atual'];
    }
    String? _nominal;
    String? _restante;
    int? _juro;
    int? _multa;
    String? _pago;
    int? _atual;

    String? get nominal => _nominal;
    String? get restante => _restante;
    int? get juro => _juro;
    int? get multa => _multa;
    String? get pago => _pago;
    int? get atual => _atual;

    Map<String,dynamic> toMap() {
      Map<String, dynamic> map = {
        'nominal' : _nominal,
        'restante' : _restante,
        'juro' : _juro,
        'multa' : _multa,
        'pago' : _pago,
        'atual' : _atual,
      };
      return map;
    }

  }

  class Data {
    Data({
      String? digitacao,
      String? emissao,
      String? vencimento,
      String? ultimopagamento,
      String? quitacao,
      String? cancelamento,}){
      _digitacao = digitacao;
      _emissao = emissao;
      _vencimento = vencimento;
      _ultimopagamento = ultimopagamento;
      _quitacao = quitacao;
      _cancelamento = cancelamento;
    }

    Data.fromMap(Map map) {
      _digitacao = map['digitacao'];
      _emissao = map['emissao'];
      _vencimento = map['vencimento'];
      _ultimopagamento = map['ultimopagamento'];
      _quitacao = map['quitacao'];
      _cancelamento = map['cancelamento'];
    }
    String? _digitacao;
    String? _emissao;
    String? _vencimento;
    String? _ultimopagamento;
    String? _quitacao;
    String? _cancelamento;

    String? get digitacao => _digitacao;
    String? get emissao => _emissao;
    String? get vencimento => _vencimento;
    String? get ultimopagamento => _ultimopagamento;
    String? get quitacao => _quitacao;
    String? get cancelamento => _cancelamento;

    Map<String,dynamic> toMap() {
      Map<String, dynamic> map = {
        'digitacao' : _digitacao,
        'emissao' : _emissao,
        'vencimento' : _vencimento,
        'ultimopagamento' : _ultimopagamento,
        'quitacao' : _quitacao,
        'cancelamento' : _cancelamento,
      };
      return map;
    }

  }
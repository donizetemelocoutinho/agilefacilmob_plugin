import 'dart:convert';
import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:agilefacil_mob/helpers/helper.dart';
import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum DavTypes {orcamento,pedido,osmecanica,osinformatica,osgeral,condicional}

class DavApi {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>getDavList({required int codloja,DateTime? inicio, DateTime? fim,int? codcliente, List<DavTypes> ?tipos,required bool cancelado, int? numero,
    String? numeroalternativo, String? numeroficha, required int startrow, required String api_token})async{

    ApiHelper api = ApiHelper();

    Map<String, String> _params ={"codloja": codloja.toString(),"cancelado": cancelado ? "S" : "N","startrow":startrow.toString(), "api_token" : api_token};

    if (inicio != null)
      _params["inicio"] = inicio.toString();

    if (fim != null)
      _params["fim"] = fim.toString();

    if ((codcliente != 0) && (codcliente != null))
      _params["codcliente"] = jsonEncode([codcliente]);

    if ((numero != 0) && (numero != null))
      _params["numero"] = numero.toString();

    if (tipos != null)
    {
      //print(tipos);
      List<int> jtipos= [];
      for (var i = 0; i < tipos.length; i++) {
        jtipos.add(tipos[i].index);
      }
      _params["tipos"] = jsonEncode(jtipos);
    }

    //print(jsonEncode(_params));
    return await api.get("dav/list",params:_params);
  }

  Future<Map>get({required int codloja, required int coddav,required String api_token})async{
    ApiHelper api = ApiHelper();
    return await api.get("dav/edit", params: {"codloja": codloja.toString(),"coddav":coddav.toString(),"api_token":api_token });
  }

  Future<Map>storeDav({required String api_token, required Dav dav})async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = dav.toMap();
    return await api.post("dav", jo,params:{"api_token": api_token});
  }

}

class DavHelper {

}

class Dav{
  String guid = Helper.newGuid();
  int coddav = 0;
  int codusuario = 0;
  int codcliente = 0;
  int codfuncionario = 0;
  int codloja = 0;
  int numero = 0;
  DavTypes tipo = DavTypes.orcamento;
  DateTime digitacao = DateTime.now();
  TabelaPrecoType tabelapreco = TabelaPrecoType.tpPrincipal;
  String observacao = "";
  String numeroalternativo = "";
  int numeroficha = 0;
  int tpcondicional =  0;
  DavTotal total = DavTotal();
  DavCliente cliente = DavCliente();
  String cancelado = "N";
  String faturado = "N";
  int origem = 2;
  int validade = 0;
  int entrega = 0;
  DavPagamento pagamento = DavPagamento();
  int codgprDocumento = 0;
  List<DavItem> _itens = [];

  Dav(){
    codusuario = Helper.usuario.codusuario;
    codloja = Helper.loja.codloja;
  }

  totalizar(){
    total.bruto = 0;
    total.liquido = 0;
    total.desconto_itens = 0;
    total.peso_liquido = 0;
    total.peso_bruto = 0;
    total.subtotal = 0;
    total.acrescimo_itens = 0;

    for (int i = 0; i < _itens.length; i++) {

      if (_itens[i].deleted_at == null) {
        total.bruto = total.bruto + _itens[i].total.bruto;
        total.desconto_itens = total.desconto_itens + _itens[i].desconto.item;
        total.acrescimo_itens = total.acrescimo_itens + _itens[i].acrescimo.item;
        total.peso_liquido = total.peso_liquido + _itens[i].pesoliquido;
        total.peso_bruto = total.peso_bruto + _itens[i].total.peso_bruto;
        total.subtotal = total.bruto - total.desconto_itens + total.acrescimo_itens;
        total.liquido = total.subtotal - total.desconto_total + total.acrescimo_itens;
      }
    }
  }

  List<DavItem> getItens(){
    List<DavItem> itens = [];
    for (int i = 0; i < _itens.length; i++) {
      if (_itens[i].deleted_at == null)
        itens.add(_itens[i]);
    }
    return itens;
  }

  void DeleteItem(int sequencia){
    for (int i = 0; i < _itens.length; i++) {
      if (_itens[i].item == sequencia){
        _itens[i].deleted_at = DateTime.now();
      }
    }
    totalizar();
  }

  void AddItem(DavItem item){
    item.item = _itens.length + 1;
    _itens.add(item);
    totalizar();
  }

  Dav.fromMap(Map map){
    coddav = map['coddav'] ?? 0;
    guid = map['guid'];
    codusuario = map['codusuario'] ?? 0;
    codfuncionario = map['codfuncionario'] ?? 0;
    codloja = map['codloja'] ?? 0;
    numero = map['numero'] ?? 0;
    tipo = map['tipo'] ?? DavTypes.orcamento;

    if (map['digitacao'] != null)
      digitacao =  DateTime.parse(map['digitacao']);

    if(tabelapreco != 0)
      tabelapreco = TabelaPrecoType.values[int.parse(map['tabelapreco'],radix:0)];

    observacao = map['observacao'] ?? "";
    if(numeroficha != 0)
      numeroficha = int.parse(map['numeroficha'],radix: 0);
    if(numeroalternativo != 0)
      numeroalternativo = (map['numeroalternativo']);
    tpcondicional = map['tpcondicional'] ?? 0;
    total = DavTotal.fromMap(map["total"]);
    cliente = DavCliente.fromMap(map["cliente"]);
    pagamento = DavPagamento.fromMap(map['pagamento']);

    if (map['itens'] != null) {
      for (int i = 0; i < map['itens'].length; i++) {
        _itens.add(DavItem.fromMap(map['itens'][i]));
      }
    }
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {

      'coddav': coddav,
      'guid': guid,
      'codusuario': codusuario,
      'codfuncionario': codfuncionario,
      'codloja': codloja,
      'numero': numero,
      'tipo': tipo,
      'digitacao': DateFormat('yyyy-MM-dd').format(digitacao),
      'tabelapreco': tabelapreco.index,
      'numeroficha': numeroficha,
      'observacao': observacao,
      'numeroalternativo': numeroalternativo,
      'tpcondicional': tpcondicional,
      'total': total.toMap(),
      'cliente': cliente.toMap(),
      'pagamento': pagamento.toMap(),


    };
    return map;

  }
}

class DavTotal {
  double bruto = 0;
  double liquido = 0;
  double entrada = 0;
  double peso_bruto = 0;
  double peso_liquido = 0;
  double desconto_itens = 0;
  double desconto_subtotal = 0;
  double desconto_total = 0;
  double acrescimo_itens = 0;
  double acrescimo_subtotal = 0;
  double acrescimo_total =0;
  double subtotal = 0;
  double tributos_icmsst = 0;
  double tributos_ipi = 0;
  double outros_fretes = 0;
  double outros_segurro = 0;
  double outros_outros = 0;

  DavTotal();

  DavTotal.fromMap(Map map){
    bruto = double.parse(map['bruto'] ?? 0);
    liquido = double.parse(map['liquido'] ?? 0);
    entrada = double.parse(map['entrada'] ?? 0);
    peso_bruto = double.parse(map['peso']['bruto'] ?? 0);
    peso_liquido = double.parse(map['peso']['liquido'] ?? 0);
    desconto_itens = double.parse(map['desconto']['itens'] ?? 0);
    desconto_subtotal = double.parse(map['desconto']['subtotal'] ?? 0);
    desconto_total = double.parse(map['desconto']['total'] ?? 0);
    acrescimo_itens = double.parse(map['acrescimo']['itens'] ?? 0);
    acrescimo_subtotal = double.parse(map['acrescimo']['subtotal'] ?? 0);
    acrescimo_total = double.parse(map['acrescimo']['total'] ?? 0);
    subtotal = double.parse(map['subtotal'] ?? 0);
    tributos_icmsst = double.parse(map['tributos']['icmsst'] ?? 0);
    tributos_ipi = double.parse(map['tributos']['ipi'] ?? 0);
    outros_fretes = double.parse(map['outros']['frete'] ?? 0);
    outros_segurro = double.parse(map['outros']['seguro'] ?? 0);
    outros_outros = double.parse(map['outros']['outros'] ?? 0);
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'bruto': bruto,
      'liquido': liquido,
      'entrada': entrada,
      'subtotal': subtotal,
    };
    map['peso']['bruto'] = peso_bruto;
    map['peso']['liquido'] = peso_liquido;
    map['desconto']['itens'] = desconto_itens;
    map['desconto']['subtotal'] = desconto_subtotal;
    map['desconto']['total'] = desconto_total;
    map['acrescimo']['itens'] = acrescimo_itens;
    map['acrescimo']['subtotal'] = acrescimo_subtotal;
    map['acrescimo']['total'] = acrescimo_total;
    map['tributos']['icmsst'] = tributos_icmsst;
    map['tributos']['ipi'] = tributos_ipi;
    map['outros']['frete'] = tributos_ipi;
    map['outros']['seguro'] = tributos_ipi;
    map['outros']['outros'] = tributos_ipi;
    return map;
  }
}

class DavCliente {
  int codcliente = 0;
  String guidcliente = '';
  String cliente = "CONSUMIDOR...";
  String photo_link = '';
  String celular = '';
  String fone = '';
  String cpfcnpj = '';
  String email = '';
  Endereco endereco = Endereco();

  DavCliente();

  DavCliente.fromMap(Map map){
    codcliente = (map['codcliente'] ?? 0);
    guidcliente = (map['guidcliente'] ?? "");
    cliente = (map['cliente']) ?? "CONSUMIDOR...";
    photo_link = map['photo_link'] ?? "";
    celular = map['celular'] ?? "";
    fone = map['fone'] ?? "";
    cpfcnpj = (map['cpfcnpj'] ?? "");
    email = (map['email'] ?? "");
    if (map['endereco'] != null)
      endereco = Endereco.fromMap(map['endereco']);
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'codcliente': codcliente,
      'guidcliente': guidcliente,
      'cliente': cliente,
      'photo_link' : photo_link,
      'celular' : celular,
      'fone' : fone,
      'cpfcnpj': cpfcnpj,
      'email': email,
      'endereco' : endereco.toMap(),
    };
    return map;
  }
}

class DavPagamento{
  double pagamento_dinheiro = 0;
  DavAprazo aprazo = DavAprazo();
  DavCheque cheque = DavCheque();
  DavOutros outros = DavOutros();

  DavPagamento();

  DavPagamento.fromMap(Map map){
    pagamento_dinheiro = (map['pagamento']['dinheiro'] ?? 0);
    aprazo = DavAprazo.fromMap(map["aprazo"]);
    cheque = DavCheque.fromMap(map["cheque"]);
    outros = DavOutros.fromMap(map["outros"]);
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'aprazo': aprazo.toMap(),
      'cheque': cheque.toMap(),
      'outros': outros.toMap(),
    };
    map['pagamento']['dinheiro'] = pagamento_dinheiro;
    return map;
  }
}

class DavAprazo{
  double valor = 0;
  double codpgto = 0;
  double parcelas = 1;

  DavAprazo();

  DavAprazo.fromMap(Map map){
    valor = double.parse(map['valor'] ?? 0);
    codpgto = double.parse(map['codpgto'] ?? 0);
    parcelas = double.parse(map['parcelas'] ?? 1);
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'valor': valor,
      'codpgto': codpgto,
      'parcelas': parcelas,
    };
    return map;
  }

}

class DavCheque{
  double valor = 0;
  double codpgto = 0;
  double parcelas = 1;

  DavCheque();

  DavCheque.fromMap(Map map){
    valor = double.parse(map['valor'] ?? 0);
    codpgto = double.parse(map['codpgto'] ?? 0);
    parcelas = double.parse(map['parcelas'] ?? 1);
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'valor': valor,
      'codpgto': codpgto,
      'parcelas': parcelas,
    };
    return map;
  }

}

class DavOutros{
  double valor = 0;
  double codpgto = 0;
  double parcelas = 1;

  DavOutros();

  DavOutros.fromMap(Map map){
    valor = double.parse(map['valor'] ?? 0);
    codpgto = double.parse(map['codpgto'] ?? 0);
    parcelas = double.parse(map['parcelas'] ?? 1);
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'valor': valor,
      'codpgto': codpgto,
      'parcelas': parcelas,
    };
    return map;
  }

}

class DavItem{
  int item = 0;
  DavItemProduto produto = DavItemProduto();
  int codfuncionario = 0;
  String desfuncionario = '';
  double quantidade = 1;
  double unitario = 0;
  double unitarioliquido = 0;
  double custocompra = 0;
  DavItemProdutoTotal total = DavItemProdutoTotal();
  DavItemProdutoDesconto desconto = DavItemProdutoDesconto();
  DavItemProdutoAcrescimo acrescimo = DavItemProdutoAcrescimo();
  double frete = 0;
  double seguro = 0;
  double outros = 0;
  DateTime inclusao = DateTime.now();
  String observacao = '';
  double pesobruto = 0;
  double pesoliquido = 0;
  DateTime? deleted_at;

  DavItem();

  DavItem.fromMap(Map map){
    item = map['item'] ?? 0;
    produto = DavItemProduto.fromMap(map['produto']);
    codfuncionario = map['codfuncionario'] ?? 0;
    desfuncionario = map['desfuncionario'] ?? "";
    quantidade = double.parse(map['quantidade'] ?? 1);
    unitario = double.parse(map['unitario'] ?? 0);
    custocompra = double.parse(map['custocompra'] ?? 0);
    total = DavItemProdutoTotal.fromMap(map['total']);
    desconto = DavItemProdutoDesconto.fromMap(map['desconto']);
    acrescimo = DavItemProdutoAcrescimo.fromMap(map['acrescimo']);
    frete = map['frete'] ?? 0;
    seguro = map['seguro'] ?? 0;
    outros = map['outros'] ?? 0;
    if (map['inclusao'] != null)
      inclusao =  DateTime.parse(map['inclusao']);
    observacao = map['observacao'] ?? "";
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'item': item,
      'produto': produto.toMap(),
      'codfuncionario':codfuncionario,
      'desfuncionario':desfuncionario,
      'quantidade':quantidade,
      'unitario':unitario,
      'custocompra':custocompra,
      'total':total.toMap(),
      'desconto':desconto.toMap(),
      'acrescimo':acrescimo.toMap(),
      'frete':frete,
      'seguro':seguro,
      'outros':outros,
      'inclusao':DateFormat('yyyy-MM-dd').format(inclusao),
      'observacao':observacao,
      'pesobruto':pesobruto,
      'pesoliquido':pesoliquido,
      'deleted_at':deleted_at,
    };
    return map;
  }

}

class DavItemProduto{

  int codproduto = 0;
  int codigo = 0;
  String codbarra = '';
  String codalternativo = '';
  String descricao = '';
  String marca = '';
  String foto = '';
  String unidade = "UN";
  DavItemProdutoGrade grade = DavItemProdutoGrade();

  DavItemProduto();

  DavItemProduto.fromMap(Map map){
    codproduto = map['codproduto'] ?? 0;
    codigo = map['codigo'] ?? 0;
    codbarra = map['codbarra'] ?? "";
    codalternativo = map['codalternativo'] ?? "";
    descricao = map['descricao'] ?? "";
    marca = map['marca'] ?? "";
    foto = map['foto'] ?? "";
    unidade = map['unidade'] ?? "UN";
    grade = DavItemProdutoGrade.fromMap(map["grade"]);
  }


  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'codproduto':codproduto,
      'codigo':codigo,
      'codbarra':codbarra,
      'codalternativo':codalternativo,
      'descricao':descricao,
      'marca':marca,
      'foto':foto,
      'unidade':unidade,
      'grade':grade.toMap(),

    };
    return map;
  }
}

class DavItemProdutoGrade{
  int codgrade = 0;
  int seq = 0;
  String value1 = '';
  String value2 = '';
  String foto = '';

  DavItemProdutoGrade();

  DavItemProdutoGrade.fromMap(Map map){
    codgrade = map['codgrade'] ?? 0;
    seq = map['seq'] ?? 0;
    value1 = map['value1'] ?? "";
    value2 = map['value2'] ?? "";
    foto = map['foto'] ?? "";
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'codgrade':codgrade,
      'seq':seq,
      'value1':value1,
      'value2':value2,
    };
    return map;
  }

}

class DavItemProdutoTotal{
  double bruto = 0;
  double liquido = 0;
  double peso_bruto = 0;
  double peso_liquido = 0;

  DavItemProdutoTotal();

  DavItemProdutoTotal.fromMap(Map map){
    bruto = double.parse(map['bruto'] ?? 0);
    liquido = double.parse(map['liquido'] ?? 0);
    peso_bruto = double.parse(map['peso']['bruto'] ?? 0);
    peso_liquido = double.parse(map['peso']['bruto'] ?? 0);
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'bruto':bruto,
      'liquido':liquido,
      'peso_bruto':peso_bruto,
      'peso_liquido':peso_liquido,
    };
    return map;
  }

}

class DavItemProdutoDesconto{
  double item = 0 ;
  double rateado = 0;
  double total = 0;

  DavItemProdutoDesconto();



  DavItemProdutoDesconto.fromMap(Map map){
    item = double.parse(map['item'] ?? 0);
    rateado = double.parse(map['rateado'] ?? 0);
    total = double.parse(map['total'] ?? 0);
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'item':item,
      'rateado':rateado,
      'total':total,
    };
    return map;
  }

}

class DavItemProdutoAcrescimo{
  double item = 0;
  double rateado =0;
  double total = 0;

  DavItemProdutoAcrescimo();

  DavItemProdutoAcrescimo.fromMap(Map map){
    item = double.parse(map['item'] ?? 0);
    rateado = double.parse(map['rateado'] ?? 0);
    total = double.parse(map['total'] ?? 0);
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'item':item,
      'rateado':rateado,
      'total':total,
    };
    return map;
  }
}

class DavListItemCliente{
  String nome = '';
  String cpfcnp = '';
  String email = '';
  String photo_link = '';

  DavListItemCliente();

  DavListItemCliente.fromMap(Map map){
    nome = map['nome'] ?? "";
    cpfcnp = map['cpfcnp'] ?? "";
    email = map['email'] ?? "";
    photo_link = map['photo_link'] ?? "";
  }

}

class DavListItemTotal{
  double bruto = 0;
  double desconto = 0;
  double acrescimo = 0;
  double icmsst = 0;
  double ipi = 0;
  double frete = 0;
  double seguro = 0;
  double outros = 0;
  double liquido = 0;

  DavListItemTotal();

  DavListItemTotal.fromMap(Map map){
    bruto = double.parse(map['bruto'] ?? 0);
    desconto = double.parse(map['desconto'] ?? 0);
    acrescimo = double.parse(map['acrescimo'] ?? 0);
    icmsst = double.parse(map['icmsst'] ?? 0);
    ipi = double.parse(map['ipi'] ?? 0);
    frete = double.parse(map['frete'] ?? 0);
    seguro = double.parse(map['seguro'] ?? 0);
    outros = double.parse(map['outros'] ?? 0);
    liquido = double.parse(map['liquido'] ?? 0);
  }

}

class DavListItem{
  int coddav = 0;
  String guid = '';
  DavListItemCliente cliente = DavListItemCliente();
  String cancelado = '';
  int origem =  0;
  int validade = 0;
  int entrega = 1;
  String cidade = '';
  String vendedor = '';
  int numero = 0;
  DavTypes tipo = DavTypes.orcamento;
  String numeroalternativo = '';
  int numeroficha = 0;
  DavListItemTotal? total;
  DateTime? data;
  int tabelapreco = 0;
  String obs = '';

  DavListItem();

  DavListItem.fromMap(Map map){
    coddav = map['coddav'] ?? 0;
    guid = map['guid'] ?? "";
    cliente = DavListItemCliente.fromMap(map['cliente']);
    cancelado = map['cancelado'] ?? "";
    origem = map['origem'] ?? 0;
    tipo = DavTypes.values[map['tipo'] ?? DavTypes.orcamento];
    validade = map['validade'] ?? 0;
    entrega = map['entrega'] ?? 1;
    cidade = map['cidade'] ?? "";
    vendedor = map['vendedor'] ?? "";
    numero = map['numero'] ?? 0;
    if(numeroficha != 0)
      numeroficha = int.parse(map['numeroficha'], radix: 0);
    if(numeroalternativo != 0)
      numeroalternativo = map['numeroalternativo'];
    total = DavListItemTotal.fromMap(map['total'] ?? 0);
    data = DateTime.tryParse(map['data'] ?? "");
    if(tabelapreco != 0)
      tabelapreco = int.parse(map['tabelapreco'],radix:0);
    obs = map['obs'];
  }

}






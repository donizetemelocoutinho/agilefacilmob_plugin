import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:agilefacil_mob/helpers/helper.dart';
import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class DavApi {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>getDavList({@required int codloja,DateTime inicio, DateTime fim,int codclientes, int tipos,@required bool cancelado, int numero,
     int numeroalternativo,int numeroficha, @required int startrow, @required String api_token})async{

    ApiHelper api = ApiHelper();

    Map<String, String> _params ={"codloja": codloja.toString(),"cancelado": cancelado ? "S" : "N","startrow":startrow.toString(), "api_token" : api_token};

    if (inicio != 0)
      _params["inicio"] = inicio.toString();

    if (fim != 0)
      _params["fim"] = inicio.toString();

    if (codclientes != 0)
      _params["codclientes"] = codclientes.toString();

    if (tipos != 0)
      _params["tipos"] = tipos.toString();

    return await api.get("dav/list",params:_params);
  }

  Future<Map>get({@required int codloja, @required int coddav,@required String api_token})async{
    ApiHelper api = ApiHelper();
    return await api.get("dav/edit", params: {"codloja": codloja.toString(),"coddav":coddav.toString(),"api_token":api_token });
  }

  Future<Map>storeDav({@required String api_token, @required Dav dav})async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> jo = dav.toMap();
    return await api.post("dav", jo,params:{"api_token": api_token});

  }
}

class DavHelper {

}

class Dav{
  String guid = Helper.newGuid();
  int coddav;
  int codusuario;
  int codcliente;
  int codfuncionario;
  int codloja;
  int numero;
  int tipo;
  DateTime digitacao = DateTime.now();
  int tabelapreco;
  String observacao;
  int numeroalternativo;
  int numeroficha;
  int tpcondicional;
  DavTotal total = DavTotal();
  DavCliente cliente = DavCliente();
  String cancelado;
  String faturado;
  int origem;
  int validade;
  int entrega;
  DavPagamento pagamento = DavPagamento();
  int codgprDocumento = 0;
  List<DavItem> itens = [];

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

    for (int i = 0; i < itens.length -1; i++) {
      total.bruto = total.bruto + itens[i].total.bruto;
      total.desconto_itens = total.desconto_itens + itens[i].desconto.item;
      total.acrescimo_itens = total.acrescimo_itens + itens[i].acrescimo.item;
      total.peso_liquido = total.peso_liquido + itens[i].pesoliquido;
      total.peso_bruto = total.peso_bruto + itens[i].total.peso_bruto;
      total.subtotal = total.bruto - total.desconto_itens + total.acrescimo_itens;
      total.liquido = total.subtotal - total.desconto_total + total.acrescimo_itens;
    }
  }

  Dav.fromMap(Map map){
    coddav = map['coddav'];
    guid = map['guid'];
    codusuario = map['codusuario'];
    codfuncionario = map['codfuncionario'];
    codloja = map['codloja'];
    numero = map['numero'];
    tipo = map['tipo'];

    if (map['digitacao'] != null)
      digitacao =  DateTime.parse(map['digitacao']);

    tabelapreco = map['tabelapreco'];
    numeroficha = map['numeroficha'];
    observacao = map['observacao'];
    numeroalternativo = map['numeroalternativo'];
    tpcondicional = map['tpcondicional'];
    total = DavTotal.fromMap(map["total"]);
    cliente = DavCliente.fromMap(map["cliente"]);
    pagamento = DavPagamento.fromMap(map['pagamento']);

    if (map['itens'] != null) {
      for (int i = 0; i < map['itens'].length; i++) {
        itens.add(DavItem.fromMap(map['itens'][i]));
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
       'tabelapreco': tabelapreco,
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
  double bruto;
  double liquido;
  double entrada;
  double peso_bruto;
  double peso_liquido;
  double desconto_itens;
  double desconto_subtotal;
  double desconto_total;
  double acrescimo_itens;
  double acrescimo_subtotal;
  double acrescimo_total;
  double subtotal;
  double tributos_icmsst;
  double tributos_ipi;
  double outros_fretes;
  double outros_segurro;
  double outros_outros;

  DavTotal();

  DavTotal.fromMap(Map map){
    bruto = double.parse(map['bruto']);
    liquido = double.parse(map['liquido']);
    entrada = double.parse(map['entrada']);
    peso_bruto = double.parse(map['peso']['bruto']);
    peso_liquido = double.parse(map['peso']['liquido']);
    desconto_itens = double.parse(map['desconto']['itens']);
    desconto_subtotal = double.parse(map['desconto']['subtotal']);
    desconto_total = double.parse(map['desconto']['total']);
    acrescimo_itens = double.parse(map['acrescimo']['itens']);
    acrescimo_subtotal = double.parse(map['acrescimo']['subtotal']);
    acrescimo_total = double.parse(map['acrescimo']['total']);
    subtotal = double.parse(map['subtotal']);
    tributos_icmsst = double.parse(map['tributos']['icmsst']);
    tributos_ipi = double.parse(map['tributos']['ipi']);
    outros_fretes = double.parse(map['outros']['frete']);
    outros_segurro = double.parse(map['outros']['seguro']);
    outros_outros = double.parse(map['outros']['outros']);
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
  int codcliente;
  String guidcliente;
  String cliente = "CONSUMIDOR...";
  String photo_link;
  String celular;
  String fone;
  String cpfcnpj;
  String email;
  Endereco endereco = Endereco();

  DavCliente();

  DavCliente.fromMap(Map map){
    codcliente = (map['codcliente']);
    guidcliente = (map['guidcliente']);
    cliente = (map['cliente']);
    photo_link = map['photo_link'];
    celular = map['celular'];
    fone = map['fone'];
    cpfcnpj = (map['cpfcnpj']);
    email = (map['email']);
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
  double pagamento_dinheiro;
  DavAprazo aprazo = DavAprazo();
  DavCheque cheque = DavCheque();
  DavOutros outros = DavOutros();

  DavPagamento();

  DavPagamento.fromMap(Map map){
    pagamento_dinheiro = (map['pagamento']['dinheiro']);
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
    valor = double.parse(map['valor']);
    codpgto = double.parse(map['codpgto']);
    parcelas = double.parse(map['parcelas']);
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
    valor = double.parse(map['valor']);
    codpgto = double.parse(map['codpgto']);
    parcelas = double.parse(map['parcelas']);
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
    valor = double.parse(map['valor']);
    codpgto = double.parse(map['codpgto']);
    parcelas = double.parse(map['parcelas']);
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
  int codfuncionario;
  String desfuncionario;
  double quantidade;
  double unitario;
  double unitarioliquido = 0;
  double custocompra;
  DavItemProdutoTotal total = DavItemProdutoTotal();
  DavItemProdutoDesconto desconto = DavItemProdutoDesconto();
  DavItemProdutoAcrescimo acrescimo = DavItemProdutoAcrescimo();
  double frete;
  double seguro;
  double outros;
  DateTime inclusao = DateTime.now();
  String observacao;
  double pesobruto = 0;
  double pesoliquido = 0;

  DavItem();

  DavItem.fromMap(Map map){
    item = map['item'];
    produto = DavItemProduto.fromMap(map['produto']);
    codfuncionario = map['codfuncionario'];
    desfuncionario = map['desfuncionario'];
    quantidade = double.parse(map['quantidade']);
    unitario = double.parse(map['unitario']);
    custocompra = double.parse(map['custocompra']);
    total = DavItemProdutoTotal.fromMap(map['total']);
    desconto = DavItemProdutoDesconto.fromMap(map['desconto']);
    acrescimo = DavItemProdutoAcrescimo.fromMap(map['acrescimo']);
    frete = map['frete'];
    seguro = map['seguro'];
    outros = map['outros'];
    if (map['inclusao'] != null)
      inclusao =  DateTime.parse(map['inclusao']);
    observacao = map['observacao'];
  }
}

class DavItemProduto{

  int codproduto = 55;
  int codigo = 55;
  String codbarra;
  String codalternativo;
  String descricao;
  String marca;
  String foto;
  String unidade;
  DavItemProdutoGrade grade = DavItemProdutoGrade();

  DavItemProduto();


  DavItemProduto.fromMap(Map map){
    codproduto = map['codproduto'];
    codigo = map['codigo'];
    codbarra = map['codbarra'];
    codalternativo = map['codalternativo'];
    descricao = map['descricao'];
    marca = map['marca'];
    foto = map['foto'];
    unidade = map['unidade'];
    grade = DavItemProdutoGrade.fromMap(map["grade"]);
  }

}

class DavItemProdutoGrade{
  int codgrade = 0;
  int seq = 0;
  String value1;
  String value2;

  DavItemProdutoGrade();

  DavItemProdutoGrade.fromMap(Map map){
    codgrade = map['codgrade'];
    seq = map['seq'];
    value1 = map['value1'];
    value2 = map['value2'];
  }

}

class DavItemProdutoTotal{
  double bruto;
  double liquido;
  double peso_bruto;
  double peso_liquido;

  DavItemProdutoTotal();

  DavItemProdutoTotal.fromMap(Map map){
    bruto = double.parse(map['bruto']);
    liquido = double.parse(map['liquido']);
    peso_bruto = double.parse(map['peso']['bruto']);
    peso_liquido = double.parse(map['peso']['bruto']);

  }

}

class DavItemProdutoDesconto{
  double item;
  double rateado;
  double total;

  DavItemProdutoDesconto(){

  }

  DavItemProdutoDesconto.fromMap(Map map){
    item = double.parse(map['item']);
    rateado = double.parse(map['rateado']);
    total = double.parse(map['total']);
  }

}

class DavItemProdutoAcrescimo{
  double item;
  double rateado;
  double total;

  DavItemProdutoAcrescimo();

  DavItemProdutoAcrescimo.fromMap(Map map){
    item = double.parse(map['item']);
    rateado = double.parse(map['rateado']);
    total = double.parse(map['total']);
  }

}

class DavListItemCliente{
  String nome;
  String cpfcnp;
  String email;
  String photo_link;

  DavListItemCliente();

  DavListItemCliente.fromMap(Map map){
    nome = map['nome'];
    cpfcnp = map['cpfcnp'];
    email = map['email'];
    photo_link = map['photo_link'];
  }

}

class DavListItemTotal{
  double bruto;
  double desconto;
  double acrescimo;
  double icmsst;
  double ipi;
  double frete;
  double seguro;
  double outros;
  double liquido;

  DavListItemTotal();

  DavListItemTotal.fromMap(Map map){
    bruto = double.parse(map['bruto']);
    desconto = double.parse(map['desconto']);
    acrescimo = double.parse(map['acrescimo']);
    icmsst = double.parse(map['icmsst']);
    ipi = double.parse(map['ipi']);
    frete = double.parse(map['frete']);
    seguro = double.parse(map['seguro']);
    outros = double.parse(map['outros']);
    liquido = double.parse(map['liquido']);
  }

}

class DavListItem{
  int coddav;
  String guid;
  DavListItemCliente cliente = DavListItemCliente();
  String cancelado;
  int origem;
  int validade;
  int entrega;
  String cidade;
  String vendedor;
  int numero;
  String numeroalternativo;
  int numeroficha;
  DavListItemTotal total;
  DateTime data;
  int tabelapreco;
  String obs;

  DavListItem();

  DavListItem.fromMap(Map map){
    coddav = map['coddav'];
    guid = map['guid'];
    cliente = DavListItemCliente.fromMap(map['cliente']);
    cancelado = map['cancelado'];
    origem = map['origem'];
    validade = map['validade'];
    entrega = map['entrega'];
    cidade = map['cidade'];
    vendedor = map['vendedor'];
    numero = map['numero'];
    numeroalternativo = map['numeroalternativo'];
    numeroficha = map['numeroficha'];
    total = DavListItemTotal.fromMap(map['total']);
    data = DateTime.parse(map['data']);
    tabelapreco = map['tabelapreco'] == null ? 0 : map['tabelapreco'];
    obs = map['obs'];
  }

}






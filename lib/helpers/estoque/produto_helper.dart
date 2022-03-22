import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../api_helper.dart';

enum ProdutoFiltroEstoque {todos,comestoque,semestoque}

class ProdutoApi {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>getList({required int codloja,int ?codmarca,int ?codsubgrupo,required ProdutoFiltroEstoque estoque,required int startrow,
    required String search,required String api_token,required bool ativo})async{
    ApiHelper api = ApiHelper();

    Map<String, String> _params = {"codloja": codloja.toString(),"search": search,"startrow": startrow.toString(), "ativo": ativo ? "S" : "N","api_token": api_token,
    "estoque": estoque.index.toString()};

    if ((codmarca != 0) && (codmarca != null))
      _params["codmarca"] = codmarca.toString();

    if ((codsubgrupo != 0) && (codsubgrupo != null))
      _params["codcategoria"] = codsubgrupo.toString();


    return await api.get("estoque/produto/list",params: _params);
  }

  Future<Map>get({required int codloja, required int codproduto,required String api_token})async{
    ApiHelper api = ApiHelper();
    return await api.get("estoque/produto/edit", params: {"codloja":codloja.toString(),"codproduto":codproduto.toString(),"api_token":api_token});
  }

  Future<List>getListPreco({required int codloja, required List<int> codprodutos, required String api_token })async{
    ApiHelper api = ApiHelper();
    String produtos = jsonEncode(codprodutos);
    return await api.get("estoque/produto/preco/list", params: {"codloja":codloja.toString(),"codprodutos":produtos,"api_token":api_token});
  }

}

class ProdutoParcela{
  int numero = 0;
  double parcela = 0.00;
  double total = 0.00;

  ProdutoParcela.fromMap(Map map){
    numero = map['numero'];
    parcela = double.parse(map['parcela']);
    total = double.parse(map['total']);
  }

}

class ProdutoComissao{
  double avista = 0.00;
  double aprazo = 0.00;
  ProdutoComissao();

  ProdutoComissao.fromMap(Map map){
    avista = double.parse(map['avista']);
    aprazo = double.parse(map['aprazo']);
  }

}

class ProdutoTributacao{
  int codcategoria = 0;
  String idcategoria = '';
  String categoria = '';
  int codncm = 0;
  String ncm = '';
  String anp = '';

  ProdutoTributacao();

  ProdutoTributacao.fromMap(Map map){
    codcategoria = map['codcategoria'];
    idcategoria = map['idcategoria'];
    categoria = map['categoria'];
    codncm = map['codncm'];
    ncm = map['ncm'];
    anp = map['anp'];
  }

}

class ProdutoEmbalagemTipo{
  int codunidade = 0;
  String idunidade = '';
  String unidade = '';

  ProdutoEmbalagemTipo();

  ProdutoEmbalagemTipo.fromMap(Map map){
    codunidade = map['codunidade'];
    idunidade = map['idunidade'];
    unidade = map['unidade'];
  }

}

class ProdutoEmbalagemConversao{
  int tipo = 0;
  double fator = 0.00;

  ProdutoEmbalagemConversao();

  ProdutoEmbalagemConversao.fromMap(Map map){
    tipo = map['tipo'];
    fator = double.parse(map['fator']);
  }
}

class ProdutoEmbalagem{
  ProdutoEmbalagemTipo compra = ProdutoEmbalagemTipo();
  ProdutoEmbalagemConversao conversao = ProdutoEmbalagemConversao();
  ProdutoEmbalagemTipo venda = ProdutoEmbalagemTipo();
  double pesoliquido = 0.00;
  double pesobruto = 0.00;

  ProdutoEmbalagem();

  ProdutoEmbalagem.fromMap(Map map){
    compra = ProdutoEmbalagemTipo.fromMap(map['compra']);
    conversao = ProdutoEmbalagemConversao.fromMap(map['conversao']);
    venda = ProdutoEmbalagemTipo.fromMap(map['venda']);
    pesoliquido = double.parse(map['venda']["pesoliquido"]);
    pesobruto = double.parse(map['venda']["pesobruto"]);
  }
}

class ProdutoInsChange{
  int codusuario = 0;
  String idusuario = '';
  String login = '';
  DateTime ?cadastro;
  DateTime ?modificacao;

  ProdutoInsChange();

  ProdutoInsChange.fromMap(Map map){
    codusuario = map['codusuario'];
    idusuario = map['idusuario'];
    login = map['login'];
    cadastro = ((map['cadastro'] != null) ? DateTime.parse(map['cadastro']) : null);
    modificacao = ((map['modificacao'] != null) ? DateTime.parse(map['cadastro']) : null);
  }

}

class ProdutoBalanca{
  String exporta = 'N';
  String acionanocaixa = 'N';
  int diasvalidade = 0;

  ProdutoBalanca();

  ProdutoBalanca.fromMap(Map map){
    exporta = map['exporta'];
    acionanocaixa =  map['acionanocaixa'];
    diasvalidade = int.parse(map['diasvalidade']);
  }
}

class ProdutoEstoque{
  double saldo = 0.00;
  double reservado = 0.00;
  DateTime ?dataentrada;
  DateTime ?datasaida;
  double minimo = 0.00;
  double ideal = 0.00;
  String localizacao = '';
  int diasreposicao = 0;
  DateTime ?atualizacao;

  ProdutoEstoque();

  ProdutoEstoque.fromMap(Map map){
    saldo = double.parse(map['saldo']);
    reservado = double.parse(map['reservado']);
    dataentrada = ((map['dataentrada'] != null) ? DateTime.parse(map['dataentrada']) : null);
    datasaida = ((map['datasaida'] != null) ? DateTime.parse(map['datasaida']) : null);
    minimo = double.parse(map['minimo']);
    ideal = double.parse(map['ideal']);
    localizacao = map['localizacao'];
    diasreposicao = map['diasreposicao'];
    atualizacao = ((map['atualizacao'] != null) ? DateTime.parse(map['atualizacao']) : null);
  }
}

class ProdutoPreco{
  double valor = 0.00;
  double valor_com_desconto = 0.00;
  double lucro = 0.00;
  double minimo = 0.00;
  double valoranterior = 0.00;
  DateTime ?atualizacao;

  ProdutoPreco();

  ProdutoPreco.fromMap(Map map){
    valor = double.parse(map['valor']);
    lucro = double.parse(map['lucro']);
    minimo = double.parse(map['minimo']);
    valoranterior = double.parse(map['valoranterior']);
    atualizacao = ((map['atualizacao'] != null) ? DateTime.parse(map['atualizacao']) : null);
  }
}

class ProdutoCompra{
  double preco = 0.00;
  double custo = 0.00;
  double frete = 0.00;
  double acrescimo = 0.00;
  double seguro = 0.00;
  double despesas = 0.00;
  double desconto = 0.00;
  double icmsst = 0.00;
  double icms = 0.00;
  double pis = 0.00;
  double cofins = 0.00;
  double ipi = 0.00;
  DateTime ?data;
  int codfornecedor = 0;
  String guidfornecedor = '';
  String fornecedor = '';

  ProdutoCompra();

  ProdutoCompra.fromMap(Map map){
    preco = double.parse(map['preco']);
    custo = double.parse(map['custo']);
    frete = double.parse(map['frete']);
    acrescimo = double.parse(map['acrescimo']);
    seguro = double.parse(map['acrescimo']);
    despesas = double.parse(map['acrescimo']);
    desconto = double.parse(map['acrescimo']);
    icmsst = double.parse(map['acrescimo']);
    icms = double.parse(map['acrescimo']);
    pis = double.parse(map['acrescimo']);
    cofins = double.parse(map['acrescimo']);
    ipi = double.parse(map['acrescimo']);
    data = DateTime.parse(map['data']);
    codfornecedor = int.parse(map['codfornecedor']);
    guidfornecedor = map['guidfornecedor'];
    fornecedor = map['fornecedor'];
  }


}

class ProdutoGrade{
  int codgrade = 0;
  int seq = 0;
  int codalternativo = 0;
  String codbarra = '';
  String val1 = '';
  String val2 = '';
  double estoque = 0.00;
  double reservado = 0.00;
  String foto = '';
  String guid = '';

  ProdutoGrade();

  ProdutoGrade.fromMap(Map map){
    codgrade = map["codgrade"];
    seq = map["seq"];
    codalternativo = map["codalternativo"];
    codbarra = map["codbarra"];
    val1 = map["val1"];
    val2 = map["val2"];
    estoque = (map['estoque'] == null) ? 0 : double.parse(map['estoque'].toString());
    reservado = (map['reservado'] == null) ? 0 : double.parse(map['reservado'].toString());
    foto = map["foto"];
    guid = map["guid"];
  }
}

class Produto{
  int codproduto = 0;
  String guid = '';
  int codigo = 0;
  int codloja = 0;
  String idloja = '';
  String codbarra = '';
  String codalternativo = '';
  int tipo = 0;
  String descricao = '';
  String foto = '';
  ProdutoComissao ?comissao;
  ProdutoTributacao ?tributacao;
  ProdutoEmbalagem ?embalagem;
  int codmarca = 0;
  String idmarca = '';
  String marca = '';
  int codsubgrupo = 0;
  String idsubgrupo = '';
  String subgrupo = '';
  ProdutoInsChange ?modificacao;
  String aplicacao = '';
  String infoadicional = '';
  String temgrade = 'N';
  String ativo = 'S';
  String pdvfavorito= 'N';
  ProdutoEstoque ?estoque;
  ProdutoPreco ?preco;
  ProdutoPreco ?preco_especial;
  List<ProdutoParcela> parcelas = [];
  double parcela_max_valor = 0;
  double parcela_max_total = 0;
  int parcela_max_numero = 0;
  List<ProdutoGrade> grade = [];
  Produto();

  Produto.fromMap(Map map){
    codproduto = map["codproduto"];
    guid = map["guid"];
    codigo = map["codigo"];
    codloja = map["codloja"];
    idloja = map["idloja"];
    codbarra = map["codbarra"];
    codalternativo = map["codalternativo"];
    tipo = map["tipo"];
    descricao = map["descricao"];
    foto = map["foto"];
    comissao = ProdutoComissao.fromMap(map["comissao"]);
    tributacao = ProdutoTributacao.fromMap(map["tributacao"]);
    embalagem = ProdutoEmbalagem.fromMap(map["embalagem"]);
    codmarca = map["codmarca"];
    idmarca = map["idmarca"];
    codsubgrupo = map["codsubgrupo"];
    idsubgrupo = map["idsubgrupo"];
    subgrupo = map["subgrupo"];
    modificacao = ProdutoInsChange.fromMap(map["modificacao"]);
    aplicacao = map["aplicacao"];
    infoadicional = map["infoadicional"];
    temgrade = map["temgrade"];
    ativo = map["ativo"];
    pdvfavorito = map["pdvfavorito"];
    estoque = ProdutoEstoque.fromMap(map["estoque"]);
    preco = ProdutoPreco.fromMap(map["preco"]);
    preco?.valor_com_desconto = double.parse(map['preco']['valor_com_desconto']);
    preco_especial = ProdutoPreco.fromMap(map["preco"]["especial"]);
    if(map['parcelas'] != null) {
      for (int i = 0; i < map['parcelas'].length; i++) {
        ProdutoParcela parcela = ProdutoParcela.fromMap(map['parcelas'][i]);
        parcelas.add(parcela);
        parcela_max_numero = parcela.numero;
        parcela_max_valor = parcela.parcela;
        parcela_max_total = parcela.total;
      }
    }
    if (map['grade'] != null) {
      map['grade'].forEach((v) {
        grade.add(new ProdutoGrade.fromMap(v));
      });
    }
  }


}

class ProdutoListItemPromocao {
  DateTime inicio = DateTime.now();
  DateTime fim = DateTime.now();
  double valor= 0.00;

  ProdutoListItemPromocao();

  ProdutoListItemPromocao.fromMap(Map map){

    if (map['inicio'] != null)
      inicio =  DateTime.parse(map['inicio']);

    if (map['fim'] != null)
      fim =  DateTime.parse(map['fim']);

    valor = double.parse(map['valor']);

  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'inicio': DateFormat('yyyy-MM-dd').format(inicio),
      'fim': DateFormat('yyyy-MM-dd').format(fim),
      'valor': valor,
    };
    return map;
  }
}

class ProdutoListItem{
  int codproduto = 55;
  String guid = "";
  int codigo = 55;
  String codbarra = "";
  String codalternativo = "";
  String descricao = "";
  int tipo = 0;
  String marca = "";
  String grupo = "";
  String subgrupo = "";
  String categoriatrib = "";
  String anp = "";
  String ncm = "";
  String unidadecompra = "";
  int conversaotipo = 0;
  double conversaofator = 1;
  String unidadevenda = 'UN';
  String fotolink = "";
  double ?preco;
  ProdutoListItemPromocao ?promocao = ProdutoListItemPromocao();
  double precoespecial = 0.00;
  double estoque = 0.00;
  double reserva = 0.00;
  List<ProdutoParcela> parcelas = [];
  double parcela_max_valor = 0;
  double parcela_max_total = 0;
  int parcela_max_numero = 0;
  List<ProdutoGrade> grade = [];

  ProdutoListItem();

  ProdutoListItem.fromMap(Map map){
    codproduto = map['codproduto'];
    guid = map['guid'];
    codigo = map['codigo'];
    codbarra = map['codbarra'];
    codalternativo = map['codalternativo'];
    descricao = map['descricao'];
    tipo = map['tipo'];
    marca = map['marca'];
    grupo = map['grupo'];
    subgrupo = map['subgrupo'];
    categoriatrib = map['categoriatrib'];
    anp = map['anp'];
    ncm = map['ncm'];
    unidadecompra = map['unidadecompra'];
    conversaotipo = map['conversaotipo'];
    conversaofator = double.parse(map['conversaofator']);
    unidadevenda = map['unidadevenda'];
    fotolink = map['fotolink'];
    preco = map['preco'];
    promocao = ProdutoListItemPromocao.fromMap(map['promocao']);
    precoespecial = double.parse(map['precoespecial']);
    estoque = double.parse(map['estoque']);
    reserva = double.parse(map['reserva']);

    if (map['grade'] != null) {
      map['grade'].forEach((v) {
        grade.add(new ProdutoGrade.fromMap(v));
      });
    }

    if(map['parcelas'] != null) {
      for (int i = 0; i < map['parcelas'].length; i++) {
        ProdutoParcela parcela = ProdutoParcela.fromMap(map['parcelas'][i]);

        parcelas.add(parcela);

        parcela_max_numero = parcela.numero;
        parcela_max_valor = parcela.parcela;
        parcela_max_total = parcela.total;

      }
    }

  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'codproduto': codproduto,
      'codigo': codigo,
      'guid': guid,
      'codbarra': codbarra,
      'codalternativo': codalternativo,
      'descricao': descricao,
      'tipo': tipo,
      'marca': marca,
      'subgrupo': subgrupo,
      'categoriatrib': categoriatrib,
      'anp': anp,
      'ncm': ncm,
      'unidadecompra': unidadecompra,
      'conversaotipo': conversaotipo,
      'conversaofator': conversaofator,
      'unidadevenda': unidadevenda,
      'foto': fotolink,
      'preco': preco,
      'promocao': promocao?.toMap(),
      'precoespecial': precoespecial,
      'estoque': estoque,
      'reserva': reserva,

    };
    return map;
  }
}

class ProdutoPrecoListItem{
  int codproduto = 0;
  double preco = 0.00;
  double preco_com_desconto = 0.00;
  ProdutoListItemPromocao promocao = ProdutoListItemPromocao();
  double precoespecial = 0.00;

  ProdutoPrecoListItem();

  ProdutoPrecoListItem.fromMap(Map map){
    codproduto = map["codproduto"];
    preco = double.parse(map['preco']);
    preco_com_desconto = double.parse(map['preco_com_desconto']);
    promocao = ProdutoListItemPromocao.fromMap(map['promocao']);
    precoespecial = double.parse(map['precoespecial']);
  }
}
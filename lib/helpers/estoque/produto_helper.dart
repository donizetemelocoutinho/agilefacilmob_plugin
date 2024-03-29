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

  Future<Map>getList({required int codloja,int? codmarca,int? codsubgrupo,required ProdutoFiltroEstoque estoque,required int startrow,
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
    numero = map['numero'] ?? 0;
    parcela = double.parse(map['parcela'] ?? 0);
    total = double.parse(map['total'] ?? 0);
  }

}

class ProdutoComissao{
  double avista = 0.00;
  double aprazo = 0.00;
  ProdutoComissao();

  ProdutoComissao.fromMap(Map map){
    avista = double.parse(map['avista'] ?? 0);
    aprazo = double.parse(map['aprazo'] ?? 0);
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
    codcategoria = map['codcategoria'] ?? 0;
    idcategoria = map['idcategoria'] ?? "";
    categoria = map['categoria'] ?? "";
    codncm = map['codncm'] ?? 0;
    ncm = map['ncm'] ?? "";
    anp = map['anp'] ?? "";
  }

}

class ProdutoEmbalagemTipo{
  int codunidade = 0;
  String idunidade = '';
  String unidade = '';

  ProdutoEmbalagemTipo();

  ProdutoEmbalagemTipo.fromMap(Map map){
    codunidade = map['codunidade'] ?? 0;
    idunidade = map['idunidade'] ?? "";
    unidade = map['unidade'] ?? "";
  }

}

class ProdutoEmbalagemConversao{
  int tipo = 0;
  double fator = 0.00;

  ProdutoEmbalagemConversao();

  ProdutoEmbalagemConversao.fromMap(Map map){
    tipo = map['tipo'] ?? 0;
    fator = double.parse(map['fator'] ?? 0);
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
  DateTime? cadastro;
  DateTime? modificacao;

  ProdutoInsChange();

  ProdutoInsChange.fromMap(Map map){
    codusuario = map['codusuario'] ?? 0;
    idusuario = map['idusuario'] ?? "";
    login = map['login'] ?? "";
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
    exporta = map['exporta'] ?? "N";
    acionanocaixa =  map['acionanocaixa'] ?? "N";
    diasvalidade = int.parse(map['diasvalidade']);
  }
}

class ProdutoEstoque{
  double saldo = 0.00;
  double reservado = 0.00;
  DateTime? dataentrada;
  DateTime? datasaida;
  double minimo = 0.00;
  double ideal = 0.00;
  String localizacao = '';
  int diasreposicao = 0;
  DateTime? atualizacao;

  ProdutoEstoque();

  ProdutoEstoque.fromMap(Map map){
    saldo = double.parse(map['saldo'] ?? 0);
    reservado = double.parse(map['reservado'] ?? 0);
    dataentrada = ((map['dataentrada'] != null) ? DateTime.parse(map['dataentrada']) : null);
    datasaida = ((map['datasaida'] != null) ? DateTime.parse(map['datasaida']) : null);
    minimo = double.parse(map['minimo']);
    ideal = double.parse(map['ideal'] ?? 0);
    localizacao = map['localizacao'] ?? "";
    diasreposicao = map['diasreposicao'] ?? 0;
    atualizacao = ((map['atualizacao'] != null) ? DateTime.parse(map['atualizacao']) : null);
  }
}

class ProdutoPreco{
  double valor = 0.00;
  double valor_com_desconto = 0.00;
  double lucro = 0.00;
  double minimo = 0.00;
  double valoranterior = 0.00;
  DateTime? atualizacao;

  ProdutoPreco();

  ProdutoPreco.fromMap(Map map){
    valor = double.parse(map['valor'] ?? 0);
    lucro = double.parse(map['lucro']  ?? 0);
    minimo = double.parse(map['minimo']  ?? 0);
    valoranterior = double.parse(map['valoranterior'] ?? 0);
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
  DateTime? data;
  int codfornecedor = 0;
  String guidfornecedor = '';
  String fornecedor = '';

  ProdutoCompra();

  ProdutoCompra.fromMap(Map map){
    preco = double.parse(map['preco'] ?? 0);
    custo = double.parse(map['custo'] ?? 0);
    frete = double.parse(map['frete'] ?? 0);
    acrescimo = double.parse(map['acrescimo'] ?? 0);
    seguro = double.parse(map['acrescimo'] ?? 0);
    despesas = double.parse(map['acrescimo'] ?? 0);
    desconto = double.parse(map['acrescimo'] ?? 0);
    icmsst = double.parse(map['acrescimo'] ?? 0);
    icms = double.parse(map['acrescimo'] ?? 0);
    pis = double.parse(map['acrescimo'] ?? 0);
    cofins = double.parse(map['acrescimo'] ?? 0);
    ipi = double.parse(map['acrescimo'] ?? 0);
    data = DateTime.tryParse(map['data'] ?? "");
    codfornecedor = int.parse(map['codfornecedor'] ?? 0);
    guidfornecedor = map['guidfornecedor'] ?? "";
    fornecedor = map['fornecedor'] ?? "";
  }


}

class ProdutoGrade{
  int codgrade = 0;
  int seq = 0;
  String codalternativo = "";
  String codbarra = '';
  String val1 = '';
  String val2 = '';
  double estoque = 0.00;
  double reservado = 0.00;
  String foto = '';
  String guid = '';

  ProdutoGrade();

  ProdutoGrade.fromMap(Map map){
    codgrade = map["codgrade"] ?? 0;
    seq = map["seq"] ?? 0;
    codalternativo = map["codalternativo"] ?? "";
    codbarra = map["codbarra"] ?? "";
    val1 = map["val1"] ?? "";
    val2 = map["val2"] ?? "";
    estoque = (map['estoque'] == null) ? 0 : double.parse(map['estoque'].toString());
    reservado = (map['reservado'] == null) ? 0 : double.parse(map['reservado'].toString());
    foto = map["foto"] ?? "";
    guid = map["guid"] ?? "";
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
  ProdutoComissao? comissao;
  ProdutoTributacao? tributacao;
  ProdutoEmbalagem? embalagem;
  int codmarca = 0;
  String idmarca = '';
  String marca = '';
  int codsubgrupo = 0;
  String idsubgrupo = '';
  String subgrupo = '';
  ProdutoInsChange? modificacao;
  String aplicacao = '';
  String infoadicional = '';
  String temgrade = 'N';
  String ativo = 'S';
  String pdvfavorito= 'N';
  ProdutoEstoque? estoque;
  ProdutoPreco? preco;
  ProdutoPreco? preco_especial;
  List<ProdutoParcela> parcelas = [];
  double parcela_max_valor = 0;
  double parcela_max_total = 0;
  int parcela_max_numero = 0;
  List<ProdutoGrade> grade = [];

  Produto();

  Produto.fromMap(Map map){
    codproduto = map["codproduto"] ?? 0;
    guid = map["guid"] ?? "";
    codigo = map["codigo"] ?? 0;
    codloja = map["codloja"] ?? 0;
    idloja = map["idloja"]  ?? "";
    codbarra = map["codbarra"] ?? "";
    codalternativo = map["codalternativo"] ?? "";
    tipo = map["tipo"] ?? 0;
    descricao = map["descricao"] ?? "";
    foto = map["foto"] ?? "";
    comissao = ProdutoComissao.fromMap(map["comissao"]);
    tributacao = ProdutoTributacao.fromMap(map["tributacao"]);
    embalagem = ProdutoEmbalagem.fromMap(map["embalagem"]);
    codmarca = map["codmarca"] ?? 0;
    idmarca = map["idmarca"] ??  "";
    codsubgrupo = map["codsubgrupo"] ?? 0;
    idsubgrupo = map["idsubgrupo"] ?? "";
    subgrupo = map["subgrupo"] ?? "";
    modificacao = ProdutoInsChange.fromMap(map["modificacao"]);
    aplicacao = map["aplicacao"] ?? "";
    infoadicional = map["infoadicional"] ?? "";
    temgrade = map["temgrade"] ?? "N";
    ativo = map["ativo"] ?? "S";
    pdvfavorito = map["pdvfavorito"] ?? "N";
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

    valor = double.parse(map['valor'] ?? 0);

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
  int codproduto = 0;
  String guid = "";
  int codigo = 0;
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
  double? preco;
  ProdutoListItemPromocao? promocao = ProdutoListItemPromocao();
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
    codproduto = map['codproduto'] ?? 0;
    guid = map['guid'] ?? "";
    codigo = map['codigo'] ?? 0;
    codbarra = map['codbarra'] ?? "";
    codalternativo = map['codalternativo'] ?? "";
    descricao = map['descricao'] ?? "";
    tipo = map['tipo'] ?? 0;
    marca = map['marca'] ?? "";
    grupo = map['grupo'] ?? "";
    subgrupo = map['subgrupo'] ?? "";
    categoriatrib = map['categoriatrib'] ?? "";
    anp = map['anp'] ?? "";
    ncm = map['ncm'] ?? "";
    unidadecompra = map['unidadecompra'] ?? "";
    conversaotipo = map['conversaotipo'] ?? 0;
    conversaofator = double.parse(map['conversaofator'] ?? 1);
    unidadevenda = map['unidadevenda'] ?? "UN";
    fotolink = map['fotolink'] ?? "";
    preco = double.parse(map['preco'] ?? 0);
    promocao = ProdutoListItemPromocao.fromMap(map['promocao']);
    precoespecial = double.parse(map['precoespecial'] ?? 0);
    estoque = double.parse(map['estoque'] ?? 0);
    reserva = double.parse(map['reserva'] ?? 0);

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
    codproduto = map["codproduto"] ?? 0;
    preco = double.parse(map['preco'] ?? 0);
    preco_com_desconto = double.parse(map['preco_com_desconto'] ?? 0);
    promocao = ProdutoListItemPromocao.fromMap(map['promocao']);
    precoespecial = double.parse(map['precoespecial'] ?? 0);
  }
}
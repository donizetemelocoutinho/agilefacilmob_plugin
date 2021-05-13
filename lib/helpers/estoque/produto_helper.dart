import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdutoParcela{
  int numero;
  double parcela;
  double total;

  ProdutoParcela.fromMap(Map map){
    numero = map['numero'];
    parcela = double.parse(map['parcela']);
    total = double.parse(map['total']);
  }

}

class ProdutoComissao{
  double avista;
  double aprazo;
  ProdutoComissao();

  ProdutoComissao.fromMap(Map map){
    avista = double.parse(map['avista']);
    aprazo = double.parse(map['aprazo']);
  }

}

class ProdutoTributacao{
  int codcategoria;
  String idcategoria;
  String categoria;
  int codncm;
  String ncm;
  String anp;

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
  int codunidade;
  String idunidade;
  String unidade;

  ProdutoEmbalagemTipo();

  ProdutoEmbalagemTipo.fromMap(Map map){
    codunidade = map['codunidade'];
    idunidade = map['idunidade'];
    unidade = map['unidade'];
  }

}

class ProdutoEmbalagemConversao{
  int tipo;
  double fator;

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
  double pesoliquido;
  double pesobruto;

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
  int codusuario;
  String idusuario;
  String login;
  DateTime cadastro;
  DateTime modificacao;

  ProdutoInsChange();

  ProdutoInsChange.fromMap(Map map){
    codusuario = map['codusuario'];
    idusuario = map['idusuario'];
    login = map['login'];
    cadastro = (map['cadastro'] != null) ? DateTime.parse(map['cadastro']) : null;
    modificacao = (map['modificacao'] != null) ? DateTime.parse(map['cadastro']) : null;
  }

}

class ProdutoBalanca{
  String exporta;
  String acionanocaixa;
  int diasvalidade;

  ProdutoBalanca();

  ProdutoBalanca.fromMap(Map map){
    exporta = map['exporta'];
    acionanocaixa =  map['acionanocaixa'];
    diasvalidade = int.parse(map['diasvalidade']);
  }
}

class ProdutoEstoque{
  double saldo;
  double reservado;
  DateTime dataentrada;
  DateTime datasaida;
  double minimo;
  double ideal;
  String localizacao;
  int diasreposicao;
  DateTime atualizacao;

  ProdutoEstoque();

  ProdutoEstoque.fromMap(Map map){
    saldo = double.parse(map['saldo']);
    reservado = double.parse(map['reservado']);
    dataentrada = (map['dataentrada'] != null) ? DateTime.parse(map['dataentrada']) : null;
    datasaida = (map['datasaida'] != null) ? DateTime.parse(map['datasaida']) : null;
    minimo = double.parse(map['minimo']);
    ideal = double.parse(map['ideal']);
    localizacao = map['localizacao'];
    diasreposicao = map['diasreposicao'];
    atualizacao = (map['atualizacao'] != null) ? DateTime.parse(map['atualizacao']) : null;
  }
}

class ProdutoPreco{
  double valor;
  double valor_com_desconto;
  double lucro;
  double minimo;
  double valoranterior;
  DateTime atualizacao;

  ProdutoPreco();

  ProdutoPreco.fromMap(Map map){
    valor = double.parse(map['valor']);
    lucro = double.parse(map['lucro']);
    minimo = double.parse(map['minimo']);
    valoranterior = double.parse(map['valoranterior']);
    atualizacao = (map['atualizacao'] != null) ? DateTime.parse(map['atualizacao']) : null;
  }
}

class ProdutoCompra{
  double preco;
  double custo;
  double frete;
  double acrescimo;
  double seguro;
  double despesas;
  double desconto;
  double icmsst;
  double icms;
  double pis;
  double cofins;
  double ipi;
  DateTime data;
  int codfornecedor;
  String guidfornecedor;
  String fornecedor;

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

class Produto{
  int codproduto;
  String guid;
  int codigo;
  int codloja;
  String idloja;
  String codbarra;
  String codalternativo;
  int tipo;
  String descricao;
  String foto;
  ProdutoComissao comissao;
  ProdutoTributacao tributacao;
  ProdutoEmbalagem embalagem;
  int codmarca;
  String idmarca;
  String marca;
  int codsubgrupo;
  String idsubgrupo;
  String subgrupo;
  ProdutoInsChange modificacao;
  String aplicacao;
  String infoadicional;
  String temgrade;
  String ativo;
  String pdvfavorito;
  ProdutoEstoque estoque;
  ProdutoPreco preco;
  ProdutoPreco preco_especial;
  List<ProdutoParcela> parcelas = [];
  double parcela_max_valor = 0;
  double parcela_max_total = 0;
  int parcela_max_numero = 0;
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

    preco.valor_com_desconto = double.parse(map['preco']['valor_com_desconto']);

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
  }



}

class ProdutoListItemPromocao {
  DateTime inicio = DateTime.now();
  DateTime fim = DateTime.now();
  double valor;

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
  double conversaofator;
  String unidadevenda;
  String fotolink = "";
  double preco;
  ProdutoListItemPromocao promocao = ProdutoListItemPromocao();
  double precoespecial;
  double estoque;
  double reserva;
  int codgrade = 0;
  int gradeitem = 0;
  String gradeval1 = "";
  String gradeval2 = "";
  List<ProdutoParcela> parcelas = [];
  double parcela_max_valor = 0;
  double parcela_max_total = 0;
  int parcela_max_numero = 0;

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
    preco = num.parse(map['preco']);
    promocao = ProdutoListItemPromocao.fromMap(map['promocao']);
    precoespecial = double.parse(map['precoespecial']);
    estoque = double.parse(map['estoque']);
    reserva = double.parse(map['reserva']);
    codgrade = map['codgrade'];
    gradeitem = map['seq'];
    gradeval1 = map['value1'];
    gradeval2 = map['value2'];

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
      'promocao': promocao.toMap(),
      'precoespecial': precoespecial,
      'estoque': estoque,
      'reserva': reserva,
      'codgrade': codgrade,
      'gradeitem': gradeitem,
      'gradeval1': gradeval1,
      'gradeval2': gradeval2,

    };
    return map;
  }
}
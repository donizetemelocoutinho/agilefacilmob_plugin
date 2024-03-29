import 'tipos.dart';

class LojaResponsavel {
  String nome = '';
  String cpf = '';
  String celular = '';
  String email = '';

  LojaResponsavel();

  LojaResponsavel.fromMap(Map map){
    nome = map['nome'] == null ? "" : nome = map['nome'];
    cpf = map['cpf'] ?? "";
    celular = map['celular'] ?? "";
    email = map['email'] == null ? "" : email = map['email'];
  }
}
class LojaPadrao{
  int codpgtoaprazo = 0;
  String pgtoaprazo = '';

  LojaPadrao();

  LojaPadrao.fromMap(Map map){
    codpgtoaprazo = map['codpgtoaprazo'] ?? 0;
    pgtoaprazo = map['pgtoaprazo'] ?? "";
  }
}

class Loja{
  String guid = "";
  int codloja = 0;
  String nome = "";
  String razao = "";
  int seguimento = 0;
  String tpinscricao = "";
  String cpfcnpj = "";
  String ie = "";
  String im = "";
  int regimetrib = 0;
  Endereco? endereco;
  String fone = "";
  String email = "";
  String emailcontador = "";
  String linklogo = "";
  LojaResponsavel? responsavel;
  int codcontacaixa = 1;
  int codcontatesouraria = 4;
  String despfixa = "";
  String despvariavel = "";
  LojaPadrao padrao = LojaPadrao();

  Loja();

  Loja.fromMap( Map map){
    guid = map['guid'] ?? "";
    codloja = map['codloja'] ?? 0;
    nome = map['nome'] ?? "";
    razao = map['razao'] ?? "";
    seguimento = map['seguimento'] ?? 0;
    tpinscricao = map['tpinscricao'] ?? "";
    cpfcnpj = map['cpfcnpj'] ?? "";
    ie = map['ie'] == null ? "" : ie = map['ie'];
    im = map['im'] == null ? "" : im = map['im'];
    regimetrib = map['regimetrib'] ?? 0;
    endereco = Endereco.fromMap(map['endereco']);
    fone = map['fone'] ?? "";
    email = map['email'] ?? "";
    emailcontador = map['emailcontador'] == null ? "" : emailcontador = map['emailcontador'];
    linklogo = map['linklogo'] ?? "";
    responsavel = LojaResponsavel.fromMap(map['responsavel']);
    codcontacaixa = map['codcontacaixa'] ?? 1;
    codcontatesouraria = map['codcontatesouraria'] ?? 4;
    despfixa = map['despfixa'] ?? "";
    despvariavel = map['despvariavel'] ?? "";
    padrao= LojaPadrao.fromMap(map['padrao']);
  }

}
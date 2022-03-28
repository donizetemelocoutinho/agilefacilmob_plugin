import 'tipos.dart';

class LojaResponsavel {
  String nome = '';
  String cpf = '';
  String celular = '';
  String email = '';

  LojaResponsavel();

  LojaResponsavel.fromMap(Map map){
    nome = map['nome'];
    cpf = map['cpf'];
    celular = map['celular'];
    email = map['email'];
  }
}
  class LojaPadrao{
    int codpgtoaprazo = 0;
    String pgtoaprazo = '';

    LojaPadrao();

  LojaPadrao.fromMap(Map map){
    codpgtoaprazo = map['codpgtoaprazo'];
    pgtoaprazo = map['pgtoaprazo'];
  }

  }


class Loja{
  String guid = '';
  int codloja = 0;
  String nome = '';
  String razao = '';
  int seguimento = 0;
  String tpinscricao = '';
  String cpfcnpj = '';
  String ie = '';
  String im = '';
  int regimetrib = 0;
  Endereco ?endereco;
  String fone = '';
  String email = '';
  String emailcontador = '';
  String linklogo = '';
  LojaResponsavel ?responsavel;
  int codcontacaixa = 1;
  int codcontatesouraria = 4;
  String despfixa = '';
  String despvariavel = '';
  LojaPadrao padrao = LojaPadrao();

  Loja();

  Loja.fromMap( Map map){

    guid = map['guid'];
    codloja = map['codloja'];
    nome = map['nome'];
    razao = map['razao'];
    seguimento = map['seguimento'];
    tpinscricao = map['tpinscricao'];
    cpfcnpj = map['cpfcnpj'] ?? null;
    ie = map['ie'];
    im = map['im'];
    regimetrib = map['regimetrib'];
    endereco = Endereco.fromMap(map['endereco']);
    fone = map['fone'];
    email = map['email'];
    emailcontador = map['emailcontador'];
    linklogo = map['linklogo'];
    responsavel = LojaResponsavel.fromMap(map['responsavel']);
    codcontacaixa = map['codcontacaixa'];
    codcontatesouraria = map['codcontatesouraria'];
    despfixa = map['despfixa'];
    despvariavel = map['despvariavel'];
    padrao= LojaPadrao.fromMap(map['padrao']);
  }

}
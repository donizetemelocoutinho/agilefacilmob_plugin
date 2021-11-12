import 'tipos.dart';

class LojaResponsavel {
  String nome;
  String cpf;
  String celular;
  String email;

  LojaResponsavel();

  LojaResponsavel.fromMap(Map map){
    nome = map['nome'];
    cpf = map['cpf'];
    celular = map['celular'];
    email = map['email'];
  }
}
  class LojaPadrao{
    int codpgtoaprazo;
    String pgtoaprazo;

    LojaPadrao();

  LojaPadrao.fromMap(Map map){
    codpgtoaprazo = map['codpgtoaprazo'];
    pgtoaprazo = map['pgtoaprazo'];
  }

  }


class Loja{
  String guid;
  int codloja;
  String nome;
  String razao;
  int seguimento;
  String tpinscricao;
  String cpfcnpj;
  String ie;
  String im;
  int regimetrib;
  Endereco endereco;
  String fone;
  String email;
  String emailcontador;
  String linklogo;
  LojaResponsavel responsavel;
  int codcontacaixa;
  int codcontatesouraria;
  String despfixa;
  String despvariavel;
  LojaPadrao padrao;


  Loja();

  Loja.fromMap( Map map){

    guid = map['guid'];
    codloja = map['codloja'];
    nome = map['nome'];
    razao = map['razao'];
    seguimento = map['seguimento'];
    tpinscricao = map['tpinscricao'];
    cpfcnpj = map['cpfcnpj'];
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
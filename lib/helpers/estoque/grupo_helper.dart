class Grupo{
  int id;
  String guid;
  int codgrupo;
  int codloja;
  String idloja;
  String descricao;

  Grupo();

  Grupo.fromMap( Map map){
    id = map['id'];
    guid = map['guid'];
    codgrupo = map['codgrupo'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    descricao = map['descricao'];
  }
}

class GrupoListItem{
  String guid;
  int codgrupo;
  int codloja;
  String idloja;
  String descricao;

  GrupoListItem();

  GrupoListItem.fromMap( Map map){
    guid = map['guid'];
    codgrupo = map['codgrupo'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    descricao = map['descricao'];
  }
}
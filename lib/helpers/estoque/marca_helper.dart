class Marca{
  int id;
  String guid;
  int codmarca;
  int codloja;
  String idloja;
  String descricao;

  Marca();

  Marca.fromMap( Map map){
    id = map['id'];
    guid = map['guid'];
    codmarca = map['codmarca'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    descricao = map['descricao'];
  }
}

  class MarcaListItem{
    String guid;
    int codmarca;
    int codloja;
    String idloja;
    String descricao;

    MarcaListItem();

    MarcaListItem.fromMap( Map map){
      guid = map['guid'];
      codmarca = map['codmarca'];
      codloja = map['codloja'];
      idloja = map['idloja'];
      descricao = map['descricao'];
    }
  }



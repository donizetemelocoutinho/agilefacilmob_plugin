
class SubGrupoComissao{
  double avista;
  double aprazo;

  SubGrupoComissao();

  SubGrupoComissao.fromMap(Map map){
    avista = map['avista'];
    aprazo = map['aprazo'];
  }
}


class SubGrupo{
  int id;
  String guid;
  int codsubgrupo;
  int codloja;
  String idloja;
  String descricao;
  int codgrupo;
  String idgrupo;
  String grupo;
  String linkicone;
  String favorito;
  SubGrupoComissao comissao;

  SubGrupo();

  SubGrupo.fromMap(Map map){
    id = map['id'];
    guid = map['guid'];
    codsubgrupo = map['codsubgrupo'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    descricao = map['descricao'];
    codgrupo = map['codgrupo'];
    idgrupo = map['idgrupo'];
    favorito = map['grupo'];
    comissao = SubGrupoComissao.fromMap(map['comissao']);
  }
}

class SubGrupoListItem{
  String guid;
  int codsubgrupo;
  int codloja;
  String idloja;
  String descricao;
  int codgrupo;
  String idgrupo;
  String grupo;
  String linkicone;
  String favorito;
  SubGrupoComissao comissao;

  SubGrupoListItem();

  SubGrupoListItem.fromMap(Map map){
    guid = map['guid'];
    codsubgrupo = map['codsubgrupo'];
    codloja = map['codloja'];
    idloja = map['idloja'];
    descricao = map['descricao'];
    codgrupo = map['codgrupo'];
    idgrupo = map['idgrupo'];
    grupo = map['grupo'];
    linkicone = map['linkicone'];
    favorito = map['favorito'];
    comissao = SubGrupoComissao.fromMap(map['comissao']);
  }
}
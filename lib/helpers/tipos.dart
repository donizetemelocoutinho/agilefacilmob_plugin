class Diversos{
  static List<String> UFs = ["AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT","PA","PB","PE","PI","PR","RJ","RN","RO","RR","RS","SC","SE","SP","TO",];
  static List<String> Estados = ["Acre","Alagoas","Amazonas","Amapa","Bahia","Ceara","Distrito Federal","Espírito Santo","Goias","Maranhão","Minas Gerais","Mato Grossodo Sul","Mato Grosso","Para","Paraíba","Pernambuco","Piaui","Parana","Rio de Janeiro","Rio Grande do Norte","Rondtnia","Roraima","Rio Grande do Sul","Santa Catarina","Sergipe","Sao Paulo","Tocantins"];
  static List<int> UFsIbge = [12,27,13,16,29,23,53,32,52,21,31,50,51,15,25,26,22,41,33,24,11,14,43,42,28,35,17];
}

enum TabelaPrecoType{tpPrincipal,tpAlternativa}

class Endereco{
  int ?codcidade;
  int ?codcidadeibge;
  String ?cidade;
  String uf = "";
  String bairro = "";
  String cep = "";
  String logradouro = "";
  String numero = "";
  String referencia = "";
  double lat = 0;
  double long = 0;

  Endereco();

  Endereco.fromMap(Map map){
    codcidade = map['codcidade'];
    codcidadeibge = map['codcidadeibge'];
    cidade = map['cidade'] == null ? "" : map['cidade'];
    uf = map['uf'] == null ? "" : map['uf'];
    bairro = map['bairro'] == null ? "" : map['bairro'];
    cep = map['cep'] == null ? "" : map['cep'];
    logradouro = map['logradouro']  == null ? "" : map['logradouro'];
    numero = map['numero']  == null ? "" : map['numero'];
    referencia = map['referencia'] == null ? "" : map['referencia'];
    lat = 0.0;
    long = 0.0;
  }

  Map toMap(){
    Map<String, dynamic> map = {
      'codcidade': codcidade,
      'codcidadeibge': codcidadeibge,
      'cidade': cidade,
      'uf': uf,
      'bairro' : bairro,
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'referencia' : referencia,
      'lat' : lat,
      'long': long
    };
    return map;
  }

  String getDescricao(){
    String info = "";

    info = logradouro.length > 0 ? logradouro : "";
    info = numero.length > 0 ?  info + ", " + numero : info;
    info = referencia.length > 0 ?  info + ", " + referencia : info;
    info = bairro.length > 0 ?  info + ", " + bairro : info;
    info = cidade.length > 0 ?  info + " - " + cidade : info;
    info = uf.length > 0 ?  info + " - " + uf : info;
    info = cep.length > 0 ?  info + " - " + cep : info;

    return info;
  }

}

class Cidade{
  int ?codcidade;
  String ?guid;
  String ?uf;
  String ?descricao;
  int ?codcidadeibge;

  Cidade();

  Cidade.fromMap(Map map){
    codcidade = map['codcidade'];
    guid = map['guid'];
    uf = map['uf'];
    descricao = map['descricao'];
    codcidadeibge = map['codcidadeibge'];
  }

}

class Estado{
  String uf = "";
  String descricao = "";
  int codibge = 0;

  Estado();

  static String getUF(int i){
    return Diversos.UFs[i];
  }

  static String getEstado(int i){
    return Diversos.Estados[i];
  }

  static int getCodIbge(int i){
    return Diversos.UFsIbge[i];
  }

  static int getUFPosition(String uf){
    int pos = -1;
    for (int i = 0; i < 27; i++) {
      if (uf.toUpperCase().compareTo(Diversos.UFs[i]) == 0){
        pos = i;
        break;
      }
    }
    return pos;
  }

}
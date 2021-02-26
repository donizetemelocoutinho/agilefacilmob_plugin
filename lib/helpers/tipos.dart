class Diversos{
  static List<String> UFs = ["AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT","PA","PB","PE","PI","PR","RJ","RN","RO","RR","RS","SC","SE","SP","TO",];
  static List<String> Estados = ["Acre","Alagoas","Amazonas","Amapa","Bahia","Ceara","Distrito Federal","Espírito Santo","Goias","Maranhão","Minas Gerais","Mato Grossodo Sul","Mato Grosso","Para","Paraíba","Pernambuco","Piaui","Parana","Rio de Janeiro","Rio Grande do Norte","Rondtnia","Roraima","Rio Grande do Sul","Santa Catarina","Sergipe","Sao Paulo","Tocantins"];
  static List<int> UFsIbge = [12,27,13,16,29,23,53,32,52,21,31,50,51,15,25,26,22,41,33,24,11,14,43,42,28,35,17];
}

class Endereco{
  int codcidade;
  int codcidadeibge;
  String cidade;
  String uf;
  String bairro;
  String cep;
  String logradouro;
  String numero;
  String referencia;
  double lat;
  double long;

  Endereco();

  Endereco.fromMap(Map map){
    codcidade = map['codcidade'];
    codcidadeibge = map['codcidadeibge'];
    cidade = map['cidade'];
    uf = map['uf'];
    bairro = map['bairro'];
    cep = map['cep'];
    logradouro = map['logradouro'];
    numero = map['numero'];
    referencia = map['referencia'];
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

}

class Cidade{
  int codcidade;
  String guid;
  String uf;
  String descricao;
  int codcidadeibge;

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

  static String getUFDescricao(int i){
    return Diversos.Estados[i];
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
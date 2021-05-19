import 'package:agilefacil_mob/helpers/pessoa_helper.dart';
import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'api_helper.dart';
import 'helper.dart';


class ClienteApi{

  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map>GetList({@required int codloja, @required String api_token, String search, int startrow,String ativo, int limit}) async {
    ApiHelper api = ApiHelper();
    return await api.get("cliente/list",params: {"codloja": Helper.loja.codloja.toString(),"search": search,"startrow": startrow.toString(),
      "ativo": ativo,"limit": limit.toString(),"api_token": api_token});
  }
}

class ClienteHelper {
  ClienteHelper();
}

class ClienteEmpresa extends PessoaJuridica {

  int codigo = 0;
  bool ativo = true;
  Credito credito = Credito();
  double receber = 0;
  String classificacao = "C";
  int diafaturamento = 1;
  String descricao = "";


  ClienteEmpresa();

  ClienteEmpresa.fromMap(Map map){
    super.fromMap(map);
    codigo = map["codigo"];
    ativo = map["ativo"] == "S" ? true : false;
    credito = Credito.fromMap(map["credito"]);
    receber = double.parse(map["receber"]);
    classificacao = map["classificacao"];
    diafaturamento = map["diafaturamento"];
  }

  @override
  Map<String,dynamic> toMap() {
    Map<String,dynamic> map = super.toMap();
    map['codigo'] = codigo;
    map['ativo'] = ativo ? "S" : "N";
    map['classificacao'] = classificacao;
    map['diafaturamento'] = diafaturamento;
    map['descricao'] = descricao;
    map['credito'] = credito.toMap();
    return map;
  }
}

class ClienteFisica extends PessoaFisica{
  int codigo;
  bool ativo = true;
  Credito credito = Credito();
  double receber = 0;
  String classificacao = "C";
  int diafaturamento = 1;
  String descricao = "";

  ClienteFisica();

  ClienteFisica.fromMap(Map map){
    super.fromMap(map);

    codigo = map["codigo"];
    ativo = map["ativo"] == "S" ? true : false;
    credito = Credito.fromMap(map["credito"]);
    receber = double.parse(map["receber"]);
    classificacao = map["classificacao"];
    diafaturamento = map["diafaturamento"];
  }

  @override
  Map<String,dynamic> toMap() {
    Map<String,dynamic> map = super.toMap();
    map['codigo'] = codigo;
    map['ativo'] = ativo ? "S" : "N";
    map['classificacao'] = classificacao;
    map['diafaturamento'] = diafaturamento;
    map['descricao'] = descricao;
    map['credito'] = credito.toMap();
    return map;
  }
}

class ClienteListItemCredito{

  double limite;
  double disponivel;
  double totalreceber;

  ClienteListItemCredito.fromMap(Map map){
    limite = double.parse(map["limite"]);
    disponivel = double.parse(map["disponivel"]);
    totalreceber = double.parse(map["totalreceber"]);
  }
}

class ClienteListItemContato{

  String email = "";
  String fone = "";
  String celular = "";
  String recado = "";

  ClienteListItemContato.fromMap(Map map){
    email = map['email'];
    fone = map['fone'];
    celular = map['celular'];
    recado = map['recado'];
  }
}

class ClienteListItemEdereco{

  String cidade;
  String uf;
  String bairro;
  String cep;
  String logradouro;
  String numero;
  String referencia;

  ClienteListItemEdereco.fromMap(Map map){
    cidade = map['cidade'];
    uf = map['uf'];
    bairro = map['bairro'];
    cep = map['cep'];
    logradouro = map['logradouro'];
    numero = map['numero'];
    referencia = map['referencia'];
  }

}

class ClienteListItem{

  int codpessoa = 0;
  String guid = "";
  int codigo = 0;
  String tipo = "";
  int status = 0;
  String nome = "CONSUMIDOR...";
  String razao = "CONSUMIDOR...";
  String cpfcnpj = "";
  int tipoie = 0;
  String ie = "";
  String foto;
  String sexo = "";
  ClienteListItemContato contato;
  Endereco endereco = Endereco();
  ClienteListItemCredito credito;

  ClienteListItem();

  ClienteListItem.fromMap(Map map){
    codpessoa = map['codpessoa'];
    guid = map['guid'];
    codigo = map['codigo'];
    tipo = map['tipo'];
    status = map['status'];
    nome = map['nome'];
    razao = map['razao'];
    cpfcnpj = map['cpfcnpj'];
    tipoie = map['tipoie'];
    ie = map['ie'];
    foto = map['foto'];
    sexo = map['sexo'];
    contato = ClienteListItemContato.fromMap(map['contato']);
    endereco = Endereco.fromMap(map['endereco']);
    credito = ClienteListItemCredito.fromMap(map['credito']);
  }
}
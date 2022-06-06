import 'package:agilefacil_mob/helpers/pessoa_helper.dart';
import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:flutter/services.dart';
import 'api_helper.dart';

  class ClienteApi{

    static const MethodChannel _channel = const MethodChannel('agilefacil_mob');
    static Future<String> get platformVersion async {
      final String version = await _channel.invokeMethod('getPlatformVersion');
      return version;
    }

    Future<Map> getList({required int codloja, required String api_token, required String search,required int startrow,required bool ativo, required int limit}) async {
      ApiHelper api = ApiHelper();
      return await api.get("cliente/list",params: {"codloja": codloja.toString(),"search": search,"startrow": startrow.toString(),
        "ativo": ativo ? "S" : "N","limit": limit.toString(),"api_token": api_token});
    }

    Future<Map>get({required int codloja,required int codcliente, required String api_token})async{
      ApiHelper api = ApiHelper();
      return await api.get("cliente/edit", params: {"codloja": codloja.toString(), "codcliente": codcliente.toString(),"api_token":api_token});
    }

    Future<Map>storeEmpresa({required int codloja, required String api_token,required ClienteEmpresa cliente})async{
      ApiHelper api = ApiHelper();
      Map<String,dynamic> jo = cliente.toMap();
      return await api.post("cliente", jo,params: {"codloja": codloja.toString(),"api_token":api_token});
    }

    Future<Map>storeFisica({required int codloja, required String api_token,required ClienteFisica cliente})async{
      ApiHelper api = ApiHelper();
      Map<String,dynamic> jo = cliente.toMap();
      return await api.post("cliente", jo,params: {"codloja": codloja.toString(),"api_token":api_token});
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
    int codigo = 0;
    bool ativo = true;
    Credito credito = Credito();
    double receber = 0;
    String classificacao = "C";
    int diafaturamento = 1;
    String descricao = "";

    ClienteFisica();

    ClienteFisica.fromMap(Map map){
      super.fromMap(map);

      codigo = map["codigo"] ?? 0;
      ativo = map["ativo"] == "S" ? true : false;
      credito = Credito.fromMap(map["credito"]);
      receber = double.parse(map["receber"] ?? 0);
      classificacao = map["classificacao"] ?? "C";
      diafaturamento = map["diafaturamento"] ?? 1;
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
    double limite = 0.00;
    double disponivel = 0.00;
    double totalreceber = 0.00;

    ClienteListItemCredito.fromMap(Map map){
      limite = double.parse(map["limite"] ?? 0);
      disponivel = double.parse(map["disponivel"] ?? 0);
      totalreceber = double.parse(map["totalreceber"] ?? 0);
    }
  }

  class ClienteListItemContato{
    String email = "";
    String fone = "";
    String celular = "";
    String recado = "";

    ClienteListItemContato.fromMap(Map map){
      email = map['email'] ?? "";
      fone = map['fone'] ?? "";
      celular = map['celular'] ?? "";
      recado = map['recado'] ?? "";
    }
  }

  class ClienteListItemEdereco{
    String cidade = "";
    String uf = "";
    String bairro = "";
    String cep = "";
    String logradouro = "";
    String numero = "";
    String referencia = "";

    ClienteListItemEdereco.fromMap(Map map){
      cidade = map['cidade'] ?? "";
      uf = map['uf'] ?? "";
      bairro = map['bairro'] ?? "";
      cep = map['cep'] ?? "";
      logradouro = map['logradouro'] ?? "";
      numero = map['numero'] ?? "";
      referencia = map['referencia'] ?? "";
    }

  }

  class ClienteListItem {
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
    String foto = "";
    String sexo = "";
    late ClienteListItemContato contato;
    Endereco endereco = Endereco();
    late ClienteListItemCredito credito;
    late ReceberListItem receber;

    ClienteListItem();

    ClienteListItem.fromMap(Map map){
      codpessoa = map['codpessoa'] ?? 0;
      guid = map['guid'] ?? "";
      codigo = map['codigo'] ?? 0;
      tipo = map['tipo'] ?? "";
      status = map['status'] ?? 0;
      nome = map['nome'] ?? "CONSUMIDOR...";
      razao = map['razao'] ?? "CONSUMIDOR...";
      cpfcnpj = map['cpfcnpj'] ?? "";
      tipoie = map['tipoie'] ?? 0;
      ie = map['ie'] ?? "";
      foto = map['foto'] ?? "";
      sexo = map['sexo'] ?? "";
      contato = ClienteListItemContato.fromMap(map['contato']);
      endereco = Endereco.fromMap(map['endereco']);
      credito = ClienteListItemCredito.fromMap(map['credito']);
      receber = ReceberListItem.fromMap(map['receber']);
    }

    Map<String, dynamic> toMap() {
      final map = <String, dynamic>{
      'codpessoa' : codpessoa,
      'guid' : guid,
      'codigo' : codigo,
      'tipo' : tipo,
      'status' : status,
      if (credito != null)
        'credito' : credito,

      'nome' : nome,
      'razao' : razao,
      'cpfcnpj' : cpfcnpj,
      'tipoie' : tipoie,
      'ie' : ie,
      'foto' : foto,
      'sexo' : sexo,
      if (contato != null)
        'contato' : contato,

      if (endereco != null)
        'endereco' : endereco,

      if (receber != null)
        'receber' : receber,
      };
      return map;
    }

  }

  class ReceberListItem {
    int totalCount = 0;
    double totalValor = 0.00;
    int vencidoCount = 0;
    double vencidoTotal = 0.00;
    List<Titulos>? titulos;

    ReceberListItem({required this.totalCount,
      required this.totalValor,
      required this.vencidoCount,
      required this.vencidoTotal,
      this.titulos
    });

    ReceberListItem.fromMap(Map<String, dynamic> map) {
      totalCount = map['total_count'] ?? 0;
      totalValor = double.parse(map['total_valor'].toString());
      vencidoCount = map['vencido_count'] ?? 0;
      vencidoTotal = double.parse(map['vencido_total'].toString());
      if (map['titulos'] != null) {
        titulos = <Titulos>[];
        map['titulos'].forEach((v) {
          titulos!.add(Titulos.fromMap(v));
        });
      }
    }

    Map<String, dynamic> toMap() {
      final map = <String, dynamic>{
        'total_count': this.totalCount,
        'total_valor': this.totalValor,
        'vencido_count': this.vencidoCount,
        'vencido_total': this.vencidoTotal,
        if (this.titulos != null)
          'titulos': this.titulos!.map((v) => v.toMap()).toList(),
      };
      return map;
    }
  }

  class Titulos {
    int? codtitulo;
    int? codloja;
    String? numerodoc;
    Data? data;
    Valor? valor;
    int? diasatraso;
    String? pgto;
    String? usuario;
    String? descricao;
    String? planocontas;

    Titulos({this.codtitulo,
      this.codloja,
      this.numerodoc,
      this.data,
      this.valor,
      this.diasatraso,
      this.pgto,
      this.usuario,
      this.descricao,
      this.planocontas});

    Titulos.fromMap(Map<String, dynamic> map) {
      codtitulo = map['codtitulo'];
      codloja = map['codloja'];
      numerodoc = map['numerodoc'];
      data = map['data'] != null ? new Data.fromMap(map['data']) : null;
      valor = map['valor'] != null ? new Valor.fromMap(map['valor']) : null;
      diasatraso = map['diasatraso'];
      pgto = map['pgto'];
      usuario = map['usuario'];
      descricao = map['descricao'];
      planocontas = map['planocontas'];
    }


    Map<String, dynamic> toMap() {
      final map = <String, dynamic>{
      'codtitulo' : this.codtitulo,
      'codloja' : this.codloja,
      'numerodoc' : this.numerodoc,
      if (this.data != null)
      'data' : this.data!.toMap(),

      if (this.valor != null)
      'valor' : this.valor!.toMap(),

      'diasatraso' : this.diasatraso,
      'pgto' : this.pgto,
      'usuario' : this.usuario,
      'descricao' : this.descricao,
      'planocontas' : this.planocontas,
      };
      return map;
    }
  }

  class Data {
    String? digitacao;
    String? emissao;
    String? vencimento;
    String? ultimopagamento;

    Data({this.digitacao, this.emissao, this.vencimento, this.ultimopagamento});

    Data.fromMap(Map<String, dynamic> map) {
      digitacao = map['digitacao'];
      emissao = map['emissao'];
      vencimento = map['vencimento'];
      ultimopagamento = map['ultimopagamento'];
    }

    Map<String, dynamic> toMap() {
      final map = <String, dynamic>{
      'digitacao' : this.digitacao,
      'emissao' : this.emissao,
      'vencimento' : this.vencimento,
      'ultimopagamento' : this.ultimopagamento,
      };
      return map;
    }
  }

  class Valor {
    double nominal = 0.00;
    double restante = 0.00;
    double juro = 0.00;
    double multa = 0.00;
    double atual = 0.00;

    Valor({required this.nominal,required this.restante,required this.juro,required this.multa, required this.atual});

    Valor.fromMap(Map<String, dynamic> map) {
      nominal = double.parse(map['nominal'].toString());
      restante = double.parse(map['restante'].toString());
      juro = double.parse(map['juro'].toString());
      multa = double.parse(map['multa'].toString());
      atual = double.parse(map['atual'].toString());
    }

    Map<String, dynamic> toMap() {
      final map = <String, dynamic>{
      'nominal' : this.nominal,
      'restante' : this.restante,
      'juro' : this.juro,
      'multa' : this.multa,
      'atual' : this.atual,
      };
      return map;
    }
  }
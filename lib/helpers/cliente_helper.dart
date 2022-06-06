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
    List<Receber>? receber;

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

      if (map['receber'] != null) {
        receber = <Receber>[];
        map['receber'].forEach((v) {
          receber!.add(Receber.fromMap(v));
        });
      }

      // List m_receber = map['receber'];
      // if(m_receber != null){
      //   for (int i = 0; i < m_receber.length; i++){
      //     receber!.add(Receber.fromMap(m_receber[i]));
      //   }
      // }

    }

    // Map<String, dynamic> toMap() {
    //   final map = <String, dynamic>{
    //   'codpessoa' : codpessoa,
    //   'guid' : guid,
    //   'codigo' : codigo,
    //   'tipo' : tipo,
    //   'status' : status,
    //   if (credito != null)
    //     'credito' : credito,
    //
    //   'nome' : nome,
    //   'razao' : razao,
    //   'cpfcnpj' : cpfcnpj,
    //   'tipoie' : tipoie,
    //   'ie' : ie,
    //   'foto' : foto,
    //   'sexo' : sexo,
    //   if (contato != null)
    //     'contato' : contato,
    //
    //   if (endereco != null)
    //     'endereco' : endereco,
    //
    //   if (receber != null)
    //     'receber' : receber!.map((v) => v.toMap()).toList(),
    //   };
    //   return map;
    // }

  }


  class Receber {
    int? totalCount;
    int? totalValor;
    int? vencidoCount;
    int? vencidoTotal;
    List<Titulos>? titulos;

    Receber({this.totalCount,
      this.totalValor,
      this.vencidoCount,
      this.vencidoTotal,
      this.titulos
    });

    Receber.fromMap(Map<String, dynamic> map) {
      totalCount = map['total_count'] ?? 0;
      totalValor = map['total_valor'].toInt() ?? 0;
      vencidoCount = map['vencido_count'] ?? 0;
      vencidoTotal = map['vencido_total'].toInt() ?? 0;
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
    double? nominal;
    double? restante;
    int? juro;
    int? multa;
    double? atual;

    Valor({this.nominal, this.restante, this.juro, this.multa, this.atual});

    Valor.fromMap(Map<String, dynamic> map) {
      nominal = double.parse(map['nominal'] ?? 0);
      restante = double.parse(map['restante'] ?? 0);
      juro = map['juro'] ?? 0;
      multa = map['multa'] ?? 0;
      atual = double.parse(map['atual'] ?? 0);
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
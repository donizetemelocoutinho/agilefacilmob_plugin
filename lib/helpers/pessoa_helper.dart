import 'package:agilefacil_mob/helpers/helper.dart';
import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:intl/intl.dart';
class PessoHelper{

}

  class Pessoa{
    int codpessoa = 0;
    String guid = '';
    int codloja = 0;
    String idloja = '';
    String tipo = '';
    String nome = '';
    String cpfcnpj = '';
    String ie = '';
    int tipoie = 0;
    Contato contato = Contato();
    List<InfoBanco> infobancolist = [];
    Modification? cadastro;
    Modification? atualizacao;
    String obs = "";
    int codgrdocumento = 0;
    Endereco endereco = Endereco();

    Pessoa(){
      guid = Helper.newGuid();
      codloja = Helper.loja.codloja;
      idloja = Helper.loja.guid;
      cadastro = Modification();
      atualizacao = Modification();
    }

    void fromMap(Map map){
      codpessoa = map['codpessoa'];
      guid = map['guid'];
      codloja = map['codloja'];
      idloja = map['idloja'];
      tipo = map['tipo'];
      contato = Contato.fromMap(map['contato']);
      cadastro = Modification.fromMap(map['cadastro']);
      if (map['infobancolist'] != null){
        for (int i = 0; i < map['infobancolist'].length; i++) {
          infobancolist.add(InfoBanco.fromMap(map['infobancolist'][i]));
        }
      }
      atualizacao = Modification.fromMap(map['atualizacao']);
      nome = map['nome'];
      cpfcnpj = map['cpfcnpj'];
      ie = map['ie'];
      tipoie = map['tipoie'] ?? 0;
      obs = map['obs']?.toString() ?? "";
      codgrdocumento = map['codgrdocumento'] ?? 0;
      endereco = Endereco.fromMap(map['endereco']);

    }

    Map<String,dynamic> toMap(){

      List<Map> list = [];
      for (int i = 0; i < infobancolist.length; i++) {
        list.add(infobancolist[i].toMap());
      }

      Map<String, dynamic> map = {
        'codpessoa': codpessoa,
        'guid' : guid,
        'codloja' : codloja,
        'idloja' : idloja,
        'tipo' : tipo,
        'contato' : contato.toMap(),
        'cadastro' : cadastro?.toMap(),
        'nome': nome,
        'cpfcnpj': cpfcnpj,
        'ie': ie,
        'tipoie': tipoie,
        'obs': obs,
        'atualizacao' : atualizacao?.toMap(),
        'codgprdocumento' : null,
        'infobanco' : list,
        'endereco' : endereco.toMap(),
      };
      return map;
    }

  }

  class PessoaFisica extends Pessoa{
    String? rg;
    DateTime? nascimento;
    String photo_link = '';
    String sexo = '';
    int estadocivil = 4;
    Conjuge? conjuge;
    Filiacao filiacao = Filiacao();
    Trabalho trabalho = Trabalho();
    double outrasrendas = 0;
    int qtddependentes = 0;
    int tipomoradia = 0; //tratar depois
    String fotobase64 = '';

    PessoaFisica(){
      this.tipo = "F";
    }

    void fromMap(Map map){
      super.fromMap(map);

      rg = map['rg'] == null ? "" : rg = map['rg'];
      nascimento =  DateTime.tryParse(map['nascimento'] ?? "");
      photo_link = map['foto'];
      sexo = map['sexo'];
      estadocivil = map['estadocivil'];
      conjuge = map['conjuge'] ?? "";

      filiacao = Filiacao.fromMap(map['filiacao']);
      trabalho = Trabalho.fromMap(map['trabalho']);
      outrasrendas = double.parse(map['outrasrendas']);
      qtddependentes = map['qtddependentes'];
      tipomoradia = map['tipomoradia'];
    }

    @override
    Map<String,dynamic> toMap() {
      Map<String,dynamic> map = super.toMap();
      map["rg"] = rg;
      map["fotobase64"] = fotobase64;
      map["nascimento"] = nascimento;
      map["foto"] = photo_link;
      map["sexo"] = sexo;
      map["estadocivil"] = estadocivil;
      map["outrasrendas"] = outrasrendas;
      map["qtddependentes"] = qtddependentes;
      map["tipomoradia"] = tipomoradia;//ver depois
      map["conjuge"] = conjuge;
      map["filiacao"] = filiacao.toMap();
      map["trabalho"] = trabalho.toMap();
      return map;
    }
  }

  class PessoaJuridica extends Pessoa{
    String razao = '';
    DateTime? abertura;
    String site = '';
    String emailcobranca = '';
    Responsavel responsavel = Responsavel();

    PessoaJuridica() {
      this.tipo = "J";
    }

    void fromMap(Map map){
      super.fromMap(map);

      razao = map['razao'];
      abertura =  DateTime.tryParse(map['abertura'] ?? "");

      site = map['site'];
      emailcobranca = map['emailcobranca'];
      responsavel = Responsavel.fromMap(map['responsavel']);
    }

    Map<String,dynamic> toMap() {
      Map<String,dynamic> map = super.toMap();
      map["razao"] = razao;
      map["abertura"] = abertura;
      map["site"] = site;
      map["emailcobranca"] = emailcobranca;
      map["emailnfe"] = null; // tratar depois
      map["responsavel"] = (responsavel != null) ? responsavel.toMap() : null;

      return map;
    }
  }

  class Modification{
    DateTime data = new DateTime.now();
    String usuario = '';
    int codusuario = 0;

    Modification(){
      usuario = Helper.usuario.login.toString();
      codusuario = Helper.usuario.codusuario;
    }

    Modification.fromMap(Map map){
      data =  DateTime.parse(map['data']?.toString() ?? "");
      usuario = map['usuario'];
      codusuario = map['codusuario'];
    }

    Map<String,dynamic> toMap(){
      Map<String, dynamic> map = {
        'data' : data != null ? DateFormat('yyyy-MM-dd').format(data) : null,
        'usuario': usuario,
        'codusuario': codusuario,
      };
      return map;
    }

  }

  class Conjuge{
    String nome = '';
    String cpf = '';
    String rg = '';
    DateTime? nascimento;
    String fone = '';
    String localtrabalho = '';

    Conjuge();

    Conjuge.fromMap(Map map){
      nome = map['nome'];
      cpf = map['cpf'];
      rg = map['rg'];
      nascimento =  DateTime.tryParse(map['nascimento'] ?? "");
      fone = map['fone'];
      localtrabalho = map['localtrabalho'];
    }

    Map<String,dynamic> toMap(){
      Map<String, dynamic> map = {
        'nome': nome,
        'cpf': cpf,
        'rg': rg,
        'nascimento' : nascimento,
        'fone': fone,
        'localtrabalho': localtrabalho,
      };
      return map;
    }

  }

  class Contato {
    String email = '';
    String fone = '';
    String celular = '';
    String recado = '';
    List<ContatoAdicional> outros = [];

    Contato();

    Contato.fromMap(Map map){
      email = map['email'] == null ? "" : email = map['email'];
      fone = map['fone'];
      celular = map['celular'];
      recado = map['recado'];
      if(map['outros'] != null) {
        for (int i = 0; i < map['outros'].length; i++) {
          outros.add(ContatoAdicional.fromMap(map['outros'][i]));
        }
      }
    }

    Map<String,dynamic> toMap(){
      List<Map> list = [];
      for (int i = 0; i < outros.length; i++) {
        list.add(outros[i].toMap());
      }

      Map<String, dynamic> map = {
        'email': email,
        'fone': fone,
        'celular': celular,
        'recado': recado,
        'outros' : list,
      };
      return map;
    }
  }

  class ContatoAdicional{
    String guid = '';
    String fone = '';
    int tipo = 0;
    String email = '';
    String infoadicional = '';

    ContatoAdicional();

    ContatoAdicional.fromMap(Map map){
      guid = map['guid'];
      fone = map['fone'];
      tipo = map['tipo'];
      email = map['email'];
      infoadicional = map['infoadicional'];
    }

    Map<String,dynamic> toMap(){
      Map<String, dynamic> map = {
        'guid': guid,
        'fone': fone,
        'tipo': tipo,
        'email': email,
        'infoadicional' : infoadicional,
      };
      return map;
    }
  }

  class Credito {
    double limite = 0.0;
    bool aprazo = true;
    bool cheque = true;
    bool liberacao_aprazo = true;
    bool liberacao_cheque = true;

    Credito();

    Credito.fromMap(Map map){
      limite = double.parse(map['limite']);
      liberacao_aprazo = map['liberacao']['aprazo'] == "S" ? true : false;
      liberacao_cheque = map['liberacao']['cheque'] == "S" ? true : false;
    }

    Map<String,dynamic> toMap(){
      Map<String, dynamic> map = {
        'limite': limite,

      };
      Map<String,String> liberacao = {"aprazo":liberacao_aprazo ? "S" : "N","cheque": liberacao_cheque ? "S" : "N"};
      map['liberacao'] = liberacao;
      return map;
    }
  }

  class Filiacao {
    String mae = '';
    String pai = '';

    Filiacao();

    Filiacao.fromMap(Map map){
      mae = map['mae'];
      pai = map['pai'];
    }

    Map<String,dynamic> toMap(){
      Map<String, dynamic> map = {
        'mae': mae,
        'pai': pai,
      };
      return map;
    }

  }

  class InfoBanco {
    String guid = '';
    int codbanco = 0;
    int codfebraban = 0;
    String ?banco;
    int agencia = 1;
    int conta = 1;
    String infoadicional = '';

    InfoBanco.fromMap(Map map){
      guid = map['guid'];
      codbanco = map['codbanco'];
      codfebraban = map['codfebraban'];
      banco = map['banco'];
      agencia = map['agencia'];
      conta = map['conta'];
      infoadicional = map['infoadicional'];
    }

    Map<String,dynamic> toMap(){
      Map<String, dynamic> map = {
        'guid': guid,
        'codbanco': codbanco,
        'codfebraban': codfebraban,
        'banco': banco,
        'agencia' : agencia,
        'conta': conta,
        'infoadicional': infoadicional,
      };
      return map;
    }

  }

  class Responsavel{
    String nome = '';
    String cpf = '';
    String rg = '';
    String orgemissor = '';
    String fone = '';
    String celular = '';
    String email = '';

    Responsavel();

    Responsavel.fromMap(Map map){
      nome = map['nome'];
      cpf = map['cpf'];
      rg = map['rg'];
      orgemissor = map['orgemissor'];
      fone = map['fone'];
      celular = map['celular'];
      email = map['email'];
    }

    Map<String,dynamic> toMap(){
      Map<String, dynamic> map = {
        'nome': nome,
        'cpf': cpf,
        'rg': rg,
        'orgemissor': orgemissor,
        'fone' : fone,
        'celular': celular,
        'email': email,
      };
      return map;
    }

  }

  class Trabalho {
    String profissao = '';
    String local = '';
    String fone = '';
    String responsavel = '';
    DateTime? admissao;
    String cargo = '';
    double salario = 0;

    Trabalho();

    Trabalho.fromMap(Map map){
      profissao = map['profissao'];
      local = map['local'];
      fone = map['fone'];
      responsavel = map['responsavel'];
      admissao =  DateTime.tryParse(map['admissao'] ?? "");
      cargo = map['cargo'];
      salario = double.parse(map['salario']);
    }

    Map<String,dynamic> toMap(){
      Map<String, dynamic> map = {
        'profissao': profissao,
        'local': local,
        'fone': fone,
        'responsavel': responsavel,
        'admissao' : admissao,
        'cargo': cargo,
        'salario': salario,
      };
      return map;
    }
  }

  class Comissao {
    double aprazo = 0;
    double avista = 0;

    Comissao();

    Comissao.fromMap(Map map){
      aprazo = double.parse(map['aprazo'] == null ? 0 : aprazo = map['aprazo']);
      avista = double.parse(map['avista'] == null ? 0 : avista = map['avista']);
    }

    Map<String,dynamic> toMap(){
      Map<String, dynamic> map = {
        'aprazo': aprazo,
        'avista': avista,
      };
      return map;
    }

  }
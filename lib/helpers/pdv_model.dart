

class PDVModelCartao {
  int tipo;
  Null tefCaptura;

  PDVModelCartao({this.tipo, this.tefCaptura});

  PDVModelCartao.fromJson(Map<String, dynamic> json) {
    tipo = json['tipo'];
    tefCaptura = json['tef_captura'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipo'] = this.tipo;
    data['tef_captura'] = this.tefCaptura;
    return data;
  }
}

class PDVModelBalanca {
  int tipo;
  String porta;
  int velocidade;

  PDVModelBalanca({this.tipo, this.porta, this.velocidade});

  PDVModelBalanca.fromJson(Map<String, dynamic> json) {
    tipo = json['tipo'];
    porta = json['porta'];
    velocidade = json['velocidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipo'] = this.tipo;
    data['porta'] = this.porta;
    data['velocidade'] = this.velocidade;
    return data;
  }
}

class PDVModelDispositivo {
  int coddispositivo;
  String nome;
  Null ip;
  Null versao;

  PDVModelDispositivo({this.coddispositivo, this.nome, this.ip, this.versao});

  PDVModelDispositivo.fromJson(Map<String, dynamic> json) {
    coddispositivo = json['coddispositivo'];
    nome = json['nome'];
    ip = json['ip'];
    versao = json['versao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coddispositivo'] = this.coddispositivo;
    data['nome'] = this.nome;
    data['ip'] = this.ip;
    data['versao'] = this.versao;
    return data;
  }
}

class PDVModelNfce {
  int codserie;

  PDVModelNfce({this.codserie});

  PDVModelNfce.fromJson(Map<String, dynamic> json) {
    codserie = json['codserie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codserie'] = this.codserie;
    return data;
  }
}

class PDVModelCreate {
  int codusuario;
  String data;

  PDVModelCreate({this.codusuario, this.data});

  PDVModelCreate.fromJson(Map<String, dynamic> json) {
    codusuario = json['codusuario'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codusuario'] = this.codusuario;
    data['data'] = this.data;
    return data;
  }
}

class PDVModelDelete {
  Null codusuario;
  Null data;

  PDVModelDelete({this.codusuario, this.data});

  PDVModelDelete.fromJson(Map<String, dynamic> json) {
    codusuario = json['codusuario'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codusuario'] = this.codusuario;
    data['data'] = this.data;
    return data;
  }
}

class PDVModelSat {
  String marca;
  String modelo;
  String numeroSerie;
  String versao;
  String codigoAtivacao;

  PDVModelSat(
      {this.marca,
        this.modelo,
        this.numeroSerie,
        this.versao,
        this.codigoAtivacao});

  PDVModelSat.fromJson(Map<String, dynamic> json) {
    marca = json['marca'];
    modelo = json['modelo'];
    numeroSerie = json['numero_serie'];
    versao = json['versao'];
    codigoAtivacao = json['codigo_ativacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marca'] = this.marca;
    data['modelo'] = this.modelo;
    data['numero_serie'] = this.numeroSerie;
    data['versao'] = this.versao;
    data['codigo_ativacao'] = this.codigoAtivacao;
    return data;
  }
}

class PDVModelImpressora {
  Null nome;
  int modelo;

  PDVModelImpressora({this.nome, this.modelo});

  PDVModelImpressora.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    modelo = json['modelo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['modelo'] = this.modelo;
    return data;
  }
}

class PDVModel{
  int codpdv;
  int numero;
  String chave;
  PDVModelCartao cartao;
  int codtdf;
  PDVModelBalanca balanca;
  PDVModelDispositivo dispositivo;
  PDVModelNfce nfce;
  PDVModelCreate create;
  PDVModelCreate update;
  PDVModelDelete delete;
  PDVModelSat sat;
  PDVModelImpressora impressora;
  String guid;
  int tipo;


  PDVModel(
    {this.codpdv,
      this.numero,
      this.chave,
      this.cartao,
      this.codtdf,
      this.balanca,
      this.dispositivo,
      this.nfce,
      this.create,
      this.update,
      this.delete,
      this.sat,
      this.impressora,
      this.guid,
      this.tipo});


  PDVModel.fromJson(Map<String, dynamic> json) {
    codpdv = json['codpdv'];
    numero = json['numero'];
    chave = json['chave'];
    cartao =
    json['cartao'] != null ? new PDVModelCartao.fromJson(json['cartao']) : null;
    codtdf = json['codtdf'];
    balanca = json['balanca'] != null ? new PDVModelBalanca.fromJson(json['balanca']) : null;
    dispositivo = json['dispositivo'] != null ? new PDVModelDispositivo.fromJson(json['dispositivo']) : null;
    nfce = json['nfce'] != null ? new PDVModelNfce.fromJson(json['nfce']) : null;
    create = json['create'] != null ? new PDVModelCreate.fromJson(json['create']) : null;
    update = json['update'] != null ? new PDVModelCreate.fromJson(json['update']) : null;
    delete = json['delete'] != null ? new PDVModelDelete.fromJson(json['delete']) : null;
    sat = json['sat'] != null ? new PDVModelSat.fromJson(json['sat']) : null;
    impressora = json['impressora'] != null ? new PDVModelImpressora.fromJson(json['impressora']) : null;
    guid = json['guid'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codpdv'] = this.codpdv;
    data['numero'] = this.numero;
    data['chave'] = this.chave;
    if (this.cartao != null) {
      data['cartao'] = this.cartao.toJson();
    }
    data['codtdf'] = this.codtdf;
    if (this.balanca != null) {
      data['balanca'] = this.balanca.toJson();
    }
    if (this.dispositivo != null) {
      data['dispositivo'] = this.dispositivo.toJson();
    }
    if (this.nfce != null) {
      data['nfce'] = this.nfce.toJson();
    }
    if (this.create != null) {
      data['create'] = this.create.toJson();
    }
    if (this.update != null) {
      data['update'] = this.update.toJson();
    }
    if (this.delete != null) {
      data['delete'] = this.delete.toJson();
    }
    if (this.sat != null) {
      data['sat'] = this.sat.toJson();
    }
    if (this.impressora != null) {
      data['impressora'] = this.impressora.toJson();
    }
    data['guid'] = this.guid;
    data['tipo'] = this.tipo;
    return data;
  }
}

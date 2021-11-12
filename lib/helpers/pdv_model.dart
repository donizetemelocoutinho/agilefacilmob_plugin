

class PDVJasonCartao {
  int tipo;
  Null tefCaptura;

  PDVJasonCartao({this.tipo, this.tefCaptura});

  PDVJasonCartao.fromJson(Map<String, dynamic> json) {
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

class PDVJasonBalanca {
  int tipo;
  String porta;
  int velocidade;

  PDVJasonBalanca({this.tipo, this.porta, this.velocidade});

  PDVJasonBalanca.fromJson(Map<String, dynamic> json) {
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

class PDVJasonDispositivo {
  int coddispositivo;
  String nome;
  Null ip;
  Null versao;

  PDVJasonDispositivo({this.coddispositivo, this.nome, this.ip, this.versao});

  PDVJasonDispositivo.fromJson(Map<String, dynamic> json) {
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

class PDVJasonNfce {
  int codserie;

  PDVJasonNfce({this.codserie});

  PDVJasonNfce.fromJson(Map<String, dynamic> json) {
    codserie = json['codserie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codserie'] = this.codserie;
    return data;
  }
}

class PDVJasonCreate {
  int codusuario;
  String data;

  PDVJasonCreate({this.codusuario, this.data});

  PDVJasonCreate.fromJson(Map<String, dynamic> json) {
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

class PDVJasonDelete {
  Null codusuario;
  Null data;

  PDVJasonDelete({this.codusuario, this.data});

  PDVJasonDelete.fromJson(Map<String, dynamic> json) {
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

class PDVJasonSat {
  String marca;
  String modelo;
  String numeroSerie;
  String versao;
  String codigoAtivacao;

  PDVJasonSat(
      {this.marca,
        this.modelo,
        this.numeroSerie,
        this.versao,
        this.codigoAtivacao});

  PDVJasonSat.fromJson(Map<String, dynamic> json) {
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

class PDVJasonImpressora {
  Null nome;
  int modelo;

  PDVJasonImpressora({this.nome, this.modelo});

  PDVJasonImpressora.fromJson(Map<String, dynamic> json) {
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

class PDVJason{
  int codpdv;
  int numero;
  String chave;
  PDVJasonCartao cartao;
  int codtdf;
  PDVJasonBalanca balanca;
  PDVJasonDispositivo dispositivo;
  PDVJasonNfce nfce;
  PDVJasonCreate create;
  PDVJasonCreate update;
  PDVJasonDelete delete;
  PDVJasonSat sat;
  PDVJasonImpressora impressora;
  String guid;
  int tipo;

  PDVJason(
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

  PDVJason.fromJson(Map<String, dynamic> json) {
    codpdv = json['codpdv'];
    numero = json['numero'];
    chave = json['chave'];
    cartao =
    json['cartao'] != null ? new PDVJasonCartao.fromJson(json['cartao']) : null;
    codtdf = json['codtdf'];
    balanca = json['balanca'] != null ? new PDVJasonBalanca.fromJson(json['balanca']) : null;
    dispositivo = json['dispositivo'] != null ? new PDVJasonDispositivo.fromJson(json['dispositivo']) : null;
    nfce = json['nfce'] != null ? new PDVJasonNfce.fromJson(json['nfce']) : null;
    create = json['create'] != null ? new PDVJasonCreate.fromJson(json['create']) : null;
    update = json['update'] != null ? new PDVJasonCreate.fromJson(json['update']) : null;
    delete = json['delete'] != null ? new PDVJasonDelete.fromJson(json['delete']) : null;
    sat = json['sat'] != null ? new PDVJasonSat.fromJson(json['sat']) : null;
    impressora = json['impressora'] != null ? new PDVJasonImpressora.fromJson(json['impressora']) : null;
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

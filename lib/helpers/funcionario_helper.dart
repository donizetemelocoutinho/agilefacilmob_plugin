
import 'package:agilefacil_mob/helpers/pessoa_helper.dart';
import 'package:intl/intl.dart';

class Funcionario extends PessoaFisica{
  int codigo;
  DateTime admissao;
  DateTime demissao;
  String ativo;
  Comissao comissao = Comissao();
  String funcao;



  Funcionario.fromMap(Map map) {
    super.fromMap(map);

    codigo = map['codigo'];

    if (map['admissao'] != null)
      admissao =  DateTime.parse(map['admissao']);

    if (map['demissao'] != null)
      demissao =  DateTime.parse(map['demissao']);

    ativo = map['ativo'];
    comissao = Comissao.fromMap(map['comissao']);
    funcao = map['funcao'];
  }

  @override
  Map<String,dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map["codigo"] = codigo;
    map["admissao"] = admissao != null ? DateFormat('yyyy-MM-dd').format(admissao) : null;
    map["demissao"] = demissao != null ? DateFormat('yyyy-MM-dd').format(demissao) : null;
    map["ativo"] = ativo;
    map["comissao"] = comissao.toMap();
    map["funcao"] = funcao;
  }

}

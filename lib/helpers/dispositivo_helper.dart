import 'package:http/http.dart' as http;
import 'helper.dart';
import 'api_helper.dart';

class DispositivoHelper{

  Future<Map> Cadastrar(context,String cpfcnpj, String login,String senha,String celular,String descricao) async {
    Map<String,dynamic> jo = Map();
    jo['cpfcnpj'] = cpfcnpj;
    jo['login'] = login;
    jo['senha'] = senha;
    jo['celular'] = celular;
    jo['id'] = await Helper.getId();
    jo['descricao'] = descricao;
    jo['guid'] = Helper.newGuid();
    jo['fcm_token'] = Helper.fcm_token;
    ApiHelper api = ApiHelper();
    
    return await api.post("dispositivo/cadastrar", jo, params: {});
  }


}
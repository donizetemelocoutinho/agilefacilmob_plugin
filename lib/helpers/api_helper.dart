import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ApiHelper{

  static const _url_api = "api.agilefacil.com.br";

  Future<Map> get(String service,{Map<String, dynamic> params}) async {
    String url = "";
    if (params != null)
      url = Uri.https(_url_api,"/api/v1/" + service,params).toString();
    else
      url = Uri.https(_url_api,"/api/v1/" + service).toString();

    var response = await http.get(url);
    var jr = convert.jsonDecode(response.body);
    return jr;
  }

  Future<Map> post(String service,Map map,{Map<String, dynamic> params}) async {
    String url = "";
    if (params != null)
      url = Uri.https(_url_api,"/api/v1/" + service,params).toString();
    else
      url = Uri.https(_url_api,"/api/v1/" + service).toString();

    var response = await http.post(url,body: map);
    return convert.jsonDecode(response.body);
  }

}
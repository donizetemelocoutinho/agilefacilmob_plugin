import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper{

  static const _url_api = "api.agilefacil.com.br";

  Future<dynamic> get(String service,{Map<String, dynamic> params}) async {
    Uri url;
    if (params != null)
      url = Uri.https(_url_api,"/api/v1/" + service,params);
    else
      url = Uri.https(_url_api,"/api/v1/" + service);

    var response = await http.get(url);
    var jr = jsonDecode(response.body);
    return jr;
  }

  Future<dynamic> post(String service,Map<String,dynamic> map,{Map<String, String> params}) async {
    Uri url;
    if (params != null)
      url = Uri.https(_url_api,"/api/v1/" + service,params);
    else
      url = Uri.https(_url_api,"/api/v1/" + service);

    var response = await http.post(url,body: jsonEncode(map),headers: {"content-type": "application/json"});
    return jsonDecode(response.body);
  }

}
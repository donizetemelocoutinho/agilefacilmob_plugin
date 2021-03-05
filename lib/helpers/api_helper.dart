import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ApiHelper{

  static const _url_api = "api.agilefacil.com.br";

  Future<Map> get(String service,{Map<String, dynamic> params}) async {
    Uri url;
    if (params != null)
      url = Uri.https(_url_api,"/api/v1/" + service,params);
    else
      url = Uri.https(_url_api,"/api/v1/" + service);

    var response = await http.get(url);
    var jr = convert.jsonDecode(response.body);
    return jr;
  }

  Future<Map> post(String service,Map<String,dynamic> map,{Map<String, String> params}) async {
    Uri url;
    if (params != null)
      url = Uri.https(_url_api,"/api/v1/" + service,params);
    else
      url = Uri.https(_url_api,"/api/v1/" + service);

    var response = await http.post(url,body: map);
    return convert.jsonDecode(response.body);
  }

}
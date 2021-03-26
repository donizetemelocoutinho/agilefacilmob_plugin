import 'package:flutter/material.dart';

import 'api_helper.dart';

class AclHelper{

  Future<bool> allow({@required String acl,@required String api_token,@required String operacao, String observacaos}) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> params = {};
    Map r = await api.get("loja/acl/allow", params: params);

  }

}
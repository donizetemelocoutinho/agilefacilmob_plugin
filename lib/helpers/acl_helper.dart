import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:agilefacil_mob/ui/acl_login.dart';
import 'package:flutter/material.dart';

class AclHelper{

  int codloja;
  String acl;
  String api_token;
  String operacao;
  String? observacao;
  BuildContext context;

  AclHelper({required this.context,required this.codloja,required this.acl,required this.api_token,required this.operacao, this.observacao});

  Future<Map> _allow() async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> params = {"codloja": codloja.toString(),"api_token":api_token,"acl" : acl};
    Map r = await api.get("loja/acl/allow", params: params);
    return r;
  }

  Future<bool?> _autentic() async{
    bool allow = await Navigator.push(context, MaterialPageRoute(builder: (context) => AclLogin(codloja: codloja, acl: acl, operacao: operacao,observacao: observacao)));
    return (allow != false) ? allow : false;
  }

  Future<bool?> allow() async {
    Map r = await _allow();
    if (r["id"] == 0) {
      if (r["force_login"] == "N")
        return true;
      else
        return await _autentic();
    } else {
      return await _autentic();
    }
  }
}
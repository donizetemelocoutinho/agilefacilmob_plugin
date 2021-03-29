import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:agilefacil_mob/helpers/helper.dart';
import 'package:agilefacil_mob/helpers/usuario_helper.dart';
import 'package:flutter/material.dart';

class AclLogin extends StatefulWidget {


  int codloja;
  String acl;
  String operacao;
  String observacao;


  AclLogin({@required this.codloja,@required this.acl,@required this.operacao, this.observacao});


  @override
  _AclLoginState createState() => _AclLoginState();
}

class _AclLoginState extends State<AclLogin> {

  TextEditingController _login = TextEditingController();
  TextEditingController _senha = TextEditingController();
  TextEditingController _justificativa = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.operacao),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _getBody(context),
        ),
      )
    );
  }

  Widget _getBody(BuildContext context){
    return Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment : CrossAxisAlignment.stretch,
          children: <Widget>[
            if (widget.observacao != null)
              Text(widget.observacao != null ? widget.observacao : ""),
            if (widget.observacao != null)
              Divider(),
            TextField(
              textAlignVertical: TextAlignVertical.center, autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              controller: _login,
              decoration: InputDecoration(
                hintText: 'Usuário',
                suffixIcon: Icon(Icons.person,color: Theme.of(context).accentColor),
                border: new OutlineInputBorder(),
                filled: true,
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
            Divider(),
            TextField(
                textAlignVertical: TextAlignVertical.center, autofocus: true,
                obscureText: true,
                obscuringCharacter: "*",
                controller: _senha,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  suffixIcon: Icon(Icons.lock_outline,color: Theme.of(context).accentColor),
                  border: new OutlineInputBorder(),
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 10),
                )
            ),
            Divider(),
            TextField(
                textAlignVertical: TextAlignVertical.center, autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _justificativa,
                decoration: InputDecoration(
                  hintText: 'Escreva uma justificativa...',
                  suffixIcon: Icon(Icons.description,color: Theme.of(context).accentColor),
                  border: new OutlineInputBorder(),
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 10),
                )
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget> [
                  Expanded(
                      child: Container(padding: EdgeInsets.only(right: 4.0),
                          child: ElevatedButton(
                              onPressed: () async {
                                UsuarioApi u = UsuarioApi();
                                Map ru = await u.Autenticar(Helper.loja["cpfcnpj"], _login.text, _senha.text);
                                if (ru["id"] == 0) {
                                  bool allow = await _allow(ru["api_token"]);
                                  if (allow)
                                    Navigator.pop(context,true);
                                  else {
                                    SnackBar snackBar = SnackBar(content: Text("Usuário sem permissão...",style: TextStyle(fontSize: 15.0)),backgroundColor: Colors.red,duration: Duration(seconds: 5));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }

                                } else {
                                  SnackBar snackBar = SnackBar(content: Text(ru["msg"],style: TextStyle(fontSize: 15.0)),backgroundColor: Colors.red,duration: Duration(seconds: 5));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }

                              },
                              child: Text("Liberar",style: TextStyle(color: Colors.white))
                          )
                      )
                  ),
                  Expanded(child: Container(padding: EdgeInsets.only(right: 4.0), child: ElevatedButton(
                    onPressed: (){
                    },
                    child: Text("Solicitar liberação",style: TextStyle(color: Colors.white)),
                  ))),
                ],
              )
            )
          ],
        )
    );
  }


  Future<bool> _allow(String api_token) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> params = {"codloja": widget.codloja.toString(),"api_token": api_token,"acl" : widget.acl};
    Map r = await api.get("loja/acl/allow", params: params);
    print(r);
    return (r["id"] == 0);
  }


}

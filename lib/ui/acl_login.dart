import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:agilefacil_mob/helpers/helper.dart';
import 'package:agilefacil_mob/helpers/usuario_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  TextEditingController _login = TextEditingController();
  TextEditingController _senha = TextEditingController();
  TextEditingController _justificativa = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor,
        title: Text("Controle de Acesso", style: TextStyle(fontSize: 22,fontFamily: 'Secular',color: Colors.white)),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _createBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createBody(){
    return Column(
      children: <Widget>[
        _getOperacao(),
        _getUsuario(),
        _getSenha(),
        _getJustificativa(),
        _buttonLiberar()
      ],
    );
  }

  Widget _getOperacao(){

    if (widget.operacao.length > 100)
      widget.operacao = widget.operacao.substring(0, (widget.operacao.length < 30 ? widget.operacao.length : 100)) + "...";

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 25, right: 25, bottom: 3.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: widget.operacao,
                    style: TextStyle(fontSize: 21, color: Color(0xff2a2d32) ),
                  ),
                ),
              ),
            ],
          ),
          if (widget.observacao != null)
            Text(widget.observacao != null ? widget.observacao : ""),
          if (widget.observacao != null)
            Divider(),
        ],
      ),
    );
  }

  Widget _getUsuario(){
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Padding(padding: const EdgeInsets.only(top: 20.0, left: 26, bottom: 3.0),
            child: (Text("Usuário",
              style: TextStyle(fontSize: 16.0, fontFamily: "Secular", color: Theme.of(context).secondaryHeaderColor), textAlign: TextAlign.left)
            ),
          ),
        ),
        Container(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: SizedBox(
                width: 200,
                height: 70,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(padding: EdgeInsets.only(left: 12.0, top: 10),
                    child: TextFormField(style: TextStyle(fontSize: 22.0, fontFamily: 'Secular', color: Colors.black),
                      decoration: InputDecoration(
                        suffixIcon: Padding(padding: const EdgeInsetsDirectional.only(end: 12.0),
                          child: Icon(
                            Icons.person_outline_outlined,
                            size: 28,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "Login",
                        hintStyle:
                        TextStyle(color: Colors.black26),
                        errorStyle: TextStyle(height: 0),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      controller: _login,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value == null || value.isEmpty)
                          return "Preencha o Usuário";
                      },
                      enabled: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getSenha(){
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Padding(padding: const EdgeInsets.only(top: 20.0, left: 26, bottom: 3.0),
            child: (Text("Senha",
              style: TextStyle(fontSize: 16.0, fontFamily: "Secular", color: Theme.of(context).secondaryHeaderColor), textAlign: TextAlign.left)
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: SizedBox(
              width: 200,
              height: 70,
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(padding: EdgeInsets.only(left: 12.0, top: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 22.0, fontFamily: 'Secular', color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                            child: Icon(
                                _obscureText ? Icons.remove_red_eye_outlined : Icons.lock_outlined,
                                size: 28,
                                color: Theme.of(context).secondaryHeaderColor
                            ),
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: "*",
                      hintStyle: TextStyle(color: Colors.black26),
                      errorStyle: TextStyle(height: 0),
                    ),
                    //textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.text,
                    obscureText: _obscureText,
                    obscuringCharacter: "*",
                    controller: _senha,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value == null || value.isEmpty)
                        return "Preencha a Senha";
                    },
                    enabled: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getJustificativa(){
    return Container(
      padding: EdgeInsets.only(top: 10, left: 25.0, right: 25.0, bottom: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: const EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text("Justificativa",style: TextStyle(fontSize: 15, fontFamily: 'Secular', color: Theme.of(context).secondaryHeaderColor)),
          ),
          _descJustificativa(),
        ],
      ),
    );
  }

  Widget _descJustificativa(){
    return SizedBox(height: 150,
      child: Container(decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.black12), borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: TextFormField(style: TextStyle(fontSize: 14.0, fontFamily: 'Secular', color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Informe a sua justificativa",
              hintStyle: TextStyle(color: Colors.black87),
              errorStyle: TextStyle(height: 0),
            ),
            keyboardType: TextInputType.text,
            textAlign: TextAlign.justify,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.sentences,
            controller: _justificativa,
            maxLines: null,
            enabled: true,
          ),
        ),
      ),
    );
  }

  Widget _buttonLiberar(){
    return Column(
      children: [
        Container(width: 309,height: 53,
          child: FloatingActionButton.extended(
            label: Text("Liberar", style: TextStyle(fontSize: 18.0)), backgroundColor: Theme.of(context).primaryColor,
            onPressed: () async {
              UsuarioApi u = UsuarioApi();
              Map ru = await u.Autenticar(Helper.loja.cpfcnpj, _login.text, _senha.text);
              //print(ru);
              if (ru["id"] == 0) {
                bool allow = await _allow(ru["usuario"]["api_token"]);
                if (allow)
                  Navigator.pop(context,true);
                else {
                  SnackBar snackBar = SnackBar(content: Text("Usuário sem permissão...",style: TextStyle(fontFamily: 'FreeSans',fontSize: 15.0),textAlign: TextAlign.center),backgroundColor: Colors.red,duration: Duration(seconds: 5));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

              } else {
                SnackBar snackBar = SnackBar(content: Text(ru["msg"],style: TextStyle(fontFamily: 'FreeSans',fontSize: 15.0),textAlign: TextAlign.center),backgroundColor: Colors.red,duration: Duration(seconds: 5));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

            },
          ),
        ),
      ],
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
                                Map ru = await u.Autenticar(Helper.loja.cpfcnpj, _login.text, _senha.text);
                                //print(ru);
                                if (ru["id"] == 0) {
                                  bool allow = await _allow(ru["usuario"]["api_token"]);
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
    //print(r);
    return (r["id"] == 0);
  }


}

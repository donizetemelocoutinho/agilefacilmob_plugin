import 'package:agilefacil_mob/helpers/db_counts.dart';
import 'package:agilefacil_mob/helpers/dispositivo_helper.dart';
import 'package:flutter/material.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:convert' as convert;

import 'package:flutter/services.dart';

class LoginRegister extends StatefulWidget {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  final DBCount count;
  LoginRegister({this.count});

  @override
  _LoginRegisterState createState() => _LoginRegisterState();

}

class _LoginRegisterState extends State<LoginRegister> {
  DBCount _editedCount;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final _cnpjController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _celularController = TextEditingController();
  final _descricaoController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if (widget.count == null) {
      _editedCount = DBCount();
    } else {
      _editedCount = DBCount.fromMap(widget.count.toMap());

      _cnpjController.text = _editedCount.cpfcnpj;
      _usuarioController.text = _editedCount.login;
      _senhaController.text = _editedCount.senha;
      _celularController.text = _editedCount.celular;
      _descricaoController.text = _editedCount.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(title: Text("Registrar Usuário"),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_forever),
                tooltip: 'Excluir conta',
                onPressed: () {
                  DBCountsHelper cr = DBCountsHelper();
                  cr.delete(_editedCount.id);
                  Navigator.pop(context);
                },
              ),
            ],),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _salvar();
              },
              child: Icon(Icons.verified_user),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(top: 20,left: 12,right: 12),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      buildeTextField("CNPJ",controller: _cnpjController, icon: Icons.confirmation_number, keyboardType: TextInputType.numberWithOptions(decimal: false), onValidate: (value) {
                        if (value == null || value.isEmpty)
                          return "Preencha o cnpj";
                        else if (!(CNPJ.isValid(value) || CPF.isValid(value)))
                          return "Informe um CPF/CNPJ válido";
                      }),
                      Divider(),
                      buildeTextField("Usuário", controller: _usuarioController,icon: Icons.person,onValidate: (String value){
                        if (value == null || value.isEmpty)
                          return "Preencha o Usuário";
                      }),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                            obscureText: _obscureText,
                            obscuringCharacter: "*",
                            controller: _senhaController,
                            validator: (String value){
                              if (value == null || value.isEmpty)
                                return "Preencha a Senha...";
                            },
                            decoration: InputDecoration(
                                labelText: "Senha",
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.lock)),
                          )),
                          FlatButton(
                              minWidth: 30.0,
                              onPressed: () {
                                setState(() {
                                  _obscureText = ! _obscureText;
                                });
                              },
                              child: Icon(Icons.remove_red_eye))
                        ],
                      ),
                      Divider(),
                      buildeTextField("Celular",controller: _celularController,
                          icon: Icons.phone, keyboardType: TextInputType.phone,
                          onValidate: (String value) {
                        if (value == null || value.isEmpty)
                          return "Preencha o celular!";
                        else if (value.length < 10 || value.length > 11)
                          return "Informe um celular com DDD correto";
                      }),
                      Divider(),
                      buildeTextField("Descrição", controller: _descricaoController,icon: Icons.description),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0,left: 40.0),
                          child: Container(
                            height: 50.0,
                            child: RaisedButton(
                              onPressed: () async{
                                ScanResult r = await BarcodeScanner.scan();
                                Map us = convert.jsonDecode(r.rawContent);

                                _cnpjController.text = us['cnpj'];
                                _usuarioController.text = us['login'];
                                _senhaController.text = us['pwd'];
                                _celularController.text = us['celular'];
                                _descricaoController.text = us['nome'];
                              },
                              child: Text("Ler QR-CODE"),
                            ),
                          ))
                    ]),
              ),
            )),
        onWillPop: null);
  }

  void _salvar() async{
    if (_formKey.currentState.validate()) {
      DispositivoHelper d = DispositivoHelper();
      Map mr = await d.Cadastrar(context, _cnpjController.text, _usuarioController.text, _senhaController.text, _celularController.text, _descricaoController.text);
      if (mr["id"] == 0)
      {
        if (mr["auth"]["id"] == 0)
        {
          DBCountsHelper cr = DBCountsHelper();
          DBCount count = DBCount();
          count.cpfcnpj = mr["auth"]["loja"]["cpfcnpj"];
          count.codloja= mr["auth"]["loja"]["codloja"];
          count.login= mr["auth"]["usuario"]["login"];
          count.senha= mr["auth"]["usuario"]["senha"];
          count.codusuario= mr["auth"]["usuario"]["codusuario"];
          count.loginfotolink= mr["auth"]["usuario"]["fotolink"];
          count.empresalogolink= mr["auth"]["usuario"]["linklogo"];
          count.apitoken = mr["auth"]["usuario"]["api_token"];
          count.loja = mr["auth"]["loja"];
          count.usuario = mr["auth"]["usuario"];
          count.celular = _celularController.text;
          count.descricao = _descricaoController.text;
          await cr.save(count);
          Navigator.pop(context,_editedCount);
        }
      } else {
        SnackBar snackBar = SnackBar(content: Text(mr["msg"],style: TextStyle(fontSize: 15.0)),backgroundColor: Colors.red,duration: Duration(seconds: 5));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Widget buildeTextField(String label, {String prefix, TextEditingController controller,
      TextInputType keyboardType, Function onChanged, FocusNode focus,
      Function onValidate, bool pwd, IconData icon}) {
    Icon i = null;
    if (icon != null) i = Icon(icon);

    return TextFormField(
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixText: prefix,
          icon: i),
      controller: controller,
      focusNode: focus,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: onValidate,
    );
  }
}

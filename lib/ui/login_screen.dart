import 'dart:developer';
import 'package:agilefacil_mob/helpers/db_counts.dart';
import 'package:agilefacil_mob/helpers/helper.dart';
import 'package:agilefacil_mob/helpers/usuario_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  final String route;
  LoginScreen({this.route});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DBCountsHelper helper = DBCountsHelper();
  List<DBCount> counts = List();

  DBCount _selectedCount = null;

  final _senhaController = TextEditingController();
  final _senhaFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _getAllCounts();
  }

  void _getAllCounts() {
    helper.getAll().then((list) {
      setState(() {
        counts = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 150.0),
              child: Text("Agile Fácil Master",
                  style: TextStyle(fontSize: 25.0, color: Colors.blueAccent))),
          Expanded(
              child: Center(
                  child: IgnorePointer(
                      ignoring: false,
                      child: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: ListView.builder(
                              padding: EdgeInsets.all(10.0),
                              itemCount: counts.length,
                              itemBuilder: (context, index) {
                                return _countCard(context, index);
                              })))))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          onPressed: () {
            _showCount(context);
          },
          label: Text("Cadastrar nova conta")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _countCard(BuildContext context, int index) {
    return GestureDetector(
      child: InkWell(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0),
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: counts[index].loginfotolink != null
                        ? Image.network(counts[index].loginfotolink).image
                        : AssetImage("images/photo.png")),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(counts[index].login ?? "",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(counts[index].cpfcnpj ?? "",
                          style: TextStyle(fontSize: 14.0))),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        _selectedCount = counts[index];
        _CapturarSenha(context);
      },
      onLongPress: () {
        _showCount(context, count: counts[index]);
      },
    );
  }

  void _showCount(BuildContext context, {DBCount count}) async {
    final recCount = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginRegister(count: count)));
    if (recCount != null) {
      if (count != null) {
        await helper.update(recCount);
      } else {
        await helper.save(recCount);
      }
    }
    await _getAllCounts();
  }

  void _CapturarSenha(context) {
    _senhaController.text = "";
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return  Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    obscureText: true,
                    obscuringCharacter: "*",
                    controller: _senhaController,
                    focusNode: _senhaFocus,
                    validator: (String value) {
                      if (value == null || value.isEmpty)
                        return "Preencha a Senha...";
                    },
                    decoration: InputDecoration(
                        labelText: "Digite a senha",
                        border: OutlineInputBorder()),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: (){
                            UsuarioApi u = UsuarioApi();
                            u.Autenticar(_selectedCount.cpfcnpj, _selectedCount.login, _selectedCount.login).then((value){
                                if (value["id"] == 0) {
                                  Helper.loja = value['loja'];
                                  Helper.usuario = value['usuario'];

                                  Navigator.pop(context);

                                  if (widget.route != null)
                                    Navigator.pushReplacementNamed(context, widget.route);
                                }
                                else {
                                  Navigator.pop(context);
                                  SnackBar snackBar = SnackBar(content: Text(value["msg"],style: TextStyle(fontSize: 15.0)),backgroundColor: Colors.red,duration: Duration(seconds: 5));
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }
                            });
                          },
                          child: Text("Entrar"),
                        ),
                      ))
                ]),
          );
        });
  }


}

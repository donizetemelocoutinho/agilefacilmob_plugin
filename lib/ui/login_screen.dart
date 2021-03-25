import 'package:agilefacil_mob/helpers/db_counts.dart';
import 'package:agilefacil_mob/helpers/helper.dart';
import 'package:agilefacil_mob/helpers/usuario_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/helper.dart';
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
  List<DBCount> counts = [];

  DBCount _selectedCount = null;

  final _senhaController = TextEditingController();
  final _senhaFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _getAllCounts();
  }

  void _getAllCounts() async{
    List<DBCount> ret = await helper.getAll();

    setState(() {
      counts = ret;
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
              child: Text(Helper.AppTitle, style: TextStyle(fontSize: 25.0, color: Theme.of(context).primaryColor))),
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
          backgroundColor: Theme.of(context).primaryColor,
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
                  Padding(padding: EdgeInsets.only(top: 10.0), child: Text(counts[index].login ?? "", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.only(top: 10.0), child: Text(counts[index].cpfcnpj ?? "", style: TextStyle(fontSize: 14.0))),
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
    await Navigator.push(context, MaterialPageRoute(builder: (context) => LoginRegister(count: count)));
    _getAllCounts();
  }

  void _CapturarSenha(context) {
    _senhaController.text = "";
    showModalBottomSheet(
        context: context,
        isScrollControlled:true,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(20.0),child: Icon(Icons.security_sharp,size: 80,color: Theme.of(context).accentColor)),
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
                          color: Theme.of(context).primaryColor,
                          onPressed: (){
                            UsuarioApi u = UsuarioApi();
                            u.Autenticar(_selectedCount.cpfcnpj, _selectedCount.login, _senhaController.text).then((value){
                              //print("Retorno...: $value");

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
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            });
                          },
                          child: Text("Entrar",style: TextStyle(color: Colors.white)),
                        ),
                      ))
                ]),
          );
        });
  }


}

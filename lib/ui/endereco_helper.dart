import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:agilefacil_mob/helpers/helper.dart';
import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:agilefacil_mob/ui/cidade_screen.dart';
import 'package:agilefacil_mob/ui/estado_screen.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

class EnderecoHelper{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Endereco endereco = new Endereco();

  final _cepController = TextEditingController();
  final _ufController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _referenciaController = TextEditingController();

  EnderecoHelper(Endereco endereco){
    this.endereco = endereco;
    _cepController.text = endereco.cep;
    _ufController.text = endereco.uf;
    _cidadeController.text = endereco.cidade;
    _bairroController.text = endereco.bairro;
    _logradouroController.text = endereco.logradouro;
    _numeroController.text = endereco.numero;
    _referenciaController.text = endereco.referencia;
  }

  void setValues(){
    endereco.cep = _cepController.text;
    endereco.uf = _ufController.text;
    endereco.cidade = _cidadeController.text;
    endereco.bairro = _bairroController.text;
    endereco.logradouro = _logradouroController.text;
    endereco.numero = _numeroController.text;
    endereco.referencia = _referenciaController.text;
  }

  Widget getEndereco(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextFormField(style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(labelText: "Cep",labelStyle: TextStyle(color: Theme.of(context).primaryColor)),
                    controller: _cepController,
                    keyboardType: TextInputType.numberWithOptions(decimal: false),
                    onChanged: (value){endereco.cep = value;},
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, CepInputFormatter()],
                  )
                ),
                IconButton(
                  icon: Icon(Icons.search,color: Theme.of(context).primaryColor,size: 20),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());

                    ApiHelper api = ApiHelper();
                    Map map = await api.get("common/getenderecocep",params: {"cep": _cepController.text});
                    if (map["id"] == 0){

                      endereco.cep = map["cep"];
                      endereco.logradouro = map["logradouro"];
                      endereco.referencia = map["complemento"];
                      endereco.codcidadeibge = int.parse(map["ibge"]);
                      endereco.bairro = map["bairro"];
                      endereco.cidade = map["localidade"];
                      endereco.codcidade;
                      endereco.uf = map["uf"];
                      endereco.numero = map["numero"] ?? _numeroController.text;

                      _logradouroController.text = endereco.logradouro;
                      _referenciaController.text = endereco.referencia;
                      _bairroController.text = endereco.bairro;
                      _cidadeController.text = endereco.cidade;
                      _ufController.text = endereco.uf;
                      _numeroController.text = endereco.numero;
                    }
                    else{
                      // SnackBar snackBar = SnackBar(content: Text(map["msg"],
                      //     style: TextStyle(fontSize: 15.0)),backgroundColor: Colors.red,duration: Duration(seconds: 2));
                      // Scaffold.of(context).showSnackBar(snackBar);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar( content: Text(map["msg"], style: TextStyle(fontSize: 15.0)),
                            backgroundColor: Colors.red, duration: Duration(seconds: 2)
                        )
                      );
                    }
                  }
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextFormField(style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(labelText: "Estado",labelStyle: TextStyle(color: Theme.of(context).primaryColor)),
                    controller: _ufController,
                    enabled: false
                  )
                ),
                IconButton(
                    icon: Icon(Icons.search,color: Theme.of(context).primaryColor, size: 20),
                    onPressed: () async{
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Estado estado = await Navigator.push(context, MaterialPageRoute(builder: (context) => EstadoScreen()));
                      if (estado.uf != _ufController.text) {
                        _ufController.text = estado.descricao;
                        _cidadeController.text = "";
                        endereco.uf = estado.uf;
                        endereco.cidade;
                        endereco.codcidade;
                        endereco.codcidadeibge;
                      }

                    })
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextFormField(style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(labelText: "Cidade",labelStyle: TextStyle(color: Theme.of(context).primaryColor)),
                    controller: _cidadeController,
                    enabled: false,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search,color: Theme.of(context).primaryColor,size: 20),
                  onPressed: () async{
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Cidade cidade = await Navigator.push(context, MaterialPageRoute(builder: (context) => CidadeScreen(endereco.uf)));
                    _cidadeController.text = cidade.descricao;
                    _ufController.text = cidade.uf;

                    endereco.uf = cidade.uf;
                    endereco.cidade = cidade.descricao;
                    endereco.codcidade = cidade.codcidade;
                    endereco.codcidadeibge = cidade.codcidadeibge;
                  }
                )
              ],
            ),
          ),
          TextFormField(style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
            decoration: InputDecoration(labelText: "Bairro",labelStyle: TextStyle(color: Theme.of(context).primaryColor)),
            controller: _bairroController,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextFormField(style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(labelText: "Logradouro",labelStyle: TextStyle(color: Theme.of(context).primaryColor)),
                    controller: _logradouroController,
                  )
                )
              ],
            ),
          ),
          TextFormField(style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
            decoration: InputDecoration(labelText: "Nº",labelStyle: TextStyle(color: Theme.of(context).primaryColor)),
            controller: _numeroController,
          ),
          TextFormField(style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
            decoration: InputDecoration(labelText: "Referencia",labelStyle: TextStyle(color: Theme.of(context).primaryColor)),
            controller: _referenciaController,
          ),
          Padding(padding: EdgeInsets.all(12.0),
            child: TextButton(
              child: Row(
                children: [
                  Text('Localização', style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor)),
                  const SizedBox(height: 5),
                  Icon(Icons.location_on_outlined,color: Theme.of(context).primaryColor),
                ],
              ),
              onPressed: () async {
                // ApiHelper api = ApiHelper();
                // Map ret = await api.get("common/geo",params: {"uf": endereco.uf,"cidade": endereco.cidade,"logradouro": endereco.logradouro,"numero": endereco.numero});
                // if (ret["id"] == 0){
                //   Helper.navigateTo(ret[locations[0]], ret[locations[1]]);
                //   print('depois $locations');
                // }
                List<Location> locations = await locationFromAddress
                  ("${endereco.logradouro} " + "${endereco.numero} - " + "${endereco.bairro}, " + "${endereco.cidade} - " + "${endereco.uf}");
                Helper.Maps(locations[0].latitude, locations[0].longitude);
              },
            ),
          ),
        ],
      ),
    );
  }
}